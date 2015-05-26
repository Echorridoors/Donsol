//
//  InterfaceController.swift
//  Donsol WatchKit Extension
//
//  Created by Patrick Winchell on 5/5/15.
//  Copyright (c) 2015 Patrick Winchell. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController
{
    @IBOutlet var titleGroup:WKInterfaceGroup?
    
    @IBOutlet var startButton:WKInterfaceButton?
    @IBOutlet var aboutButton:WKInterfaceButton?
    @IBOutlet var howToButton:WKInterfaceButton?
    
    @IBOutlet var gameGroup:WKInterfaceGroup?
    
    @IBOutlet var passButton:WKInterfaceButton?
    @IBOutlet var TLBaseCard:WKInterfaceButton?
    @IBOutlet var TLBaseOuterGroup:WKInterfaceGroup?
    @IBOutlet var TLBaseInnerGroup:WKInterfaceGroup?
    @IBOutlet var TLBaseLabel:WKInterfaceLabel?
    
    @IBOutlet var TRBaseCard:WKInterfaceButton?
    @IBOutlet var TRBaseOuterGroup:WKInterfaceGroup?
    @IBOutlet var TRBaseInnerGroup:WKInterfaceGroup?
    @IBOutlet var TRBaseLabel:WKInterfaceLabel?
    
    @IBOutlet var BLBaseCard:WKInterfaceButton?
    @IBOutlet var BLBaseOuterGroup:WKInterfaceGroup?
    @IBOutlet var BLBaseInnerGroup:WKInterfaceGroup?
    @IBOutlet var BLBaseLabel:WKInterfaceLabel?
    
    @IBOutlet var BRBaseCard:WKInterfaceButton?
    @IBOutlet var BRBaseOuterGroup:WKInterfaceGroup?
    @IBOutlet var BRBaseInnerGroup:WKInterfaceGroup?
    @IBOutlet var BRBaseLabel:WKInterfaceLabel?
    
    @IBOutlet var HealthLabel:WKInterfaceLabel?
    @IBOutlet var HealthHeart:WKInterfaceLabel?
    @IBOutlet var ShieldLabel:WKInterfaceLabel?
    @IBOutlet var DepthLabel:WKInterfaceLabel?
    
    @IBOutlet var ScoreLabel:WKInterfaceLabel?
    
    var TLCard:cardView!
    var TRCard:cardView!
    var BLCard:cardView!
    var BRCard:cardView!
    
    var cardHolders = [cardView]()
    
    var currentPlayerState:playerState!
    var tapper = doubleTapper()
    
    override func awakeWithContext(context: AnyObject?)
    {
        super.awakeWithContext(context)
        
        self.TLCard = cardView(baseCardView: self.TLBaseCard!, baseOuterGroup: self.TLBaseOuterGroup!,baseInnerGroup: self.TLBaseInnerGroup!, baseLabel: self.TLBaseLabel!)
        self.TRCard = cardView(baseCardView: self.TRBaseCard!, baseOuterGroup: self.TRBaseOuterGroup!,baseInnerGroup: self.TRBaseInnerGroup!, baseLabel: self.TRBaseLabel!)
        self.BLCard = cardView(baseCardView: self.BLBaseCard!, baseOuterGroup: self.BLBaseOuterGroup!,baseInnerGroup: self.BLBaseInnerGroup!, baseLabel: self.BLBaseLabel!)
        self.BRCard = cardView(baseCardView: self.BRBaseCard!, baseOuterGroup: self.BRBaseOuterGroup!,baseInnerGroup: self.BRBaseInnerGroup!, baseLabel: self.BRBaseLabel!)
        
        self.cardHolders.append(self.TLCard)
        self.cardHolders.append(self.TRCard)
        self.cardHolders.append(self.BLCard)
        self.cardHolders.append(self.BRCard)
        
        self.setTitle("Donsol")
        if (self.continueGame() == false)
        {
            self.gameGroup?.setHidden(true)
            self.titleGroup?.setHidden(false)
        }
        self.setHighScore(0)
    }
    
    override func willActivate()
    {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate()
    {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        if (self.currentPlayerState != nil)
        {
            let data = NSKeyedArchiver.archivedDataWithRootObject(self.currentPlayerState)
            NSUserDefaults.standardUserDefaults().setObject(data, forKey: "playerState")
        }
        else
        {
            NSUserDefaults.standardUserDefaults().removeObjectForKey("playerState")
        }
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func setHighScore(newScore: Int)
    {
        var currentScore = NSUserDefaults.standardUserDefaults().integerForKey("score")
        
        if (newScore > currentScore)
        {
            NSUserDefaults.standardUserDefaults().setInteger(newScore, forKey: "score")
            NSUserDefaults.standardUserDefaults().synchronize()
            currentScore = newScore
        }
        self.syncScore()
        
        self.ScoreLabel?.setText(String(currentScore))
    }
    
    func syncScore()
    {
        var highScore: Int = NSUserDefaults.standardUserDefaults().integerForKey("score")
        WKInterfaceController.openParentApplication(["score":highScore], reply:
        {
            [weak self] (reply: [NSObject : AnyObject]!, error:NSError!) -> Void in
            if let replyScore = reply["score"] as? Int
            {
                if(replyScore > highScore)
                {
                    self?.setHighScore(replyScore)
                }
            }
            
        })
    }
    
    func continueGame() -> Bool
    {
        if let data = NSUserDefaults.standardUserDefaults().objectForKey("playerState") as? NSData {
            NSUserDefaults.standardUserDefaults().removeObjectForKey("playerState")
            if let state = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? playerState
            {
                if ((state.health <= 0) || (state.score == 0))
                {
                    return false
                }
                self.currentPlayerState = state
                self.gameGroup?.setHidden(false)
                self.titleGroup?.setHidden(true)
                loadRoom()
                return true
            }
        }
        return false
    }
    
    func setUp()
    {
        NSUserDefaults.standardUserDefaults().removeObjectForKey("playerState")
        self.gameGroup?.setHidden(false)
        self.titleGroup?.setHidden(true)
        self.currentPlayerState = playerState()
        
        loadRoom()
    }
    
    func endGame()
    {
        NSUserDefaults.standardUserDefaults().removeObjectForKey("playerState")
        self.setHighScore(self.currentPlayerState.score)
        self.currentPlayerState = playerState()
        self.gameGroup?.setHidden(true)
        self.titleGroup?.setHidden(false)
    }
    
    func loadRoom()
    {
        self.TLCard.currentCard = nil
        self.TRCard.currentCard = nil
        self.BLCard.currentCard = nil
        self.BRCard.currentCard = nil
        
        var cards = self.currentPlayerState.pullCards()
        
        if (cards.count > 0)
        {
            for i in 0...3
            {
                self.cardHolders[i].currentCard = nil
                if (cards.count > i)
                {
                    self.cardHolders[i].currentCard = cards[i]
                }
            }
            self.displayPlayerState()
        }
        else
        {
            self.endDon()
        }
    }
    
    func leaveRoom()
    {
        self.currentPlayerState.leaveRoom()
        
        loadRoom()
    }
    
    func endDon()
    {
        self.currentPlayerState.endDon()
        self.loadRoom()
        self.presentControllerWithName("alertView", context: ["title":"Won","text":"Defeated the don","button":"Continue"])
    }
    
    func cardsInRoom() -> Int
    {
        return self.currentPlayerState.cardsInRoom
    }
    
    func roomSkippable() -> Bool
    {
        return self.currentPlayerState.isRoomSkippable
    }
    
    func displayPlayerState()
    {
        if (self.roomSkippable() == true)
        {
            self.passButton?.setEnabled(true)
            self.passButton?.setHidden(false)
            if(self.currentPlayerState.canShuffle == true)
            {
                self.passButton?.setTitle("\u{21BA}\u{0000FE0E}")
            }
            else if (self.cardsInRoom() > 1)
            {
                self.passButton?.setTitle("Run")
            }
            else
            {
                self.passButton?.setTitle("Pass")
            }
        }
        else
        {
            self.passButton?.setEnabled(false)
            self.passButton?.setHidden(true)
        }
        
        self.HealthLabel?.setText(String(self.currentPlayerState.health))
        
        if (self.currentPlayerState.lastPotion != 0)
        {
            self.HealthHeart?.setTextColor(UIColor(red: 1.0, green: 0.5, blue: 0.5, alpha: 1))
            self.HealthLabel?.setTextColor(UIColor(red: 1.0, green: 0.5, blue: 0.5, alpha: 1))
        }
        else
        {
            self.HealthHeart?.setTextColor(UIColor.redColor())
            self.HealthLabel?.setTextColor(UIColor.redColor())
        }
        
        var shieldString = String(self.currentPlayerState.shield)
        if (self.currentPlayerState.lastShield != 0)
        {
            shieldString += "/" + String(self.currentPlayerState.lastShield)
        }
        self.ShieldLabel?.setText(shieldString)
        self.DepthLabel?.setText(String(self.currentPlayerState.score % 54))
        
        if (self.currentPlayerState.health == 0)
        {
            endGame()
            self.presentControllerWithName("alertView", context: ["title":"Dead","text":"You Died","button":"Play again"])
            return
        }
        if (cardsInRoom() == 0)
        {
            let delta = Int64(0.05 * Double(NSEC_PER_SEC))
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW,delta), dispatch_get_main_queue())
                { () -> Void in
                    self.currentPlayerState.lastRun = 0
                    self.leaveRoom()
            }
        }
        
    }
    
    @IBAction func pass()
    {
        if (tapper.cantap(self.passButton!) == true) {
            if (self.cardsInRoom() > 1)
            {
                self.currentPlayerState.lastRun = 1
            }
            else
            {
                self.currentPlayerState.lastRun = 0
            }
            leaveRoom()
        }
    }
    
    func playCard(cardHolder:cardView)
    {
        if((cardHolder.baseCard != nil) && (tapper.cantap(cardHolder.baseCard!) == true))
        {
            cardHolder.baseCard?.setEnabled(false)
            if let thisCard = cardHolder.currentCard as card!
            {
                self.currentPlayerState.playCard(thisCard)
                cardHolder.currentCard = nil
                displayPlayerState()
            }
        }
    }
    
    @IBAction func TLCardPicked()
    {
        playCard(TLCard)
    }
    
    @IBAction func TRCardPicked()
    {
        playCard(TRCard)
    }
    
    @IBAction func BLCardPicked()
    {
        playCard(BLCard)
    }
    
    @IBAction func BRCardPicked()
    {
        playCard(BRCard)
    }
    
    @IBAction func startGame()
    {
        if (tapper.cantap(self.startButton!) == true)
        {
            self.setUp()
        }
    }
    
    @IBAction func about()
    {
        if (tapper.cantap(self.aboutButton!) == true)
        {
            self.presentControllerWithName("alertView", context: ["title":"About Donsol","text":"About text goes here","button":"Back"])
        }
    }
    
    @IBAction func howTo()
    {
        if (tapper.cantap(self.howToButton!) == true)
        {
            self.presentControllerWithName("alertView", context: ["title":"Howto","text":"Howto text goes here","button":"Back"])
        }
    }
}

class doubleTapper
{
    var myDict:[WKInterfaceButton : NSTimeInterval] = [WKInterfaceButton : NSTimeInterval]()
    func cantap(button:WKInterfaceButton) -> Bool
    {
        let now = NSDate.timeIntervalSinceReferenceDate()
        if let last = self.myDict[button] as NSTimeInterval!
        {
            if(now - last < 0.5)
            {
                return false
            }
        }
        self.myDict[button] = now
        return true
    }
}

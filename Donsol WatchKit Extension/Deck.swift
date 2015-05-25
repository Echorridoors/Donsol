//
//  Deck.swift
//  Donsol WatchKit Extension
//
//  Created by Patrick Winchell on 5/5/15.
//  Copyright (c) 2015 Patrick Winchell. All rights reserved.
//

import Foundation
import WatchKit

func shuffle<C: MutableCollectionType where C.Index == Int>(var list: C) -> C
{
    let c = count(list)
    for i in 0..<(c - 1)
    {
        let j = Int(arc4random_uniform(UInt32(c - i))) + i
        swap(&list[i], &list[j])
    }
    return list
}

extension Array
{
    mutating func removeObject<U: Equatable>(object: U) -> Bool
    {
        for (idx, objectToCompare) in enumerate(self) {
            if let to = objectToCompare as? U {
                if object == to {
                    self.removeAtIndex(idx)
                    return true
                }
            }
        }
        return false
    }
}


enum Suit : Int
{
    case Hearts
    case Diamonds
    case Clubs
    case Clovers
    case Joker
}

class cardView
{
    var baseCard:WKInterfaceButton?
    var outerGroup:WKInterfaceGroup?
    var innerGroup:WKInterfaceGroup?
    var baseLabel:WKInterfaceLabel?
    var currentCard:card?
        {
        didSet
        {
            self.setupCard()
        }
    }
    
    init(baseCardView:WKInterfaceButton,baseOuterGroup:WKInterfaceGroup,baseInnerGroup:WKInterfaceGroup,baseLabel:WKInterfaceLabel)
    {
        self.baseCard = baseCardView
        self.outerGroup = baseOuterGroup
        self.innerGroup = baseInnerGroup
        self.baseLabel = baseLabel
        self.setupCard()
    }
    
    func setupCard()
    {
        if (self.currentCard == nil)
        {
            self.outerGroup?.setBackgroundColor(UIColor.whiteColor())
            self.innerGroup?.setBackgroundColor(UIColor.blackColor())
            self.baseLabel?.setHidden(true)
            self.baseCard?.setEnabled(false)
        }
        else
        {
            self.outerGroup?.setBackgroundColor(self.currentCard?.borderColor())
            self.innerGroup?.setBackgroundColor(self.currentCard?.backgroundColor())
            self.baseLabel?.setHidden(false)
            self.baseLabel?.setAttributedText(self.currentCard?.coloredString())
            self.baseCard?.setEnabled(true)
        }
    }
}

struct card : Equatable
{
    var number:Int = 0
    var suit:Suit = Suit.Joker
    var value:Int
    {
        get
        {
            if (self.suit == Suit.Joker)
            {
                return 21
            }
            if (self.suit == Suit.Hearts || self.suit == Suit.Diamonds)
            {
                return min(11, self.number)
            }
            if (self.suit == Suit.Clovers || self.suit == Suit.Clubs)
            {
                switch self.number {
                case 12:
                    return 13
                case 13:
                    return 15
                case 14:
                    return 17
                default:
                    return self.number
                }
            }
            return self.number
        }
    }
    
    var cardNumber: Int = 0
    
    init(number: Int)
    {
        self.cardNumber = number
        self.number = (self.cardNumber % 13) + 2
        self.suit = Suit(rawValue: Int(self.cardNumber / 13))!
    }
    
    func typeString() -> String
    {
        switch self.number
        {
        case 11:
            return "J"
        case 12:
            return "Q"
        case 13:
            return "K"
        case 14:
            return "A"
        default:
            return ""
        }
    }
    
    func numberString() -> String
    {
        var tempString = ""
        switch self.suit
        {
        case .Joker:
            tempString += "\u{25C9}"
        case .Hearts:
            tempString += "\u{2665}"
        case .Clubs:
            tempString += "\u{2660}"
        case .Clovers:
            tempString += "\u{2663}"
        case .Diamonds:
            tempString += "\u{2666}"
        }
        
        return tempString + "\u{0000FE0E}\n" + String(self.value)
    }
    
    func color() -> UIColor
    {
        if (self.suit == Suit.Joker)
        {
            return UIColor.whiteColor()
        }
        else if (self.suit == Suit.Hearts || self.suit == Suit.Diamonds)
        {
            return UIColor.redColor()
        }
        return UIColor.blackColor()
    }
    
    func borderColor() -> UIColor
    {
        if (self.suit == Suit.Joker && self.number % 2 == 1)
        {
            return UIColor.whiteColor()
        }
        else if (self.suit == Suit.Hearts || self.suit == Suit.Diamonds)
        {
            return UIColor.redColor()
        }
        return UIColor.grayColor()
    }
    
    func backgroundColor() -> UIColor
    {
        if (self.suit == Suit.Joker)
        {
            if (self.number % 2 == 1)
            {
                return UIColor.redColor()
            }
            return UIColor.blackColor()
        }
        
        return UIColor.whiteColor()
    }
    
    func coloredString() -> NSAttributedString
    {
        return NSAttributedString(string: self.numberString(), attributes: [NSForegroundColorAttributeName : self.color()])
    }
}

func ==(lhs: card, rhs: card) -> Bool
{
    return (lhs.cardNumber == rhs.cardNumber)
}

class deck : NSObject, NSCoding
{
    
    struct constants
    {
        static let cardsKey = "cards"
        static let discardKey = "discard"
        static let currentCardsKey = "currentCards"
    }
    
    var cards = [card]()
    var discard = [card]()
    var currentCards = [card]()
    
    override init()
    {
        for i in 0...53
        {
            cards.append(card(number: i))
        }
        self.cards = shuffle(self.cards)
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init()
        self.cards = self.unStack(aDecoder.decodeObjectForKey(constants.cardsKey) as! [Int])
        self.discard = self.unStack(aDecoder.decodeObjectForKey(constants.discardKey) as! [Int])
        self.currentCards = self.unStack(aDecoder.decodeObjectForKey(constants.currentCardsKey) as! [Int])
    }
    
    func encodeWithCoder(aCoder: NSCoder)
    {
        aCoder.encodeObject(self.stack(self.cards), forKey: constants.cardsKey)
        aCoder.encodeObject(self.stack(self.discard), forKey: constants.discardKey)
        aCoder.encodeObject(self.stack(self.currentCards), forKey: constants.currentCardsKey)
    }
    
    func stack(cards:[card]) -> [Int]
    {
        var items = [Int]()
        
        for aCard in cards
        {
            items.append(aCard.cardNumber)
        }
        
        return items
    }
    
    func unStack(ints:[Int]) -> [card]
    {
        var cards = [card]()
        
        for anInt in ints
        {
            cards.append(card(number: anInt))
        }
        
        return cards
    }
    
    
    func pullCards() -> [card]
    {
        if (self.currentCards.count == 0)
        {
            self.currentCards = [card]()
            while (self.currentCards.count < 4 && self.cards.count > 0)
            {
                self.currentCards.append(cards.removeAtIndex(0))
            }
        }
        return self.currentCards
    }
    
    func discardCard(thisCard:card)
    {
        currentCards.removeObject(thisCard)
        self.discard.append(thisCard)
    }
    
    func returnCards(theseCards:[card])
    {
        for thisCard in theseCards
        {
            cards.append(thisCard)
            currentCards.removeObject(thisCard)
        }
    }
}

class playerState : NSObject, NSCoding
{
    
    struct constants
    {
        static let health = "health"
        static let shield = "shield"
        static let lastShield = "lastShield"
        static let lastPotion = "lastPotion"
        static let lastRun = "lastRun"
        static let score = "score"
        static let donCount = "donCount"
        static let deck = "deck"

    }
    
    var health:Int  = 21
    {
        didSet
        {
            if (self.health > 21)
            {
                
                self.health = 21
            }
            else if (self.health < 0)
            {
                
                self.health = 0
            }
        }
    }
    var shield:Int = 0
    var lastShield:Int = 0
    var lastPotion:Int = 0
    var lastRun:Int = 0
    var score:Int = 0
    var donCount:Int = 0
    private var deckCards:deck = deck()
    
    override init() {}
    
    required init(coder aDecoder: NSCoder)
    {
        super.init()
        self.deckCards = aDecoder.decodeObjectForKey(constants.deck) as! deck
        self.donCount = aDecoder.decodeIntegerForKey(constants.donCount)
        self.score = aDecoder.decodeIntegerForKey(constants.score)
        self.lastRun = aDecoder.decodeIntegerForKey(constants.lastRun)
        self.lastPotion = aDecoder.decodeIntegerForKey(constants.lastPotion)
        self.lastShield = aDecoder.decodeIntegerForKey(constants.lastShield)
        self.shield = aDecoder.decodeIntegerForKey(constants.shield)
        self.health = aDecoder.decodeIntegerForKey(constants.health)
    }
    
    func encodeWithCoder(aCoder: NSCoder)
    {
        aCoder.encodeObject(self.deckCards, forKey: constants.deck)
        aCoder.encodeInteger(self.donCount, forKey: constants.donCount)
        aCoder.encodeInteger(self.score, forKey: constants.score)
        aCoder.encodeInteger(self.lastRun, forKey: constants.lastPotion)
        aCoder.encodeInteger(self.lastPotion, forKey: constants.lastRun)
        aCoder.encodeInteger(self.lastShield, forKey: constants.lastShield)
        aCoder.encodeInteger(self.shield, forKey: constants.shield)
        aCoder.encodeInteger(self.health, forKey: constants.health)
    }
    
    var cardsInRoom:Int
    {
        return self.deckCards.currentCards.count
    }
    
    var canShuffle:Bool
    {
            return (self.deckCards.discard.count == 0)
    }
    
    var isRoomSkippable:Bool
    {
        var cardsInRoom = self.cardsInRoom
        
        if(self.canShuffle == true)
        {
            return true
        }
        
        if(self.deckCards.cards.count == 0)
        {
            return false
        }
        
        if (cardsInRoom == 4 && self.lastRun == 0)
        {
            return true
        }
        
        if (cardsInRoom <= 1)
        {
            return true
        }
        
        return false
    }
    
    func endDon()
    {
        self.deckCards = deck()
        self.lastRun = 0
        self.donCount += 1
    }
    
    func leaveRoom()
    {
        if (self.canShuffle == true)
        {
            self.deckCards = deck()
        }
        else
        {
            self.deckCards.returnCards(self.deckCards.currentCards)
        }
    }
    
    func pullCards() -> [card]
    {
        return self.deckCards.pullCards()
    }
    
    func playCard(currentCard:card!)
    {
        if (currentCard.suit == Suit.Diamonds)
        {
            self.shield = currentCard.value
            self.lastShield = 0
        }
        else if (currentCard.suit == Suit.Hearts)
        {
            if (self.lastPotion == 0)
            {
                self.health += currentCard.value
            }
            self.lastPotion = 1
        }
        else
        {
            var monsterValue = currentCard.value
            if (self.lastShield != 0 && monsterValue >= self.lastShield)
            {
                self.shield = 0
                self.lastShield = 0
            }
            self.health -= max(0, monsterValue - self.shield)
            if (self.shield != 0)
            {
                self.lastShield = monsterValue
            }
        }
        if (currentCard.suit != Suit.Hearts)
        {
            self.lastPotion = 0
        }
        if (self.health > 0)
        {
            self.score += 1
        }
        self.deckCards.discardCard(currentCard)
    }
}

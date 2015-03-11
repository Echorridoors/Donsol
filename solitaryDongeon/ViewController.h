//
//  ViewController.h
//  solitaryDongeon
//
//  Created by Devine Lu Linvega on 2015-02-27.
//  Copyright (c) 2015 Devine Lu Linvega. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "Hand.h"
#import "User.h"
#import "Card.h"

@interface ViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIView *optionJewelView;
@property (weak, nonatomic) IBOutlet UIButton *runButton;
- (IBAction)runButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *quitButton;
- (IBAction)quitButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *optionToggleButton;
- (IBAction)optionToggleButton:(id)sender;

// Card 1
@property (weak, nonatomic) IBOutlet UIView *card1Wrapper;
@property (weak, nonatomic) IBOutlet UIButton *card1Button;
@property (weak, nonatomic) IBOutlet UIImageView *card1Image;

// Card 2
@property (weak, nonatomic) IBOutlet UIView *card2Wrapper;
@property (weak, nonatomic) IBOutlet UIButton *card2Button;
@property (weak, nonatomic) IBOutlet UIImageView *card2Image;

// Card 3
@property (weak, nonatomic) IBOutlet UIView *card3Wrapper;
@property (weak, nonatomic) IBOutlet UIButton *card3Button;
@property (weak, nonatomic) IBOutlet UIImageView *card3Image;

// Card 4
@property (weak, nonatomic) IBOutlet UIView *card4Wrapper;
@property (weak, nonatomic) IBOutlet UIButton *card4Button;
@property (weak, nonatomic) IBOutlet UIImageView *card4Image;

// Details
@property (weak, nonatomic) IBOutlet UILabel *lifeLabel;
@property (weak, nonatomic) IBOutlet UILabel *swordLabel;
@property (weak, nonatomic) IBOutlet UILabel *discardLabel;

@property (weak, nonatomic) IBOutlet UILabel *swordValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *lifeValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *discardValueLabel;

@property (weak, nonatomic) IBOutlet UIView *lifeBarWrapper;
@property (weak, nonatomic) IBOutlet UIView *swordBarWrapper;
@property (weak, nonatomic) IBOutlet UIView *discardBarWrapper;

@property (weak, nonatomic) IBOutlet UIView *lifeBar;
@property (weak, nonatomic) IBOutlet UIView *swordBar;
@property (weak, nonatomic) IBOutlet UIView *discardBar;
@property (weak, nonatomic) IBOutlet UIView *swordMalusBar;

@property (weak, nonatomic) IBOutlet UIView *cardsWrapper;

@end

Deck * playableDeck;
Hand * playableHand;
User * user;

NSMutableArray * discardPile;

int justHealed;
CGFloat margin;

CGRect card1Origin;
CGRect card2Origin;
CGRect card3Origin;
CGRect card4Origin;
CGRect jewelOrigin;
CGRect quitButtonOrigin;
CGRect runButtonOrigin;

int menuIsOpen;
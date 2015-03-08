//
//  ViewController.m
//  solitaryDongeon
//
//  Created by Devine Lu Linvega on 2015-02-27.
//  Copyright (c) 2015 Devine Lu Linvega. All rights reserved.
//

#import "ViewController.h"
#import "Deck.h"
#import "Hand.h"
#import "Card.h"
#import "User.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *runButton;
- (IBAction)runButton:(id)sender;


// Card 1
@property (weak, nonatomic) IBOutlet UIView *card1Wrapper;
@property (weak, nonatomic) IBOutlet UIButton *card1Button;
- (IBAction)card1Button:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *card1Image;

// Card 2
@property (weak, nonatomic) IBOutlet UIView *card2Wrapper;
@property (weak, nonatomic) IBOutlet UIButton *card2Button;
- (IBAction)card2Button:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *card2Image;

// Card 3
@property (weak, nonatomic) IBOutlet UIView *card3Wrapper;
@property (weak, nonatomic) IBOutlet UIButton *card3Button;
- (IBAction)card3Button:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *card3Image;

// Card 4
@property (weak, nonatomic) IBOutlet UIView *card4Wrapper;
@property (weak, nonatomic) IBOutlet UIButton *card4Button;
- (IBAction)card4Button:(id)sender;
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

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	playableHand = [[Hand alloc] init];
	playableDeck = [[Deck alloc] init];
	discardPile = [[NSMutableArray alloc] init];
	user = [[User alloc] init];
	
	[self template];
	[self draw];
	[self updateStage];
	
}

-(void)template
{
	NSLog(@"Template(%f %f)", self.view.frame.size.width, self.view.frame.size.height);
	
	CGRect screen = self.view.frame;
	CGFloat margin = self.view.frame.size.width/16;
	CGFloat cardWidth = (screen.size.width - (margin*2.5))/2;
	CGFloat cardHeight =(cardWidth * 88)/56;
	CGFloat verticalOffset = margin * 3;
	
	_card1Wrapper.frame = CGRectMake(margin, margin+verticalOffset, cardWidth, cardHeight);
	_card1Wrapper.backgroundColor = [UIColor whiteColor];
	_card1Image.frame = CGRectMake(0, 0, cardWidth, cardHeight);
	_card1Button.frame = CGRectMake(0, 0, cardWidth, cardHeight);
	_card1Wrapper.layer.cornerRadius = 10;
	_card1Wrapper.clipsToBounds = YES;
	
	_card2Wrapper.frame = CGRectMake((margin*1.5) + cardWidth, margin+verticalOffset, cardWidth, cardHeight);
	_card2Wrapper.backgroundColor = [UIColor whiteColor];
	_card2Image.frame = CGRectMake(0, 0, cardWidth, cardHeight);
	_card2Button.frame = CGRectMake(0, 0, cardWidth, cardHeight);
	_card2Wrapper.layer.cornerRadius = 10;
	_card2Wrapper.clipsToBounds = YES;
	
	_card3Wrapper.frame = CGRectMake(margin, (margin*1.5)+cardHeight+verticalOffset, cardWidth, cardHeight);
	_card3Wrapper.backgroundColor = [UIColor whiteColor];
	_card3Image.frame = CGRectMake(0, 0, cardWidth, cardHeight);
	_card3Button.frame = CGRectMake(0, 0, cardWidth, cardHeight);
	_card3Wrapper.layer.cornerRadius = 10;
	_card3Wrapper.clipsToBounds = YES;
	
	_card4Wrapper.frame = CGRectMake((margin*1.5) + cardWidth, (margin*1.5)+cardHeight+verticalOffset, cardWidth, cardHeight);
	_card4Wrapper.backgroundColor = [UIColor whiteColor];
	_card4Image.frame = CGRectMake(0, 0, 10, 10);
	_card4Button.frame = CGRectMake(0, 0, cardWidth, cardHeight);
	_card4Wrapper.layer.cornerRadius = 10;
	_card4Wrapper.clipsToBounds = YES;
	
	_lifeLabel.frame = CGRectMake(margin, margin*0.5, margin * 3, margin);
	_swordLabel.frame = CGRectMake(margin, (margin*1.5), margin * 3, margin);
	_discardLabel.frame = CGRectMake(margin, (margin*2.5), margin * 3, margin);
	
	_lifeLabel.text = @"HP";
	_swordLabel.text = @"AP";
	_discardLabel.text = @"XP";
	
	_lifeValueLabel.frame = CGRectMake(margin*2, margin*0.5, margin * 3, margin);
	_swordValueLabel.frame = CGRectMake(margin*2, (margin*1.5), margin * 3, margin);
	_discardValueLabel.frame = CGRectMake(margin*2, (margin*2.5), margin * 3, margin);
	
	_runButton.frame = CGRectMake(screen.size.width-(4*margin), (margin*0.5), margin*3, margin*3);
	_runButton.backgroundColor = [UIColor whiteColor];
	_runButton.layer.cornerRadius = 10;
	
	_lifeBarWrapper.frame = CGRectMake(margin*4, margin-(margin/8), screen.size.width-(2*margin)-(margin*7), margin/4);
	_lifeBarWrapper.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1];
	_lifeBarWrapper.clipsToBounds = YES;
	_lifeBarWrapper.layer.cornerRadius = margin/8;
	
	_lifeBar.backgroundColor = [UIColor redColor];
	
	_swordBarWrapper.frame = CGRectMake(margin*4, margin*2-(margin/8), screen.size.width-(2*margin)-(margin*7), margin/4);
	_swordBarWrapper.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1];
	_swordBarWrapper.clipsToBounds = YES;
	_swordBarWrapper.layer.cornerRadius = margin/8;
	
	_swordBar.backgroundColor = [UIColor redColor];
	
	_discardBarWrapper.frame = CGRectMake(margin*4, margin*3-(margin/8), screen.size.width-(2*margin)-(margin*7), margin/4);
	_discardBarWrapper.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1];
	_discardBarWrapper.clipsToBounds = YES;
	_discardBarWrapper.layer.cornerRadius = margin/8;
	
	_discardBar.backgroundColor = [UIColor redColor];
	
}

-(void)updateStage
{
	// TODO
	if( [[playableHand cards] count] < 1 ){
//		[user nextRoom];
//		[self draw];
	}
	
	[self.card1Button setTitle:[NSString stringWithFormat:@"%d%@",[[playableHand card:0] number],[[playableHand card:0] symbol]] forState:UIControlStateNormal];
	[self.card2Button setTitle:[NSString stringWithFormat:@"%d%@",[[playableHand card:1] number],[[playableHand card:1] symbol]] forState:UIControlStateNormal];
	[self.card3Button setTitle:[NSString stringWithFormat:@"%d%@",[[playableHand card:2] number],[[playableHand card:2] symbol]] forState:UIControlStateNormal];
	[self.card4Button setTitle:[NSString stringWithFormat:@"%d%@",[[playableHand card:3] number],[[playableHand card:3] symbol]] forState:UIControlStateNormal];
	
	[self.card1Button setTitleColor:[[playableHand card:0] color] forState:UIControlStateNormal];
	[self.card2Button setTitleColor:[[playableHand card:1] color] forState:UIControlStateNormal];
	[self.card3Button setTitleColor:[[playableHand card:2] color] forState:UIControlStateNormal];
	[self.card4Button setTitleColor:[[playableHand card:3] color] forState:UIControlStateNormal];
	
	self.swordValueLabel.text = [NSString stringWithFormat:@"%d(%d)",[user equip], [user malus]];
	self.lifeValueLabel.text = [NSString stringWithFormat:@"%d",[user life]];
	self.discardValueLabel.text = [NSString stringWithFormat:@"%d(%d)",(int)[discardPile count], [user room]];
	
	if( [[playableHand cards] count] == 1 || [[playableHand cards] count] == 4 ){
		NSLog(@"!   RUN | Enabled");
		self.runButton.enabled = true;
	}
	else{
		NSLog(@"!   RUN | Disabled");
		self.runButton.enabled = false;
	}
	
	self.swordBar.clipsToBounds = true;
	
	CGFloat healthBar = (([user life] * self.lifeBarWrapper.frame.size.width)/21);
	CGFloat swordBar = (([user equip] * self.lifeBarWrapper.frame.size.width)/15);
	CGFloat swordMalusBar = (([user malus] * self.lifeBarWrapper.frame.size.width)/15);
	CGFloat discardBar = (((int)[discardPile count] * self.lifeBarWrapper.frame.size.width)/52);
	
	[UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
		self.lifeBar.frame = CGRectMake(0, 0, healthBar, self.lifeBarWrapper.frame.size.height);
		self.swordBar.frame = CGRectMake(0, 0, swordBar, self.swordBarWrapper.frame.size.height);
		self.swordMalusBar.frame = CGRectMake(0, 0, swordMalusBar, self.swordBarWrapper.frame.size.height);
		self.discardBar.frame = CGRectMake(0, 0, discardBar, self.swordBarWrapper.frame.size.height);
	} completion:^(BOOL finished){}];

}

# pragma mark - Choice

-(void)choice:(int)cardNumber
{
	NSString * cardData = [playableHand cardValue:cardNumber];
	Card * card = [[Card alloc] initWithString:cardData];
	
	NSLog(@"--------+-------------------");
	NSLog(@"!  CARD | %@ %d", [card type], [card number]);
	NSLog(@"--------+-------------------");
	
	// Check for trying to heal twice
	if( justHealed == 1 && [[card type] isEqualToString:@"H"] ){
		NSLog(@"x  HEAL | Cannot heal twice!");
		[discardPile addObject:[playableHand cardValue:cardNumber]];
		[playableHand discard:cardNumber];
		justHealed = 1;
	}
	else if( [[card type] isEqualToString:@"H"] ){
		[user gainLife:[card value]];
		// Manip cards
		[discardPile addObject:[playableHand cardValue:cardNumber]];
		[playableHand discard:cardNumber];
		justHealed = 1;
		
	}
	else if( [[card type] isEqualToString:@"D"] ){
		[user gainEquip:[card value]];
		// Manip cards
		[discardPile addObject:[playableHand cardValue:cardNumber]];
		[playableHand discard:cardNumber];
		[user setMalus:25];
		justHealed = 0;
	}
	else{
		// Malus
		if( [card value] >= [user malus] ){
			[user looseEquip];
			[self updateStage];
		}
		
		int battleDamage = ( [card value] - [user equip]) ;
		if( battleDamage < 0 ){ battleDamage = 0; }
		if( battleDamage > 0 ){ [user looseLife:battleDamage]; }
		
		[user setMalus:[card value]];
		
		// Manip cards
		[discardPile addObject:[playableHand cardValue:cardNumber]];
		[playableHand discard:cardNumber];
		justHealed = 0;
	}
	
	[user setEscape:0];
	[self updateStage];
}

-(void)draw
{
	NSLog(@"   VIEW | Draw");
	
	// Draw 4 cards
	
	if( [playableHand numberOfCards] == 0){
		[playableHand pickCard:[playableDeck pickCard]];
		[playableHand pickCard:[playableDeck pickCard]];
		[playableHand pickCard:[playableDeck pickCard]];
		[playableHand pickCard:[playableDeck pickCard]];
	}
	else if( [playableHand numberOfCards] == 1){
		[playableHand pickCard:[playableDeck pickCard]];
		[playableHand pickCard:[playableDeck pickCard]];
		[playableHand pickCard:[playableDeck pickCard]];
	}
	else if( [playableHand numberOfCards] == 2){
		[playableHand pickCard:[playableDeck pickCard]];
		[playableHand pickCard:[playableDeck pickCard]];
	}
	else if( [playableHand numberOfCards] == 3){
		[playableHand pickCard:[playableDeck pickCard]];
	}
	
	[self updateStage];
}

# pragma mark - Interactions

- (IBAction)runButton:(id)sender
{
	if([user escaped] == 1){
		NSLog(@"    RUN | Already escape");
		return;
	}
	
	if( [playableHand numberOfCards] < 2){
		NSLog(@"    RUN | Can run, less than 2 cards.");
	}
	else if( [playableHand numberOfCards] == 4){
		NSLog(@"    RUN | Can run, exactly 4 cards.");
	}
	else
	{
		NSLog(@"    RUN | too many cards left:%d",[playableHand numberOfCards]);
		return;
	}
	
	NSLog(@"   VIEW | Run Away! Discard %lu cards",(unsigned long)[[playableHand cards] count]);
	
	[user nextRoom];
	[user setEscape:1];
	
	// Put the cards in hand, back in the deck
	
	for (NSString* card in cardsInHand) {
		if( ![card isEqualToString:@"--"] ){
			[playableDeck addCard:card];
		}
	}
	[playableHand discard:0];
	[playableHand discard:1];
	[playableHand discard:2];
	[playableHand discard:3];
	
	[self draw];
}

- (IBAction)card1Button:(id)sender
{
	[self choice:0];
}

- (IBAction)card2Button:(id)sender
{
	[self choice:1];
}

- (IBAction)card3Button:(id)sender
{
	[self choice:2];
}

- (IBAction)card4Button:(id)sender
{
	[self choice:3];
}

# pragma mark - Defaults

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
	return YES;
}

@end

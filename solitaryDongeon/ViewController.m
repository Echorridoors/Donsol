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


@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self newGame];
	[self templateStart];
	[self template];
	[self draw];
	[self updateStage];
	[self hideMenu];
	
	
	// START
	[discardPile addObject:[playableHand cardValue:0]]; [playableHand discard:0];
	[discardPile addObject:[playableHand cardValue:1]]; [playableHand discard:1];
	[discardPile addObject:[playableHand cardValue:2]]; [playableHand discard:2];
	[discardPile addObject:[playableHand cardValue:3]]; [playableHand discard:3];
	[playableHand pickCard:[playableDeck pickCard]];
	[playableHand pickCard:[playableDeck pickCard]];
	[playableHand pickCard:[playableDeck pickCard]];
	[playableHand pickCard:[playableDeck pickCard]];
	
	[discardPile addObject:[playableHand cardValue:0]]; [playableHand discard:0];
	[discardPile addObject:[playableHand cardValue:1]]; [playableHand discard:1];
	[discardPile addObject:[playableHand cardValue:2]]; [playableHand discard:2];
	[discardPile addObject:[playableHand cardValue:3]]; [playableHand discard:3];
	[playableHand pickCard:[playableDeck pickCard]];
	[playableHand pickCard:[playableDeck pickCard]];
	[playableHand pickCard:[playableDeck pickCard]];
	[playableHand pickCard:[playableDeck pickCard]];
	
	[discardPile addObject:[playableHand cardValue:0]]; [playableHand discard:0];
	[discardPile addObject:[playableHand cardValue:1]]; [playableHand discard:1];
	[discardPile addObject:[playableHand cardValue:2]]; [playableHand discard:2];
	[discardPile addObject:[playableHand cardValue:3]]; [playableHand discard:3];
	[playableHand pickCard:[playableDeck pickCard]];
	[playableHand pickCard:[playableDeck pickCard]];
	[playableHand pickCard:[playableDeck pickCard]];
	[playableHand pickCard:[playableDeck pickCard]];
	
	[discardPile addObject:[playableHand cardValue:0]]; [playableHand discard:0];
	[discardPile addObject:[playableHand cardValue:1]]; [playableHand discard:1];
	[discardPile addObject:[playableHand cardValue:2]]; [playableHand discard:2];
	[discardPile addObject:[playableHand cardValue:3]]; [playableHand discard:3];
	[playableHand pickCard:[playableDeck pickCard]];
	[playableHand pickCard:[playableDeck pickCard]];
	[playableHand pickCard:[playableDeck pickCard]];
	[playableHand pickCard:[playableDeck pickCard]];
	
	[discardPile addObject:[playableHand cardValue:0]]; [playableHand discard:0];
	[discardPile addObject:[playableHand cardValue:1]]; [playableHand discard:1];
	[discardPile addObject:[playableHand cardValue:2]]; [playableHand discard:2];
	[discardPile addObject:[playableHand cardValue:3]]; [playableHand discard:3];
	[playableHand pickCard:[playableDeck pickCard]];
	[playableHand pickCard:[playableDeck pickCard]];
	[playableHand pickCard:[playableDeck pickCard]];
	[playableHand pickCard:[playableDeck pickCard]];
	
	[discardPile addObject:[playableHand cardValue:0]]; [playableHand discard:0];
	[discardPile addObject:[playableHand cardValue:1]]; [playableHand discard:1];
	[discardPile addObject:[playableHand cardValue:2]]; [playableHand discard:2];
	[discardPile addObject:[playableHand cardValue:3]]; [playableHand discard:3];
	[playableHand pickCard:[playableDeck pickCard]];
	[playableHand pickCard:[playableDeck pickCard]];
	[playableHand pickCard:[playableDeck pickCard]];
	[playableHand pickCard:[playableDeck pickCard]];
	
	[discardPile addObject:[playableHand cardValue:0]]; [playableHand discard:0];
	[discardPile addObject:[playableHand cardValue:1]]; [playableHand discard:1];
	[discardPile addObject:[playableHand cardValue:2]]; [playableHand discard:2];
	[discardPile addObject:[playableHand cardValue:3]]; [playableHand discard:3];
	[playableHand pickCard:[playableDeck pickCard]];
	[playableHand pickCard:[playableDeck pickCard]];
	[playableHand pickCard:[playableDeck pickCard]];
	[playableHand pickCard:[playableDeck pickCard]];
	
	[discardPile addObject:[playableHand cardValue:0]]; [playableHand discard:0];
	[discardPile addObject:[playableHand cardValue:1]]; [playableHand discard:1];
	[discardPile addObject:[playableHand cardValue:2]]; [playableHand discard:2];
	[discardPile addObject:[playableHand cardValue:3]]; [playableHand discard:3];
	[playableHand pickCard:[playableDeck pickCard]];
	[playableHand pickCard:[playableDeck pickCard]];
	[playableHand pickCard:[playableDeck pickCard]];
	[playableHand pickCard:[playableDeck pickCard]];
	
	[discardPile addObject:[playableHand cardValue:0]]; [playableHand discard:0];
	[discardPile addObject:[playableHand cardValue:1]]; [playableHand discard:1];
	[discardPile addObject:[playableHand cardValue:2]]; [playableHand discard:2];
	[discardPile addObject:[playableHand cardValue:3]]; [playableHand discard:3];
	[playableHand pickCard:[playableDeck pickCard]];
	[playableHand pickCard:[playableDeck pickCard]];
	[playableHand pickCard:[playableDeck pickCard]];
	[playableHand pickCard:[playableDeck pickCard]];
	
	[discardPile addObject:[playableHand cardValue:0]]; [playableHand discard:0];
	[discardPile addObject:[playableHand cardValue:1]]; [playableHand discard:1];
	[discardPile addObject:[playableHand cardValue:2]]; [playableHand discard:2];
	[discardPile addObject:[playableHand cardValue:3]]; [playableHand discard:3];
	[playableHand pickCard:[playableDeck pickCard]];
	[playableHand pickCard:[playableDeck pickCard]];
	[playableHand pickCard:[playableDeck pickCard]];
	[playableHand pickCard:[playableDeck pickCard]];
	
	[discardPile addObject:[playableHand cardValue:0]]; [playableHand discard:0];
	[discardPile addObject:[playableHand cardValue:1]]; [playableHand discard:1];
	[discardPile addObject:[playableHand cardValue:2]]; [playableHand discard:2];
	[discardPile addObject:[playableHand cardValue:3]]; [playableHand discard:3];
	[playableHand pickCard:[playableDeck pickCard]];
	[playableHand pickCard:[playableDeck pickCard]];
	[playableHand pickCard:[playableDeck pickCard]];
	[playableHand pickCard:[playableDeck pickCard]];
	
	[discardPile addObject:[playableHand cardValue:0]]; [playableHand discard:0];
	[discardPile addObject:[playableHand cardValue:1]]; [playableHand discard:1];
	[discardPile addObject:[playableHand cardValue:2]]; [playableHand discard:2];
	[discardPile addObject:[playableHand cardValue:3]]; [playableHand discard:3];
	[playableHand pickCard:[playableDeck pickCard]];
	[playableHand pickCard:[playableDeck pickCard]];
	[playableHand pickCard:[playableDeck pickCard]];
	[playableHand pickCard:[playableDeck pickCard]];
	
	[self updateStage];
	// END
}

-(void)newGame
{
	NSLog(@"   GAME | New Deck");
	playableHand = [[Hand alloc] init];
	playableDeck = [[Deck alloc] init];
	discardPile = [[NSMutableArray alloc] init];
	user = [[User alloc] init];
}

-(void)templateStart
{
	CGRect screen = self.view.frame;
	margin = self.view.frame.size.width/16;
	CGFloat cardWidth = (screen.size.width - (margin*2.5))/2;
	CGFloat cardHeight =(cardWidth * 88)/56;
	CGFloat verticalOffset = margin * 1.5;
	CGFloat third = (screen.size.width-(2*margin))/3;
	
	card1Origin = CGRectMake(margin, margin+verticalOffset, cardWidth, cardHeight);
	card2Origin = CGRectMake((margin*1.5) + cardWidth, margin+verticalOffset, cardWidth, cardHeight);
	card3Origin = CGRectMake(margin, (margin*1.5)+cardHeight+verticalOffset, cardWidth, cardHeight);
	card4Origin = CGRectMake((margin*1.5) + cardWidth, (margin*1.5)+cardHeight+verticalOffset, cardWidth, cardHeight);
	jewelOrigin = CGRectMake((screen.size.width/2)-(margin/4), card1Origin.origin.y + card1Origin.size.height, margin/2, margin/2);
	
	quitButtonOrigin = CGRectMake(margin, jewelOrigin.origin.y-(margin*0.25), cardWidth-(margin*0.5), margin*2);
	runButtonOrigin  = CGRectMake(jewelOrigin.origin.x+(1.25*margin), jewelOrigin.origin.y-(margin*0.25), cardWidth-(margin), margin*2);
	
	_lifeUpdateLabel.text = @"0";
	_lifeUpdateLabel.frame = CGRectMake(margin, margin*0.5, third-(margin/2), margin);
	_lifeUpdateLabel.alpha = 0;
	
	_swordUpdateLabel.text = @"0";
	_swordUpdateLabel.frame = CGRectMake((margin*2.25)+third, margin*0.5, third-(margin*1.5), margin);
	_swordUpdateLabel.alpha = 0;
	
	_discardUpdateLabel.text = @"0";
	_discardUpdateLabel.frame = CGRectMake((margin*3)+(third*2), margin*0.5, third-(margin*2), margin);
	_discardUpdateLabel.alpha = 0;
}

-(void)template
{
	CGRect screen = self.view.frame;
	margin = self.view.frame.size.width/16;
	CGFloat cardWidth = (screen.size.width - (margin*2.5))/2;
	CGFloat cardHeight =(cardWidth * 88)/56;
	CGFloat third = (screen.size.width-(2*margin))/3;
	
	_card1Wrapper.frame = card1Origin;
	_card1Wrapper.backgroundColor = [UIColor whiteColor];
	_card1Image.frame = CGRectMake(0, 0, cardWidth, cardHeight);
	_card1Button.frame = CGRectMake(0, 0, cardWidth, cardHeight);
	_card1Wrapper.layer.cornerRadius = 10;
	_card1Wrapper.clipsToBounds = YES;
	
	_card2Wrapper.frame = card2Origin;
	_card2Wrapper.backgroundColor = [UIColor whiteColor];
	_card2Image.frame = CGRectMake(0, 0, cardWidth, cardHeight);
	_card2Button.frame = CGRectMake(0, 0, cardWidth, cardHeight);
	_card2Wrapper.layer.cornerRadius = 10;
	_card2Wrapper.clipsToBounds = YES;
	
	_card3Wrapper.frame = card3Origin;
	_card3Wrapper.backgroundColor = [UIColor whiteColor];
	_card3Image.frame = CGRectMake(0, 0, cardWidth, cardHeight);
	_card3Button.frame = CGRectMake(0, 0, cardWidth, cardHeight);
	_card3Wrapper.layer.cornerRadius = 10;
	_card3Wrapper.clipsToBounds = YES;
	
	_card4Wrapper.frame = card4Origin;
	_card4Wrapper.backgroundColor = [UIColor whiteColor];
	_card4Image.frame = CGRectMake(0, 0, cardWidth, cardHeight);
	_card4Button.frame = CGRectMake(0, 0, cardWidth, cardHeight);
	_card4Wrapper.layer.cornerRadius = 10;
	_card4Wrapper.clipsToBounds = YES;
	
	_lifeLabel.frame = CGRectMake(margin, margin*0.5, margin * 3, margin);
	_swordLabel.frame = CGRectMake((margin*1.25)+third, (margin*0.5), margin * 3, margin);
	_discardLabel.frame = CGRectMake((margin*1.5)+(third*2), (margin*0.5), margin * 3, margin);
	
	_lifeLabel.text = @"HP";
	_swordLabel.text = @"AP";
	_discardLabel.text = @"XP";
	
	_lifeValueLabel.frame = CGRectMake(margin*2, margin*0.5, margin * 3, margin);
	_swordValueLabel.frame = CGRectMake((margin*2.25)+third, (margin*0.5), margin * 3, margin);
	_discardValueLabel.frame = CGRectMake((margin*2.5)+(third*2), (margin*0.5), margin * 3, margin);
	
	_lifeBarWrapper.frame = CGRectMake(margin, margin*1.5, third-(margin/2), 1);
	_lifeBarWrapper.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1];
	_lifeBarWrapper.clipsToBounds = YES;
	
	_lifeBar.backgroundColor = [UIColor redColor];
	
	_swordBarWrapper.frame = CGRectMake((margin*1.25)+third, margin*1.5, third-(margin/2), 1);
	_swordBarWrapper.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1];
	_swordBarWrapper.clipsToBounds = YES;
	
	_swordBar.backgroundColor = [UIColor redColor];
	
	_discardBarWrapper.frame = CGRectMake((margin*1.5)+(third*2), margin*1.5, third-(margin/2), 1);
	_discardBarWrapper.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1];
	_discardBarWrapper.clipsToBounds = YES;
	
	_discardBar.backgroundColor = [UIColor redColor];
	
	//
	
	_optionToggleButton.frame = CGRectMake((screen.size.width/2)-margin, _card1Wrapper.frame.origin.y + _card1Wrapper.frame.size.height - (margin*0.75), margin*2, margin*2);
	_quitButton.frame = quitButtonOrigin;
	_runButton.frame = runButtonOrigin;
	
	//
	
	_optionJewelView.backgroundColor = [UIColor redColor];
	_optionJewelView.frame = jewelOrigin;
	_optionJewelView.layer.cornerRadius = _optionJewelView.frame.size.width/2;
	
	_cardsWrapper.frame = self.view.frame;
	
	_card1Backdrop.frame = card1Origin;
	_card2Backdrop.frame = card2Origin;
	_card3Backdrop.frame = card3Origin;
	_card4Backdrop.frame = card4Origin;
	
	_card1Backdrop.image = [UIImage imageNamed:@"card.0060"];
	_card2Backdrop.image = [UIImage imageNamed:@"card.0060"];
	_card3Backdrop.image = [UIImage imageNamed:@"card.0060"];
	_card4Backdrop.image = [UIImage imageNamed:@"card.0060"];
}

-(void)updateStage
{
	_card1Image.image = [[playableHand card:0] image];
	_card2Image.image = [[playableHand card:1] image];
	_card3Image.image = [[playableHand card:2] image];
	_card4Image.image = [[playableHand card:3] image];	
	
	NSString * swordValue = [NSString stringWithFormat:@"%d(%d)",[user equip], [user malus]];
	
	if( [user equip] == 0 ){
		swordValue = @"0";
	}
	else if( [user malus] < [user equip] )
	{
		swordValue = [NSString stringWithFormat:@"%d",[user malus]];
	}
	else if( [user malus] == 25 )
	{
		swordValue = [NSString stringWithFormat:@"%d",[user equip]];
	}
	
	self.swordValueLabel.text = swordValue;
	self.lifeValueLabel.text = [NSString stringWithFormat:@"%d",[user life]];
	self.discardValueLabel.text = [NSString stringWithFormat:@"%d",(int)[discardPile count]];
	
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
	
	[self jewelUpdate];
	
	// Highlight HP is just healed
	
	if( justHealed == 1 ){
		_lifeLabel.textColor = [UIColor cyanColor];
	}
	else if( [user life] < 6 ){
		_lifeLabel.textColor = [UIColor redColor];
	}
	else{
		_lifeLabel.textColor = [UIColor whiteColor];
	}
	
	// Death
	
	if([user life] < 1){
		[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(death) userInfo:nil repeats:NO];
		return;
	}
}

-(void)jewelUpdate
{
	if( [user life] < 1 ){
		[_runButton setTitle:[NSString stringWithFormat:@"You died in room %d",[user room]] forState:UIControlStateNormal];
		[_runButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
	}
	else if( (int)[discardPile count] == 54 ){
		_runButton.enabled = true;
		_optionJewelView.backgroundColor = [UIColor whiteColor];
		[_runButton setTitle:[NSString stringWithFormat:@"Enter Dungeon %d",[user difficulty]+1] forState:UIControlStateNormal];
		[_runButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
	}
	else if( [playableHand numberOfCards] == 0){
		[_runButton setTitle:[NSString stringWithFormat:@"Enter Room %d",[user room]] forState:UIControlStateNormal];
		[NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(showMenu) userInfo:nil repeats:NO];
	}
	else if([user escaped] == 1 && (int)[discardPile count] != 0){
		_runButton.enabled = false;
		_optionJewelView.backgroundColor = [UIColor grayColor];
		[_runButton setTitle:@"Cannot run away" forState:UIControlStateNormal];
		[_runButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
	}
	else if( [playableHand numberOfCards] < 2 || [playableHand numberOfCards] == 4){
		_runButton.enabled = true;
		_optionJewelView.backgroundColor = [UIColor cyanColor];
		[_runButton setTitle:[NSString stringWithFormat:@"Run Away"] forState:UIControlStateNormal];
		[_runButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	}
	else
	{
		_runButton.enabled = false;
		_optionJewelView.backgroundColor = [UIColor grayColor];
		[_runButton setTitle:@"Cannot run away" forState:UIControlStateNormal];
		[_runButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
	}
	
	
}

# pragma mark - Cards Effects

-(void)healCard :(Card*)card
{
	int lifeBefore = [user life];
	[user gainLife:[card value]];
	justHealed = 1;
	[self updateHealth:([user life]-lifeBefore)];
}

-(void)swordCard :(Card*)card
{
	[user gainEquip:[card value]];
	[user setMalus:25];
	justHealed = 0;
	
	[self updateSword:[card value]];
}

-(void)monsterCard :(Card*)card
{
	// Malus
	if( [card value] >= [user malus] ){
		[user looseEquip];
	}
	
	int battleDamage = ( [card value] - [user equip]) ;
	
	if( battleDamage < 0 ){
		battleDamage = 0;
	}
	if( battleDamage > 0 ){
		[user looseLife:battleDamage];
		[self updateHealth:battleDamage*-1];
	}
	
	int malusChange = [card value] - [user equip];
	if( malusChange < 0 ){ [self updateSword:(malusChange)]; }
	
	[user setMalus:[card value]];
	justHealed = 0;
}

# pragma mark - Choice

-(void)choice:(int)cardNumber
{
	NSString * cardData = [playableHand cardValue:cardNumber];
	Card * card = [[Card alloc] initWithString:cardData];
	
	NSLog(@"--------+-------------------");
	NSLog(@"!  CARD | %@ %d", [card type], [card number]);
	NSLog(@"--------+-------------------");
	
	if( justHealed == 1 && [[card type] isEqualToString:@"H"] ){ justHealed = 1; }
	else if( [[card type] isEqualToString:@"H"] ){ [self healCard:card]; }
	else if( [[card type] isEqualToString:@"D"] ){[self swordCard:card]; }
	else{ [self monsterCard:card]; }
	
	[discardPile addObject:[playableHand cardValue:cardNumber]];
	[playableHand discard:cardNumber];
	
	[self updateExperience:1];
	
	[user setEscape:0];
	[self updateStage];
}

-(void)draw
{
	NSLog(@"   VIEW | Draw");
	
	menuIsOpen = 0;
	[self hideMenu];
	
	// Draw 4 cards
	
	NSLog(@"%d", (int)[[playableDeck cards] count]);
	 
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

-(void)death
{
	NSLog(@"DEATH!");
	[NSTimer scheduledTimerWithTimeInterval:0.75 target:self selector:@selector(showMenu) userInfo:nil repeats:NO];
	
	[UIView animateWithDuration:0.25 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
		_card1Wrapper.frame = CGRectOffset(card1Origin, 0, margin*-1);
		_card1Wrapper.alpha = 0;
	} completion:^(BOOL finished){ }];
	[UIView animateWithDuration:0.25 delay:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
		_card2Wrapper.frame = CGRectOffset(card2Origin, 0, margin*-1);
		_card2Wrapper.alpha = 0;
	} completion:^(BOOL finished){ }];
	[UIView animateWithDuration:0.25 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
		_card3Wrapper.frame = CGRectOffset(card3Origin, 0, margin*-1);
		_card3Wrapper.alpha = 0;
	} completion:^(BOOL finished){ }];
	[UIView animateWithDuration:0.25 delay:0.4 options:UIViewAnimationOptionCurveEaseOut animations:^{
		_card4Wrapper.frame = CGRectOffset(card4Origin, 0, margin*-1);
		_card4Wrapper.alpha = 0;
	} completion:^(BOOL finished){ }];
	
}

# pragma mark - Interactions

- (IBAction)optionToggleButton:(id)sender
{
	if( menuIsOpen == 1 ){
		[self hideMenu];
		menuIsOpen = 0;
	}
	else{
		[self showMenu];
		menuIsOpen = 1;
	}
}

-(void)showMenu
{
	_quitButton.alpha = 0;
	_runButton.alpha = 0;
	
	[UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
		
		_card3Wrapper.frame = CGRectOffset(card3Origin, 0, margin);
		_card4Wrapper.frame = CGRectOffset(card4Origin, 0, margin);
		_card3Backdrop.frame = CGRectOffset(card3Origin, 0, margin);
		_card4Backdrop.frame = CGRectOffset(card4Origin, 0, margin);
		_optionJewelView.frame = CGRectOffset(jewelOrigin, 0, margin/2);
		
	} completion:^(BOOL finished){
		
		[UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
			
			_quitButton.frame = CGRectOffset(quitButtonOrigin, -10, 0);
			_runButton.frame = CGRectOffset(runButtonOrigin, 10, 0);
			_quitButton.alpha = 1;
			_runButton.alpha = 1;
			
		} completion:^(BOOL finished){
		}];
		
	}];
}

-(void)hideMenu
{
	[UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
		
		_quitButton.frame = quitButtonOrigin;
		_runButton.frame = runButtonOrigin;
		_quitButton.alpha = 0;
		_runButton.alpha = 0;
		
	} completion:^(BOOL finished){
		
		[UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
			_card3Wrapper.frame = card3Origin;
			_card4Wrapper.frame = card4Origin;
			_card3Backdrop.frame = card3Origin;
			_card4Backdrop.frame = card4Origin;
			_optionJewelView.frame = jewelOrigin;
		} completion:^(BOOL finished){
			
		}];
		
	}];
}


- (IBAction)quitButton:(id)sender
{
	
}

- (IBAction)runButton:(id)sender
{
	if( (int)[discardPile count] == 0){
		[self newGame];
	}
	
	if([user escaped] == 1 && (int)[discardPile count] != 0){
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
	
	if( [playableHand numberOfCards] == 0){
		[user setEscape:0];
	}
	else{
		[user setEscape:1];
	}
	
	
	// Put the cards in hand, back in the deck
	
	for (NSString* card in cardsInHand) {
		if( ![card isEqualToString:@"--"] ){
			[playableDeck addCard:card];
		}
	}
	
	_card1Wrapper.frame = CGRectOffset(card1Origin, 0, -10);
	_card1Wrapper.alpha = 0;
	_card2Wrapper.frame = CGRectOffset(card2Origin, 0, -10);
	_card2Wrapper.alpha = 0;
	_card3Wrapper.frame = CGRectOffset(card3Origin, 0, -10);
	_card3Wrapper.alpha = 0;
	_card4Wrapper.frame = CGRectOffset(card4Origin, 0, -10);
	_card4Wrapper.alpha = 0;
	
	[UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
		_card1Wrapper.frame = card1Origin;
		_card1Wrapper.alpha = 1;
	} completion:^(BOOL finished){}];
	
	[UIView animateWithDuration:0.25 delay:0.05 options:UIViewAnimationOptionCurveEaseOut animations:^{
		_card2Wrapper.frame = card2Origin;
		_card2Wrapper.alpha = 1;
	} completion:^(BOOL finished){}];
	
	[UIView animateWithDuration:0.25 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
		_card3Wrapper.frame = card3Origin;
		_card3Wrapper.alpha = 1;
	} completion:^(BOOL finished){}];
	
	[UIView animateWithDuration:0.25 delay:0.15 options:UIViewAnimationOptionCurveEaseOut animations:^{
		_card4Wrapper.frame = card4Origin;
		_card4Wrapper.alpha = 1;
	} completion:^(BOOL finished){}];
	
	[playableHand discard:0];
	[playableHand discard:1];
	[playableHand discard:2];
	[playableHand discard:3];
	
	[self draw];
}

- (IBAction)cardPressed:(UIButton*)sender
{
	// Do nothing if the card is blank
	NSString * cardData = [playableHand cardValue:((int)sender.tag-201)];
	Card * card = [[Card alloc] initWithString:cardData];
	if( [card number] == 0 ){ return; }
	
	// Click
	UIView * targetWrapper = _card1Wrapper;
	
	if( sender.tag == 201 ){ targetWrapper = _card1Wrapper; }
	if( sender.tag == 202 ){ targetWrapper = _card2Wrapper; }
	if( sender.tag == 203 ){ targetWrapper = _card3Wrapper; }
	if( sender.tag == 204 ){ targetWrapper = _card4Wrapper; }
	
	CGRect cardOrigin = targetWrapper.frame;
	[UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
		targetWrapper.frame = CGRectOffset(cardOrigin, 0, -10);
		targetWrapper.alpha = 0;
	} completion:^(BOOL finished){
		
		[self choice:((int)sender.tag-201)];
		[self battleResults:((int)sender.tag-201)];
	
		[UIView animateWithDuration:0.5 delay:0.25 options:UIViewAnimationOptionCurveEaseInOut animations:^{
			targetWrapper.frame = cardOrigin;
			targetWrapper.alpha = 1;
		} completion:^(BOOL finished){}];
	}];
}

-(void)battleResults :(int)cardPosition
{
	NSLog(@"Battle result");
}

# pragma mark - Stats

-(void)updateHealth:(int)change
{
	if(change > 0){
		_lifeUpdateLabel.textColor = [UIColor cyanColor];
		_lifeUpdateLabel.text = [NSString stringWithFormat:@"+%d",change];
	}
	else if( change < 0 ){
		_lifeUpdateLabel.textColor = [UIColor redColor];
		_lifeUpdateLabel.text = [NSString stringWithFormat:@"%d",change];
	}
	else{
		_lifeUpdateLabel.text = @"";
	}
	
	_lifeUpdateLabel.alpha = 1;
	
	[UIView animateWithDuration:0.5 delay:3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		_lifeUpdateLabel.alpha = 0;
	} completion:^(BOOL finished){}];
	
}
-(void)updateSword:(int)change
{
	if(change > 0){
		_swordUpdateLabel.textColor = [UIColor cyanColor];
		_swordUpdateLabel.text = [NSString stringWithFormat:@"+%d",change];
	}
	else if( change < 0 ){
		_swordUpdateLabel.textColor = [UIColor redColor];
		_swordUpdateLabel.text = [NSString stringWithFormat:@"%d",change];
	}
	else{
		_swordUpdateLabel.text = @"";
	}
	
	_swordUpdateLabel.alpha = 1;
	
	[UIView animateWithDuration:0.5 delay:3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		_swordUpdateLabel.alpha = 0;
	} completion:^(BOOL finished){}];
	
}
-(void)updateExperience:(int)change
{
	if(change > 0){
		_discardUpdateLabel.textColor = [UIColor cyanColor];
		_discardUpdateLabel.text = [NSString stringWithFormat:@"+%d",change];
	}
	else if( change < 0 ){
		_discardUpdateLabel.textColor = [UIColor redColor];
		_discardUpdateLabel.text = [NSString stringWithFormat:@"%d",change];
	}
	else{
		_discardUpdateLabel.text = @"";
	}
	
	_discardUpdateLabel.alpha = 1;
	
	[UIView animateWithDuration:0.5 delay:3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		_discardUpdateLabel.alpha = 0;
	} completion:^(BOOL finished){}];
	
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

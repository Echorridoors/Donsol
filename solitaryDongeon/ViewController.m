//
//  ViewController.m
//  solitaryDongeon
//
//  Created by Devine Lu Linvega on 2015-02-27.
//  Copyright (c) 2015 Devine Lu Linvega. All rights reserved.
//

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

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
	
	[self start];
	
	[self updateStage];
	// END
}

-(void)start
{
	[self newGame];
	[self templateStart];
	[self template];
	[self draw];
	[self updateStage];
	[self hideMenu];
	
	if( [user difficulty] == 1 ){
		[self modal:[NSString stringWithFormat:@"dungeon %d",[user difficulty]]:@"You are walking into the abyss of the dungeon, clear each room and exit alive."];
	}
	else{
		[self modal:[NSString stringWithFormat:@"dungeon %d",[user difficulty]]:[NSString stringWithFormat:@"Your maximum HP has increased to %dHP, but the monsters are growing stronger.",[user lifeMaximum]]];
	}
}

-(void)newGame
{
	NSLog(@"   GAME | New Deck");
	playableHand = [[Hand alloc] init];
	playableDeck = [[Deck alloc] init];
	discardPile = [[NSMutableArray alloc] init];
	
	if(!user || [user life] < 1 || [user difficulty] == 1 ){ user = [[User alloc] init]; }
}

-(void)templateStart
{
	CGRect screen = self.view.frame;
	margin = self.view.frame.size.width/16;
	CGFloat cardWidth = (screen.size.width - (margin*2.5))/2;
	CGFloat cardHeight =(cardWidth * 88)/56;
	CGFloat verticalOffset = margin * 1.5;
	CGFloat third = (screen.size.width-(2*margin))/3;
	
	// iPhone 4S
	if( screen.size.height == 480 ){
		verticalOffset = margin;
	}
	
	NSLog(@"%f %f",screen.size.width,screen.size.height);
	
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
	
	_modalView.hidden = true;
}

-(void)template
{
	CGRect screen = self.view.frame;
	margin = self.view.frame.size.width/16;
	CGFloat cardWidth = (screen.size.width - (margin*2.5))/2;
	CGFloat cardHeight =(cardWidth * 88)/56;
	CGFloat third = (screen.size.width-(2*margin))/3;
	
	_card1Wrapper.frame = card1Origin;
	_card1Image.frame = CGRectMake(0, 0, cardWidth, cardHeight);
	_card1Button.frame = CGRectMake(0, 0, cardWidth, cardHeight);
	_card1Wrapper.layer.cornerRadius = 10;
	_card1Wrapper.clipsToBounds = YES;
	
	_card2Wrapper.frame = card2Origin;
	_card2Image.frame = CGRectMake(0, 0, cardWidth, cardHeight);
	_card2Button.frame = CGRectMake(0, 0, cardWidth, cardHeight);
	_card2Wrapper.layer.cornerRadius = 10;
	_card2Wrapper.clipsToBounds = YES;
	
	_card3Wrapper.frame = card3Origin;
	_card3Image.frame = CGRectMake(0, 0, cardWidth, cardHeight);
	_card3Button.frame = CGRectMake(0, 0, cardWidth, cardHeight);
	_card3Wrapper.layer.cornerRadius = 10;
	_card3Wrapper.clipsToBounds = YES;
	
	_card4Wrapper.frame = card4Origin;
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
	_swordBar.frame = CGRectMake(0, 0, 0, 0);
	
	_discardBarWrapper.frame = CGRectMake((margin*1.5)+(third*2), margin*1.5, third-(margin/2), 1);
	_discardBarWrapper.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1];
	_discardBarWrapper.clipsToBounds = YES;
	
	_discardBar.backgroundColor = [UIColor redColor];
	_discardBar.frame = CGRectMake(0, 0, 0, 0);
	
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
	
	CGFloat healthBar = (([user life] * self.lifeBarWrapper.frame.size.width)/[user lifeMaximum]);
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
		_lifeLabel.textColor = [UIColor colorWithRed:0.45 green:0.87 blue:0.76 alpha:1];
	}
	else if( [user life] < 6 ){
		_lifeLabel.textColor = [UIColor redColor];
	}
	else{
		_lifeLabel.textColor = [UIColor whiteColor];
	}
	
	// Low Health Warning
	if( [user life] < 6 ){
		[self blinkLife];
	}
	else{
		[blinkHealthTimer invalidate];
		_lifeLabel.hidden = NO;
	}
	
	// Death
	
	if([user life] < 1){
		[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(death) userInfo:nil repeats:NO];
		// Percetn reached.
		float percentage = ((float)[discardPile count] / 54.0) * 100;
		[self modal:@"A monster killed you":[NSString stringWithFormat:@"You explored %d%% the dungeon before succumbing to your wounds.",(int)percentage]];
		return;
	}
	
	// Finished Dungeon
	
	if( (int)[discardPile count] == 54 ){
		[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(showMenu) userInfo:nil repeats:NO];
		[self modal:@"Dungeon complete":@"You have reached the end of the dongeon."];
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
	else if( (int)[discardPile count] == 0 ){
		_runButton.enabled = true;
		_optionJewelView.backgroundColor = [UIColor whiteColor];
		[_runButton setTitle:@"Enter Another Door" forState:UIControlStateNormal];
		[_runButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
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
		_optionJewelView.backgroundColor = [UIColor colorWithRed:0.45 green:0.87 blue:0.76 alpha:1];
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
		if( [user equip] > 0 ){
			[self modal:@"Your shield broke":@"Attacking increasingly harder monsters, with the same shield, will break it."];
		}
		[user looseEquip];
	}
	
	// Battle
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
	
	// Tutorials
	if( [discardPile count] < 4 && [[card type] isEqualToString:@"H"] && [user life] == [user lifeMaximum] ){ [self modal:@"Wasted A Potion" :@"Your health is already full, you should avoid wasting valuable potions."]; }
	if( [discardPile count] < 4 && [[card type] isEqualToString:@"C"] && [user equip] < 1 ){ [self modal:@"Without protection" :@"You should really equip a shield before attacking monsters."]; }
	if( [discardPile count] < 4 && [[card type] isEqualToString:@"S"] && [user equip] < 1 ){ [self modal:@"You need a shield" :@"You should really equip a shield before attacking monsters."]; }
	
	if( justHealed == 1 && [[card type] isEqualToString:@"H"] ){ justHealed = 1; [self modal:@"Feeling sick" :@"You may not consume 2 potions in a row."]; }
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
			[self playSoundNamed:@"click.3"];
		}];
		
	}];
	[self playSoundNamed:@"click.1"];
}

-(void)hideMenu
{
	[self playSoundNamed:@"click.1"];
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
	[self playSoundNamed:@"click.1"];
}

- (IBAction)runButton:(id)sender
{
	[self playSoundNamed:@"click.1"];
	
	if( (int)[discardPile count] == 0){
		[self newGame];
	}
	if( (int)[discardPile count] == 54){
		[user setDifficulty:[user difficulty]+1];
		[self start];
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
	} completion:^(BOOL finished){ [self playSoundNamed:@"click.4"]; }];
	
	[UIView animateWithDuration:0.25 delay:0.05 options:UIViewAnimationOptionCurveEaseOut animations:^{
		_card2Wrapper.frame = card2Origin;
		_card2Wrapper.alpha = 1;
	} completion:^(BOOL finished){ [self playSoundNamed:@"click.4"]; }];
	
	[UIView animateWithDuration:0.25 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
		_card3Wrapper.frame = card3Origin;
		_card3Wrapper.alpha = 1;
	} completion:^(BOOL finished){ [self playSoundNamed:@"click.4"]; }];
	
	[UIView animateWithDuration:0.25 delay:0.15 options:UIViewAnimationOptionCurveEaseOut animations:^{
		_card4Wrapper.frame = card4Origin;
		_card4Wrapper.alpha = 1;
	} completion:^(BOOL finished){ [self playSoundNamed:@"click.4"];  }];
	
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
	[self playSoundNamed:@"click.2"];
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
		} completion:^(BOOL finished){
			
			[self playSoundNamed:@"click.3"];
		
		}];
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
		_lifeUpdateLabel.textColor = [UIColor colorWithRed:0.45 green:0.87 blue:0.76 alpha:1];
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
		_swordUpdateLabel.textColor = [UIColor colorWithRed:0.45 green:0.87 blue:0.76 alpha:1];
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
		_discardUpdateLabel.textColor = [UIColor colorWithRed:0.45 green:0.87 blue:0.76 alpha:1];
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
	
	// HighScore
	
	int currentScore = ((int)[discardPile count] + (54 * ([user difficulty] - 1)) );
	NSLog(@"$ SCORE | Score: %d Best: %d", currentScore, [user loadHighScore] );
	
	if( currentScore > [user loadHighScore] ){
		NSLog(@"$ SCORE | New high score: %d!", currentScore );
		self.discardLabel.textColor = [UIColor colorWithRed:0.45 green:0.87 blue:0.76 alpha:1];
		[user setHighScore:currentScore];
	}
	else{
		self.discardLabel.textColor = [UIColor whiteColor];
	}
	
}

-(void)blinkLife
{
	[blinkHealthTimer invalidate];
	
	if( _lifeLabel.hidden == YES ){
		_lifeLabel.hidden = NO;
	}
	else{
		_lifeLabel.hidden = YES;
	}
	
	blinkHealthTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(blinkLife) userInfo:nil repeats:NO];
}

# pragma mark - Modal

-(void)modal :(NSString*)header :(NSString*)text
{
	NSLog(@"! MODAL | %@",header);
	
	_modalView.hidden = false;
	
	_modalView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
	_modalView.frame = self.view.frame;
	_modalView.alpha = 0;
	
	_modalWrapperView.frame = CGRectMake(margin*2, (self.view.frame.size.height/2)-(3.25*margin), self.view.frame.size.width-(4*margin), margin*5);
	_modalWrapperView.alpha = 0;
	_modalWrapperView.layer.cornerRadius = margin/4;
	
	
	_modalHeaderLabel.text = [header uppercaseString];
	_modalHeaderLabel.frame = CGRectMake(margin, margin, _modalWrapperView.frame.size.width-(2*margin), margin);
	_modalTextLabel.text = text;
	_modalTextLabel.frame = CGRectMake(margin, margin*2, _modalWrapperView.frame.size.width-(2*margin), margin*2);
	
	
	_modalCloseButton.frame = CGRectMake(0, 0, 0, 0);
	
	[UIView animateWithDuration:0.1 delay:0.75 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		_modalView.alpha = 1;
	} completion:^(BOOL finished){
		[UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
			_modalWrapperView.frame = CGRectMake(margin*2, (self.view.frame.size.height/2)-(3*margin), self.view.frame.size.width-(4*margin), margin*5);
			_modalWrapperView.alpha = 1;
		} completion:^(BOOL finished){
			
			_modalCloseButton.frame = self.view.frame;
			[self playSoundNamed:@"click.4"];
		}];
	}];
}

- (IBAction)modalCloseButton:(id)sender
{
	[UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		_modalWrapperView.frame = CGRectMake(margin*2, (self.view.frame.size.height/2)-(3.25*margin), self.view.frame.size.width-(4*margin), margin*5);
		_modalWrapperView.alpha = 0;
	} completion:^(BOOL finished){
		[UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
			_modalView.alpha = 0;
		} completion:^(BOOL finished){
			
		}];
	}];
	
	[self playSoundNamed:@"click.2"];
}

- (void)playSoundNamed:(NSString*)name
{
	NSLog(@" AUDIO | Playing sound: %@",name);
	
	NSString* audioPath = [[NSBundle mainBundle] pathForResource:name ofType:@"wav"];
	NSURL* audioUrl = [NSURL fileURLWithPath:audioPath];
	audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:audioUrl error:nil];
	audioPlayer.volume = 1;
	[audioPlayer prepareToPlay];
	[audioPlayer play];
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

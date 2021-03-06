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
#import <QuartzCore/QuartzCore.h>

#import "AppDelegate.h"
#import "ViewController.h"
#import "Deck.h"
#import "Hand.h"
#import "Card.h"
#import "User.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	// END
}


-(void)start
{
	[self newGame];
	[self templateStart];
	[self template];
	[self draw];
	[self updateStage];
	
	if( [user difficulty] == 1 ){
		[self modal:[NSString stringWithFormat:@"dungeon %d",[user difficulty]]:@"You are walking into the abyss of the dungeon, clear each room and exit alive.":false];
	}
	else{
		[self modal:[NSString stringWithFormat:@"dungeon %d",[user difficulty]]:[NSString stringWithFormat:@"Your maximum HP has increased to %dHP, but the monsters are growing stronger.",[user lifeMaximum]]:false];
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
	screen = self.view.frame;
	margin = self.view.frame.size.width/16;
	cardWidth = (screen.size.width - (margin*2.5))/2;
	cardHeight =(cardWidth * 88)/56;
	verticalOffset = 35;
	
	card1Origin = CGRectMake(margin, margin+verticalOffset, cardWidth, cardHeight);
	card2Origin = CGRectMake((margin*1.5) + cardWidth, margin+verticalOffset, cardWidth, cardHeight);
	card3Origin = CGRectMake(margin, (margin*1.5)+cardHeight+verticalOffset, cardWidth, cardHeight);
	card4Origin = CGRectMake((margin*1.5) + cardWidth, (margin*1.5)+cardHeight+verticalOffset, cardWidth, cardHeight);
	jewelOrigin = CGRectMake((screen.size.width/2)-(margin/4), card1Origin.origin.y + card1Origin.size.height, margin/2, margin/2);
	
	quitButtonOrigin = CGRectMake(margin, jewelOrigin.origin.y-(margin*0.25), cardWidth-(margin*0.5), margin*2);
	
	_lifeUpdateLabel.text = @"";
	_lifeUpdateLabel.alpha = 0;
	
	_swordUpdateLabel.text = @"";
	_swordUpdateLabel.alpha = 0;
	
	_discardUpdateLabel.text = @"";
	_discardUpdateLabel.alpha = 0;
	
	_modalView.hidden = true;
	
	float ratio = self.view.frame.size.width/self.view.frame.size.height;
	NSLog(@"%f",ratio);
	
	if( ratio == 0.75 ){
		NSLog(@"Load iPad Layout");
		
		margin = self.view.frame.size.width/8;
		cardWidth = (screen.size.width - (margin*3.5))/2;
		cardHeight = (cardWidth * 88)/56;
		
		card1Origin = CGRectMake(margin*1.5, margin+verticalOffset, cardWidth, cardHeight);
		card2Origin = CGRectMake(screen.size.width - (margin*1.5) - cardWidth, margin+verticalOffset, cardWidth, cardHeight);
		card3Origin = CGRectMake(margin*1.5, (margin*1.5)+cardHeight+verticalOffset, cardWidth, cardHeight);
		card4Origin = CGRectMake(screen.size.width - (margin*1.5) - cardWidth, (margin*1.5)+cardHeight+verticalOffset, cardWidth, cardHeight);
		
		float quarter = (screen.size.width - (card1Origin.origin.x * 2))/4;
		float pos_height = margin*0.25;
		float pos_value_ver = margin * 0.3;
		float pos_bar_ver = pos_value_ver + pos_height;
		float pos_label_ver = pos_value_ver + pos_height;
		float pos_bar_width = quarter * 0.8;
		
		_lifeValueLabel.frame = CGRectMake(card1Origin.origin.x, pos_value_ver, pos_bar_width, pos_height);
		_swordValueLabel.frame = CGRectMake(card1Origin.origin.x + quarter, pos_value_ver, pos_bar_width, pos_height);
		_discardValueLabel.frame = CGRectMake(card1Origin.origin.x + quarter + quarter, pos_value_ver, pos_bar_width, pos_height);
		
		_lifeLabel.frame = CGRectMake(card1Origin.origin.x, pos_label_ver, margin * 3, pos_height);
		_swordLabel.frame = CGRectMake(card1Origin.origin.x + quarter, pos_label_ver, margin * 3, pos_height);
		_discardLabel.frame = CGRectMake(card1Origin.origin.x + quarter + quarter, pos_label_ver, margin * 3, pos_height);
		
		_lifeBarWrapper.frame = CGRectMake(card1Origin.origin.x, pos_bar_ver, pos_bar_width, 1);
		_swordBarWrapper.frame = CGRectMake(card1Origin.origin.x + quarter, pos_bar_ver, pos_bar_width, 1);
		_discardBarWrapper.frame = CGRectMake(card1Origin.origin.x + quarter + quarter, pos_bar_ver, pos_bar_width, 1);
		_runButton.frame = CGRectMake(card1Origin.origin.x + quarter + quarter + quarter, pos_value_ver, quarter, pos_height * 2);
		
		_runButton.backgroundColor = [UIColor blackColor];
		_runButton.layer.cornerRadius = 4;
		_runButton.layer.borderColor = [[UIColor whiteColor] CGColor];
		_runButton.layer.borderWidth = 1;

	}
	else{
		NSLog(@"Load Default Layout");
		_lifeLabel.frame = CGRectMake(card1Origin.origin.x, margin*1.5, margin * 3, margin);
		_swordLabel.frame = CGRectMake((margin*2)+((cardWidth-margin)/2), (margin*1.5), margin * 3, margin);
		_discardLabel.frame = CGRectMake(card2Origin.origin.x, (margin*1.5), margin * 3, margin);
		
		_lifeValueLabel.frame = CGRectMake(card1Origin.origin.x, margin*0.5, margin * 3, margin);
		_swordValueLabel.frame = CGRectMake((margin*2)+((cardWidth-margin)/2), (margin*0.5), margin * 3, margin);
		_discardValueLabel.frame = CGRectMake(card2Origin.origin.x, (margin*0.5), margin * 3, margin);
		
		_lifeBarWrapper.frame = CGRectMake(card1Origin.origin.x, margin*1.5, (cardWidth-margin)/2, 1);
		_swordBarWrapper.frame = CGRectMake((margin*2)+((cardWidth-margin)/2), margin*1.5, (cardWidth-margin)/2, 1);
		_discardBarWrapper.frame = CGRectMake(card2Origin.origin.x, margin*1.5, (cardWidth-margin)/2, 1);
		_runButton.frame = CGRectMake(card2Origin.origin.x+((cardWidth-margin)/2)+(margin*0.5), (margin*0.5), cardWidth/2, margin*1.70);
		
		_runButton.backgroundColor = [UIColor blackColor];
		_runButton.titleEdgeInsets = UIEdgeInsetsMake(margin/8, 0, 0, 0);
		_runButton.layer.cornerRadius = 4;
		_runButton.layer.borderColor = [[UIColor whiteColor] CGColor];
		_runButton.layer.borderWidth = 1;
	}
	
	_lifeUpdateLabel.frame = _lifeValueLabel.frame;
	_swordUpdateLabel.frame = _swordValueLabel.frame;
	_discardUpdateLabel.frame = _discardValueLabel.frame;
}

-(void)template
{
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
	
	_lifeLabel.text = @"HEALTH";
	_swordLabel.text = @"SHIELD";
	_discardLabel.text = @"DEPTH";
	
	_lifeBarWrapper.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1];
	_lifeBarWrapper.clipsToBounds = YES;
	
	_lifeBar.backgroundColor = [UIColor redColor];
	
	_swordBarWrapper.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1];
	_swordBarWrapper.clipsToBounds = YES;
	
	_swordBar.backgroundColor = [UIColor redColor];
	_swordBar.frame = CGRectMake(0, 0, 0, 0);
	
	_discardBarWrapper.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1];
	_discardBarWrapper.clipsToBounds = YES;
	
	_discardBar.backgroundColor = [UIColor redColor];
	_discardBar.frame = CGRectMake(0, 0, 0, 0);
	
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
	
	if( [user equip] > 0 ){
		_swordLabel.text = [NSString stringWithFormat:@"SHIELD %d",[user equip]];
	}
	
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
	
	// runButtonUpdate
	
	[self runButtonUpdate];
	
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
		[self modal:@"A monster killed you":[NSString stringWithFormat:@"You explored %d%% the dungeon before succumbing to your wounds.",(int)percentage]:false];
		[self playTuneNamed:@"tune.defeat"];
		return;
	}
	
	// Victory
	
	if( (int)[discardPile count] == 54 ){
		[self modal:@"Dungeon complete":@"You have reached the end of the dongeon.":false];
		[self playTuneNamed:@"tune.victory"];
	}
}

-(void)runButtonUpdate
{
	if( (int)[discardPile count] == 0 ){
		[_runButton setTitle:[NSString stringWithFormat:@"SHUFFLE"] forState:UIControlStateNormal];
		[_runButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	}
	else if( [playableHand numberOfCards] == 1 ){
		[_runButton setTitle:[NSString stringWithFormat:@"PASS"] forState:UIControlStateNormal];
		[_runButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	}
	else if( [user life] < 1 ){
		[_runButton setTitle:[NSString stringWithFormat:@"RETRY"] forState:UIControlStateNormal];
		[_runButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
	}
	else if( (int)[discardPile count] == 54 ){
		[_runButton setTitle:[NSString stringWithFormat:@"DUNGEON%d",[user difficulty]+1] forState:UIControlStateNormal];
		[_runButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
	}
	else if( (int)[discardPile count] == 0 ){
		[_runButton setTitle:@"PASS" forState:UIControlStateNormal];
		[_runButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	}
	else if( [playableHand numberOfCards] == 0){
		[_runButton setTitle:[NSString stringWithFormat:@"WALKING"] forState:UIControlStateNormal];
	}
	else if([user escaped] == 1 && (int)[discardPile count] != 0){
		[_runButton setTitle:@"FIGHT" forState:UIControlStateNormal];
		[_runButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
	}
	else if( [playableHand numberOfCards] == 4){
		[_runButton setTitle:[NSString stringWithFormat:@"RUN"] forState:UIControlStateNormal];
		[_runButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	}
	else if( [playableHand numberOfCards] < 2){
		[_runButton setTitle:[NSString stringWithFormat:@"RUN"] forState:UIControlStateNormal];
		[_runButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	}
	else {
		[_runButton setTitle:@"FIGHT" forState:UIControlStateNormal];
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
			[self modal:@"Your shield broke":@"Attacking monsters with the same or greater strength as your shield, will break it.":true];
			[self playTuneNamed:@"tune.shield.break"];
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
	if( [self loadHighScore] < 54 )
	{
		if( [discardPile count] < 4 && [[card type] isEqualToString:@"H"] && [user life] == [user lifeMaximum] ){ [self modal:@"Wasted A Potion" :@"Your health is already full, you should avoid wasting valuable potions.":true]; }
		if( [discardPile count] < 4 && [[card type] isEqualToString:@"C"] && [user equip] < 1 ){ [self modal:@"Without protection" :@"You should really equip a shield before attacking monsters.":true]; }
		if( [discardPile count] < 4 && [[card type] isEqualToString:@"S"] && [user equip] < 1 ){ [self modal:@"You need a shield" :@"You should really equip a shield before attacking monsters.":true]; }
	}
	
	if( justHealed == 1 && [[card type] isEqualToString:@"H"] ){ justHealed = 1; [self modal:@"Feeling sick" :@"You may not consume 2 potions in a row.":true]; }
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
	
	// Draw 4 cards
	
	NSLog(@"%d", (int)[[playableDeck cards] count]);
	
    // pick (4 - numberOfCards) cards
    int cardsToDraw = 4 - [playableHand numberOfCards];
    
    for (int i = 0; i < cardsToDraw; i += 1) {
        [playableHand pickCard:[playableDeck pickCard]];
    }
	
	[self updateStage];
}

-(void)death
{
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

-(void)life
{
	[UIView animateWithDuration:0.25 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
		_card1Wrapper.frame = card1Origin;
		_card1Wrapper.alpha = 1;
	} completion:^(BOOL finished){ }];
	[UIView animateWithDuration:0.25 delay:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
		_card2Wrapper.frame = card2Origin;
		_card2Wrapper.alpha = 1;
	} completion:^(BOOL finished){ }];
	[UIView animateWithDuration:0.25 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
		_card3Wrapper.frame = card3Origin;
		_card3Wrapper.alpha = 1;
	} completion:^(BOOL finished){ }];
	[UIView animateWithDuration:0.25 delay:0.4 options:UIViewAnimationOptionCurveEaseOut animations:^{
		_card4Wrapper.frame = card4Origin;
		_card4Wrapper.alpha = 1;
	} completion:^(BOOL finished){ }];
}

# pragma mark - Interactions

- (IBAction)runButton:(id)sender
{
	[runHoldTimer invalidate];
	
	if( [user life] < 1 ){
		[self start];
		[self life];
		[self draw];
//		[self playTuneNamed:@"tune.menu"];
//		[self performSegueWithIdentifier: @"leave" sender: self];
	}
	else{
		[self runAction];
	}
}

- (IBAction)runButtonTouch2:(id)sender
{
	runHoldTimer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(leaveDungeon) userInfo:nil repeats:NO];
}

-(void)leaveDungeon
{
	[self playSoundNamed:@"click.1"];
	[self playTuneNamed:@"tune.menu"];
	[self performSegueWithIdentifier: @"leave" sender: self];
}

-(void)runAction
{
	[self playSoundNamed:@"click.1"];
	
	if( (int)[discardPile count] == 0){
		[self newGame];
	}
	if( (int)[discardPile count] == 54){
		[self apiContact:@"donsol":@"analytics":@"dungeon":@"1"];
		[user setDifficulty:[user difficulty]+1];
		[self start];
	}
	
	if([user escaped] == 1 && (int)[discardPile count] != 0){
		[self modal:@"LOCKED":@"You may not run away twice in a row.":true];
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
		[self modal:@"LOCKED":@"You may not run away before a single card remains in the room.":false];
		return;
	}
	
	NSLog(@"   VIEW | Run Away! Discard %lu cards",(unsigned long)[[playableHand cards] count]);
	
	[user nextRoom];
	
	if( [playableHand numberOfCards] == 0 ){
		[user setEscape:0];
	}
	else if( [playableHand numberOfCards] == 1 ){
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
			
			// Automatically draw if the room is empty
			
			if( [[[playableHand card:0] type] isEqualToString:@"-"] && [[[playableHand card:1] type] isEqualToString:@"-"] && [[[playableHand card:2] type] isEqualToString:@"-"] && [[[playableHand card:3] type] isEqualToString:@"-"] ){
				if( [user life] > 0 ){
					[self runAction];
				}
				
			}
			
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
	NSLog(@"$ SCORE | Score: %d Best: %d", currentScore, [self loadHighScore] );
	
	if( currentScore > [self loadHighScore] ){
		NSLog(@"$ SCORE | New high score: %d!", currentScore );
		self.discardLabel.textColor = [UIColor colorWithRed:0.45 green:0.87 blue:0.76 alpha:1];
		[self setHighScore:currentScore];
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

-(void)modal :(NSString*)header :(NSString*)text :(BOOL)tutorial
{
	NSLog(@"! MODAL | %@",header);
	
	if( [[self loadTutorialSetting] isEqualToString:@"OFF"] ){ return; }
	
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

# pragma mark - Sounds

- (void)playSoundNamed:(NSString*)name
{
	NSLog(@"$ AUDIO | Playing sound: %@",name);
	
	NSString* audioPath = [[NSBundle mainBundle] pathForResource:name ofType:@"wav"];
	NSURL* audioUrl = [NSURL fileURLWithPath:audioPath];
	audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:audioUrl error:nil];
	audioPlayer.volume = 1;
	[audioPlayer prepareToPlay];
	[audioPlayer play];
}

- (void)playTuneNamed:(NSString*)name
{
	NSLog(@"$ AUDIO | Playing tune: %@",name);
	
	NSString* audioPath = [[NSBundle mainBundle] pathForResource:name ofType:@"wav"];
	NSURL* audioUrl = [NSURL fileURLWithPath:audioPath];
	tunePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:audioUrl error:nil];
	tunePlayer.volume = 1;
	[tunePlayer prepareToPlay];
	[tunePlayer play];
}

# pragma mark - High Score

-(void)setTutorialSetting:(NSString*)toggle
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:toggle forKey:@"tutorial"];
	[defaults synchronize];
}

-(NSString*)loadTutorialSetting
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	if( ![defaults objectForKey:@"tutorial"]  ){
		return @"ON";
	}
	if( [[defaults objectForKey:@"tutorial"] isEqualToString:@""] ){
		return @"ON";
	}
	return [defaults objectForKey:@"tutorial"];
}

-(void)setHighScore:(int)score
{
    [AppDelegate setHighScore:score shouldSync:true];
}

-(int)loadHighScore
{
    return [AppDelegate highScore];
}

-(void)apiContact:(NSString*)source :(NSString*)method :(NSString*)term :(NSString*)value
{
	NSString *post = [NSString stringWithFormat:@"values={\"term\":\"%@\",\"value\":\"%@\"}",term,value];
	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
	
	NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
	
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.xxiivv.com/%@/%@",source,method]]];
	[request setHTTPMethod:@"POST"];
	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
	[request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
	[request setHTTPBody:postData];
	
	NSURLResponse *response;
	NSData *POSTReply = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
	NSString *theReply = [[NSString alloc] initWithBytes:[POSTReply bytes] length:[POSTReply length] encoding: NSASCIIStringEncoding];
	NSLog(@"& API  | %@: %@",method, theReply);
	
	return;
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

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
	
	card1Origin = CGRectMake(margin, margin+verticalOffset, cardWidth, cardHeight);
	card2Origin = CGRectMake((margin*1.5) + cardWidth, margin+verticalOffset, cardWidth, cardHeight);
	card3Origin = CGRectMake(margin, (margin*1.5)+cardHeight+verticalOffset, cardWidth, cardHeight);
	card4Origin = CGRectMake((margin*1.5) + cardWidth, (margin*1.5)+cardHeight+verticalOffset, cardWidth, cardHeight);
	jewelOrigin = CGRectMake((screen.size.width/2)-(margin/4), card1Origin.origin.y + card1Origin.size.height, margin/2, margin/2);
	
	quitButtonOrigin = CGRectMake(margin, jewelOrigin.origin.y-(margin*0.25), cardWidth-(margin*0.5), margin*2);
	runButtonOrigin  = CGRectMake(jewelOrigin.origin.x+(1.25*margin), jewelOrigin.origin.y-(margin*0.25), cardWidth-(margin), margin*2);
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
}

-(void)updateStage
{
	[self.card1Button setTitle:[NSString stringWithFormat:@"%d%@",[[playableHand card:0] number],[[playableHand card:0] symbol]] forState:UIControlStateNormal];
	[self.card2Button setTitle:[NSString stringWithFormat:@"%d%@",[[playableHand card:1] number],[[playableHand card:1] symbol]] forState:UIControlStateNormal];
	[self.card3Button setTitle:[NSString stringWithFormat:@"%d%@",[[playableHand card:2] number],[[playableHand card:2] symbol]] forState:UIControlStateNormal];
	[self.card4Button setTitle:[NSString stringWithFormat:@"%d%@",[[playableHand card:3] number],[[playableHand card:3] symbol]] forState:UIControlStateNormal];
	
	[self.card1Button setTitleColor:[[playableHand card:0] color] forState:UIControlStateNormal];
	[self.card2Button setTitleColor:[[playableHand card:1] color] forState:UIControlStateNormal];
	[self.card3Button setTitleColor:[[playableHand card:2] color] forState:UIControlStateNormal];
	[self.card4Button setTitleColor:[[playableHand card:3] color] forState:UIControlStateNormal];
	
	_card1Image.image = [[playableHand card:0] image];
	_card2Image.image = [[playableHand card:1] image];
	_card3Image.image = [[playableHand card:2] image];
	_card4Image.image = [[playableHand card:3] image];
	
	self.swordValueLabel.text = [NSString stringWithFormat:@"%d(%d)",[user equip], [user malus]];
	self.lifeValueLabel.text = [NSString stringWithFormat:@"%d",[user life]];
	self.discardValueLabel.text = [NSString stringWithFormat:@"%d(%d)",[user experience], [user room]];
	
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
	
	if([user escaped] == 1 && (int)[discardPile count] != 0){
		_runButton.enabled = false;
	}
	else if( [playableHand numberOfCards] < 2){
		_runButton.enabled = true;
	}
	else if( [playableHand numberOfCards] == 4){
		_runButton.enabled = true;
	}
	else
	{
		_runButton.enabled = false;
	}
	
	if( [playableHand numberOfCards] == 0){
		[_runButton setTitle:@"Enter room 4" forState:UIControlStateNormal];
		[NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(showMenu) userInfo:nil repeats:NO];
	}
	
}

# pragma mark - Cards Effects

-(void)healCard :(Card*)card
{
	int lifeBefore = [user life];
	[user gainLife:[card value]];
	justHealed = 1;
	// Exp
	[user gainExperience:([user life]-lifeBefore)];
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
		
		[self healCard:card];
		
		// Manip cards
		[discardPile addObject:[playableHand cardValue:cardNumber]];
		[playableHand discard:cardNumber];
		
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
	
	menuIsOpen = 0;
	[self hideMenu];
	
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
	[user setEscape:1];
	
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
	[UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		targetWrapper.frame = CGRectOffset(cardOrigin, 0, -10);
		targetWrapper.alpha = 0;
	} completion:^(BOOL finished){
		
		[self choice:((int)sender.tag-201)];
	
		[UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
			targetWrapper.frame = cardOrigin;
			targetWrapper.alpha = 1;
		} completion:^(BOOL finished){}];
	}];
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

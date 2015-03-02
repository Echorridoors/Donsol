//
//  deck.m
//  solitaryDongeon
//
//  Created by Devine Lu Linvega on 2015-02-27.
//  Copyright (c) 2015 Devine Lu Linvega. All rights reserved.
//

#import "Deck.h"

@implementation Deck

-(Deck*)init
{
	NSLog(@"+  DECK | Init");
	
	// Diamonds, spades, clubs, hearts
	
	cards = [[NSMutableArray alloc] initWithObjects:
					  @"1D",@"2D",@"3D",@"4D",@"5D",@"6D",@"7D",@"8D",@"9D",@"10D",@"11D",@"12D",@"13D",
					  @"1H",@"2H",@"3H",@"4H",@"5H",@"6H",@"7H",@"8H",@"9H",@"10H",@"11H",@"12H",@"13H",
					  @"1S",@"2S",@"3S",@"4S",@"5S",@"6S",@"7S",@"8S",@"9S",@"10S",@"11S",@"12S",@"13S",
					  @"1C",@"2C",@"3C",@"4C",@"5C",@"6C",@"7C",@"8C",@"9C",@"10C",@"11C",@"12C",@"13C",
					  @"1J",@"2J",
					  nil];
	
	for (int i = 0; i < [cards count]; i++ ) {
		
		int random = arc4random() % [cards count];
		
		NSString * temp1 = cards[i];
		cards[i] = cards[random];
		cards[random] = temp1;
		
	}
	
	return self;
}

-(void)addCard:(NSString*)card
{
	[cards addObject:card];
}

-(NSString*)pickCard
{
	NSLog(@"+  DECK | Picked card: %@",[cards objectAtIndex:0]);
	
	NSString * newCard = [cards objectAtIndex:0];
	[cards removeObjectAtIndex:0];
	return newCard;
}

@end

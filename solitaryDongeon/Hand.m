//
//  Hand.m
//  solitaryDongeon
//
//  Created by Devine Lu Linvega on 2015-02-27.
//  Copyright (c) 2015 Devine Lu Linvega. All rights reserved.
//

#import "Hand.h"
#import "Card.h"

@implementation Hand

-(Hand*)init
{
	cardsInHand = [[NSMutableArray alloc] init];
	[cardsInHand addObject:@"--"];
	[cardsInHand addObject:@"--"];
	[cardsInHand addObject:@"--"];
	[cardsInHand addObject:@"--"];
	
	return self;
}

-(void)pickCard:(NSString*)card
{
	int index = 0;
	for (NSString* card in cardsInHand) {
		if( [card isEqualToString:@"--"] ){ break; }
		index++;
	}
	
	[cardsInHand replaceObjectAtIndex:index withObject:card];
	
	NSLog(@"+  HAND | Picked card: %@(%lu in hand)",card, (unsigned long)[cardsInHand count] );
}

-(void)discard:(int)cardNumber
{
	NSLog(@"+  HAND | Discarded card: #%d (%d in hand)",cardNumber, (int)[cardsInHand count] );
	[cardsInHand replaceObjectAtIndex:cardNumber withObject:@"--"];
}

-(NSString*)cardValue:(int)cardNumber
{
	return cardsInHand[cardNumber];
}

-(NSArray*)cards
{
	return cardsInHand;
}

-(int)numberOfCards
{
	int count = 0;
	for (NSString* card in cardsInHand) {
		if( ![card isEqualToString:@"--"] ){
			count++;
		}
	}
	return count;
}

-(Card*)card :(int)cardNumber
{
	if( cardNumber < [cardsInHand count] ){
		
		Card * newCard = [[Card alloc] initWithString:cardsInHand[cardNumber]];
		return newCard;
	}
	
	return nil;
}

@end

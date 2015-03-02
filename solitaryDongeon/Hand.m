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
	
	return self;
}

-(void)pickCard:(NSString*)card
{
	[cardsInHand addObject:card];
	NSLog(@"+  HAND | Picked card: %@(%lu in hand)",card, (unsigned long)[cardsInHand count] );
}

-(void)discard:(int)cardNumber
{
	[cardsInHand removeObjectAtIndex:cardNumber];
	NSLog(@"+  HAND | Discarded card: #%d (%lu in hand)",cardNumber, (unsigned long)[cardsInHand count] );
}

-(NSString*)cardValue:(int)cardNumber
{
	return cardsInHand[cardNumber];
}

-(NSArray*)cards
{
	return cardsInHand;
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

//
//  Card.m
//  solitaryDongeon
//
//  Created by Devine Lu Linvega on 2015-02-27.
//  Copyright (c) 2015 Devine Lu Linvega. All rights reserved.
//

#import "Card.h"
#import <UIKit/UIKit.h>

@implementation Card

-(Card*)initWithString:(NSString*)cardData
{
	cardString = cardData;
	return self;
}

-(NSString*)type
{
	if( [cardString length] == 3){
		return [cardString substringFromIndex:2];
	}
	
	return [cardString substringFromIndex:1];
}

-(NSString*)symbol
{
	if( [[self type] isEqualToString:@"D"] ){ return @"♦︎"; }
	if( [[self type] isEqualToString:@"H"] ){ return @"♥︎"; }
	if( [[self type] isEqualToString:@"C"] ){ return @"♣︎"; }
	if( [[self type] isEqualToString:@"J"] ){ return @"@"; }
	return @"♠︎";
}

-(UIColor*)color
{
	if( [[self type] isEqualToString:@"D"] ){ return [UIColor redColor]; }
	if( [[self type] isEqualToString:@"H"] ){ return [UIColor redColor]; }
	if( [[self type] isEqualToString:@"C"] ){ return [UIColor blackColor]; }
	if( [[self type] isEqualToString:@"J"] ){ return [UIColor purpleColor]; }
	return [UIColor blackColor];
}

-(int)number
{
	int cardValue = [[cardString substringToIndex:1] intValue];
	
	if( [cardString length] == 3){
		cardValue = [[cardString substringToIndex:2] intValue];
	}
	return cardValue;
}

-(int)value
{
	int cardValue = [[cardString substringToIndex:1] intValue];
	
	if( [cardString length] == 3){
		cardValue = [[cardString substringToIndex:2] intValue];
	}
	
	// Black Cards
	if( [self color] == [UIColor blackColor] ){
		if(cardValue == 1){ cardValue = 17;}
		else if(cardValue == 12){ cardValue = 13;}
		else if(cardValue == 13){ cardValue = 15;}
	}
	
	// Red Cards
	if( [self color] == [UIColor redColor] ){
		if( cardValue == 1 ){ cardValue = 11; }
		else if( cardValue == 12 ){ cardValue = 11; }
		else if( cardValue == 13 ){ cardValue = 11; }
	}
	
	return cardValue;
}

@end

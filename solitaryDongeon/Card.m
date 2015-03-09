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
	if( [[self type] isEqualToString:@"J"] ){ return @"J"; }
	if( [[self type] isEqualToString:@"-"] ){ return @"-"; }
	return @"♠︎";
}

-(UIColor*)color
{
	if( [[self type] isEqualToString:@"D"] ){ return [UIColor redColor]; }
	if( [[self type] isEqualToString:@"H"] ){ return [UIColor redColor]; }
	if( [[self type] isEqualToString:@"C"] ){ return [UIColor blackColor]; }
	if( [[self type] isEqualToString:@"J"] ){ return [UIColor purpleColor]; }
	if( [[self type] isEqualToString:@"-"] ){ return [UIColor yellowColor]; }
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
	
	// Etc
	if( [self number] == 0 ){
		cardValue = 0;
	}
	
	return cardValue;
}

-(UIImage*)image
{
	NSString * cardImageString = @"card.0055";
	
	if([cardString isEqualToString:@"1S"]) { cardImageString = @"card.0000";}
	if([cardString isEqualToString:@"2S"]) { cardImageString = @"card.0001";}
	if([cardString isEqualToString:@"3S"]) { cardImageString = @"card.0002";}
	if([cardString isEqualToString:@"4S"]) { cardImageString = @"card.0003";}
	if([cardString isEqualToString:@"5S"]) { cardImageString = @"card.0004";}
	if([cardString isEqualToString:@"6S"]) { cardImageString = @"card.0005";}
	if([cardString isEqualToString:@"7S"]) { cardImageString = @"card.0006";}
	if([cardString isEqualToString:@"8S"]) { cardImageString = @"card.0007";}
	if([cardString isEqualToString:@"9S"]) { cardImageString = @"card.0008";}
	if([cardString isEqualToString:@"10S"]){ cardImageString = @"card.0009";}
	if([cardString isEqualToString:@"11S"]){ cardImageString = @"card.0010";}
	if([cardString isEqualToString:@"12S"]){ cardImageString = @"card.0011";}
	if([cardString isEqualToString:@"13S"]){ cardImageString = @"card.0012";}
	
	if([cardString isEqualToString:@"1H"]) { cardImageString = @"card.0013";}
	if([cardString isEqualToString:@"2H"]) { cardImageString = @"card.0014";}
	if([cardString isEqualToString:@"3H"]) { cardImageString = @"card.0015";}
	if([cardString isEqualToString:@"4H"]) { cardImageString = @"card.0016";}
	if([cardString isEqualToString:@"5H"]) { cardImageString = @"card.0017";}
	if([cardString isEqualToString:@"6H"]) { cardImageString = @"card.0018";}
	if([cardString isEqualToString:@"7H"]) { cardImageString = @"card.0019";}
	if([cardString isEqualToString:@"8H"]) { cardImageString = @"card.0020";}
	if([cardString isEqualToString:@"9H"]) { cardImageString = @"card.0021";}
	if([cardString isEqualToString:@"10H"]){ cardImageString = @"card.0022";}
	if([cardString isEqualToString:@"11H"]){ cardImageString = @"card.0023";}
	if([cardString isEqualToString:@"12H"]){ cardImageString = @"card.0024";}
	if([cardString isEqualToString:@"13H"]){ cardImageString = @"card.0025";}
	
	if([cardString isEqualToString:@"1C"]) { cardImageString = @"card.0026";}
	if([cardString isEqualToString:@"2C"]) { cardImageString = @"card.0027";}
	if([cardString isEqualToString:@"3C"]) { cardImageString = @"card.0028";}
	if([cardString isEqualToString:@"4C"]) { cardImageString = @"card.0029";}
	if([cardString isEqualToString:@"5C"]) { cardImageString = @"card.0030";}
	if([cardString isEqualToString:@"6C"]) { cardImageString = @"card.0031";}
	if([cardString isEqualToString:@"7C"]) { cardImageString = @"card.0032";}
	if([cardString isEqualToString:@"8C"]) { cardImageString = @"card.0033";}
	if([cardString isEqualToString:@"9C"]) { cardImageString = @"card.0034";}
	if([cardString isEqualToString:@"10C"]){ cardImageString = @"card.0035";}
	if([cardString isEqualToString:@"11C"]){ cardImageString = @"card.0036";}
	if([cardString isEqualToString:@"12C"]){ cardImageString = @"card.0037";}
	if([cardString isEqualToString:@"13C"]){ cardImageString = @"card.0038";}
	
	if([cardString isEqualToString:@"1D"]) { cardImageString = @"card.0039";}
	if([cardString isEqualToString:@"2D"]) { cardImageString = @"card.0040";}
	if([cardString isEqualToString:@"3D"]) { cardImageString = @"card.0041";}
	if([cardString isEqualToString:@"4D"]) { cardImageString = @"card.0042";}
	if([cardString isEqualToString:@"5D"]) { cardImageString = @"card.0043";}
	if([cardString isEqualToString:@"6D"]) { cardImageString = @"card.0044";}
	if([cardString isEqualToString:@"7D"]) { cardImageString = @"card.0045";}
	if([cardString isEqualToString:@"8D"]) { cardImageString = @"card.0046";}
	if([cardString isEqualToString:@"9D"]) { cardImageString = @"card.0047";}
	if([cardString isEqualToString:@"10D"]){ cardImageString = @"card.0048";}
	if([cardString isEqualToString:@"11D"]){ cardImageString = @"card.0049";}
	if([cardString isEqualToString:@"12D"]){ cardImageString = @"card.0050";}
	if([cardString isEqualToString:@"13D"]){ cardImageString = @"card.0051";}
	
	if([cardString isEqualToString:@"1J"]){ cardImageString = @"card.0052";}
	if([cardString isEqualToString:@"2J"]){ cardImageString = @"card.0053";}
	
	return [UIImage imageNamed:cardImageString];
}

@end

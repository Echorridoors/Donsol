//
//  Hand.h
//  solitaryDongeon
//
//  Created by Devine Lu Linvega on 2015-02-27.
//  Copyright (c) 2015 Devine Lu Linvega. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Card.h"

@interface Hand : NSObject

-(void)pickCard:(NSString*)card;
-(NSString*)cardValue:(int)cardNumber;
-(void)discard:(int)cardNumber;
-(NSArray*)cards;

-(Card*)card :(int)cardNumber;

@end

NSMutableArray * cardsInHand;
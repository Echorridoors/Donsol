//
//  deck.h
//  solitaryDongeon
//
//  Created by Devine Lu Linvega on 2015-02-27.
//  Copyright (c) 2015 Devine Lu Linvega. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Deck : NSObject

-(NSString*)pickCard;
-(void)addCard:(NSString*)card;
-(NSArray*)cards;

@end

NSMutableArray * cards;
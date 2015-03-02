//
//  User.h
//  solitaryDongeon
//
//  Created by Devine Lu Linvega on 2015-02-27.
//  Copyright (c) 2015 Devine Lu Linvega. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface User : NSObject

-(void)gainLife :(int)value;
-(void)gainEquip :(int)value;
-(void)looseLife :(int)value;
-(int)life;
-(int)equip;
-(int)room;
-(void)nextRoom;
-(int)malus;
-(void)setMalus:(int)value;
-(void)looseEquip;
-(void)setEscape :(int)value;
-(int)escaped;

-(Card*)lastCard;
-(void)setLastCard :(Card*)card;

@end

int life;
int equip;
int room;
int malus;
int escaped;

Card * lastCard;
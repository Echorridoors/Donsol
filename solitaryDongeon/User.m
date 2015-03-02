//
//  User.m
//  solitaryDongeon
//
//  Created by Devine Lu Linvega on 2015-02-27.
//  Copyright (c) 2015 Devine Lu Linvega. All rights reserved.
//

#import "User.h"
#import "Card.h"

@implementation User

-(User*)init
{
	life = 21;
	malus = 25;
	escaped = 0;
	return self;
}

-(int)life
{
	return life;
}

-(int)equip
{
	return equip;
}

-(int)escaped
{
	return escaped;
}

-(void)setEscape :(int)value
{
	escaped = value;
}

-(void)setLastCard :(Card*)card
{
	lastCard = card;
}

-(Card*)lastCard
{
	return lastCard;
}

-(int)room
{
	return room;
}

-(void)nextRoom
{
	room = room + 1;
}

-(int)malus
{
	return malus;
}

-(void)setMalus:(int)value
{
	malus = value;
	NSLog(@"malus is now %d", malus);
}

-(void)gainLife :(int)value
{
	life = life + value;
	if( (int)life > 21 ){ life = 21; }
	
	NSLog(@":  USER | Life: %d", life);
}

-(void)looseLife :(int)value
{
	life = life - value;
	
	NSLog(@":  USER | Life: %d", life);
}

-(void)gainEquip :(int)value
{
	NSLog(@":  USER | Equip: %d", value);
	equip = value;
}

-(void)looseEquip
{
	NSLog(@":  USER | Equip: Lost!");
	equip = 0;
}

@end

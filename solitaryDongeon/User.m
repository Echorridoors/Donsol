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
	room = 1;
	difficulty = 1;
	equip = 0;
	return self;
}
-(int)lifeMaximum
{
	return 21+(difficulty-1);
}

-(int)difficulty
{
	return difficulty;
}
-(void)setDifficulty :(int)newDifficulty
{
	difficulty = newDifficulty;
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
	NSLog(@": MALUS | %d", malus);
}

# pragma mark Life -

-(void)gainLife :(int)value
{
	life = life + value;
	if( (int)life > [self lifeMaximum] ){ life = [self lifeMaximum]; }
	
	NSLog(@":  USER | Life: %d", life);
}

-(void)looseLife :(int)value
{
	life = life - value;
	
	NSLog(@":  USER | Life: %d", life);
}

# pragma mark Equip -

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

# pragma mark Experience -

-(void)gainExperience :(int)value
{
	if( value < 0 ){ value = 0; }
	experience = experience + value;
	NSLog(@":  USER | Experience: Gained %dXP", experience);
}

-(int)experience
{
	return experience;
}

@end

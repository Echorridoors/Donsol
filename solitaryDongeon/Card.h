//
//  Card.h
//  solitaryDongeon
//
//  Created by Devine Lu Linvega on 2015-02-27.
//  Copyright (c) 2015 Devine Lu Linvega. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface Card : NSObject

-(Card*)initWithString:(NSString*)cardData;
-(NSString*)type;
-(int)value;
-(NSString*)symbol;
-(UIColor*)color;
-(int)number;

@end

NSString *cardString;
//
//  ViewController.h
//  solitaryDongeon
//
//  Created by Devine Lu Linvega on 2015-02-27.
//  Copyright (c) 2015 Devine Lu Linvega. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "Hand.h"
#import "User.h"

@interface ViewController : UIViewController

@end

Deck * playableDeck;
Hand * playableHand;
User * user;

NSMutableArray * discardPile;
//
//  Menu.m
//  solitaryDongeon
//
//  Created by Devine Lu Linvega on 2015-03-12.
//  Copyright (c) 2015 Devine Lu Linvega. All rights reserved.
//

#import "Menu.h"
#import "ViewController.h"
#import "User.h"

@implementation Menu

-(void)viewDidLoad
{
	[self start];
	NSLog(@"wat");
}

-(void)start
{
	[self templateStart];
	[self template];
}


-(void)templateStart
{
	margin = self.view.frame.size.width/16;
}

-(void)template
{
	_enterButton.frame = CGRectMake(margin, self.view.frame.size.height-(3*margin), self.view.frame.size.width-(2*margin), margin);
	_menuButton.frame = CGRectMake(margin, self.view.frame.size.height-(3*margin), self.view.frame.size.width-(2*margin), margin);
	_optionsButton.frame = CGRectMake(margin, self.view.frame.size.height-(3*margin), margin, margin);
	_scoreLabel.frame = CGRectMake(margin, self.view.frame.size.height-(5*margin), self.view.frame.size.width-(2*margin), margin);
	
	_scoreLabel.text = [NSString stringWithFormat:@"%d",[user loadHighScore]];
}

- (BOOL)prefersStatusBarHidden {
	return YES;
}

@end

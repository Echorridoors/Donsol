//
//  Menu.m
//  solitaryDongeon
//
//  Created by Devine Lu Linvega on 2015-03-12.
//  Copyright (c) 2015 Devine Lu Linvega. All rights reserved.
//

#import "Menu.h"
#import "ViewController.h"

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
}

- (BOOL)prefersStatusBarHidden {
	return YES;
}

@end

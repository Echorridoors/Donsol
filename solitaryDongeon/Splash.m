//
//  Splash.m
//  Donsol
//
//  Created by Devine Lu Linvega on 2015-03-22.
//  Copyright (c) 2015 Devine Lu Linvega. All rights reserved.
//

#import "Splash.h"

@interface Splash ()

@end

@implementation Splash

- (void)viewDidLoad {
    [super viewDidLoad];
	[slideTimer invalidate];
	slideTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(splashSkip) userInfo:nil repeats:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)splashSkip
{
	[self performSegueWithIdentifier: @"skip" sender: self];
}

@end

//
//  xxiivvSplashExtraSlide.m
//  Donsol
//
//  Created by Devine Lu Linvega on 2015-06-17.
//  Copyright (c) 2015 Devine Lu Linvega. All rights reserved.
//

#import "xxiivvSplashExtraSlide.h"

UIImageView * logoView;

@interface xxiivvSplashExtraSlide ()

@end

@implementation xxiivvSplashExtraSlide

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self splashTemplate];
	NSLog(@"Reached!");
	
	[NSTimer scheduledTimerWithTimeInterval:2.25 target:self selector:@selector(splashClose) userInfo:nil repeats:NO]; // Uncomment
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) splashTemplate
{
	CGRect screen = [[UIScreen mainScreen] bounds];
	float screenMargin = screen.size.width/8;
	
	// Create logo
	logoView = [[UIImageView alloc] initWithFrame:CGRectMake((screen.size.width/2)-60, (screen.size.height/2)-60, 120, 120)];
	logoView.image = [UIImage imageNamed:@"splash.logo.eternal"];
	logoView.contentMode = UIViewContentModeCenter;
	logoView.contentMode = UIViewContentModeScaleAspectFit;
	[self.view addSubview:logoView];
}

- (void) splashClose
{
	[self performSegueWithIdentifier: @"skip" sender: self];
}

@end

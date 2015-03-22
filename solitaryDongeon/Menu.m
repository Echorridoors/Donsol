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
}

-(void)start
{
	[self templateStart];
	[self template];
	[self generateCastle];
	
}

-(void)generateCastle
{
	NSLog(@"Generate Castle");
	
	int verticalTilesCount = 9;
	float matrix[8][verticalTilesCount];
	int towersLength = 3;
	
	// Create Blank
	
	for (int x=0; x<8; x++)
	{
		for (int y=0; y<verticalTilesCount; y++)
		{
			matrix[x][y] = 0;
		}
	}
	
	// Create Peaks(1)
	
	for (int x=0; x<8; x++)
	{
		for (int y=0; y<towersLength; y++)
		{
			if( arc4random() % 5 == 0 ){
				matrix[x][y] = 1;
			}
			
		}
	}
	
	// Create Towers(2)
	
	for (int y=0; y<towersLength; y++)
	{
		for (int x=0; x<verticalTilesCount; x++)
		{
			if( (int)matrix[x][y] == 1 ){
				
				matrix[x][y+1] = 2;
				if( arc4random() % 3 == 0 ){
					matrix[x][y+2] = 2;
				}
				if( arc4random() % 4 == 0 ){
					matrix[x][y+3] = 2;
				}
			}
		}
	}
	
	// Create bridges(3)
	
	for (int y=0; y<verticalTilesCount; y++)
	{
		for (int x=0; x<8; x++)
		{
			if( matrix[x][y-1] == 2 && matrix[x][y] == 0 ){
				matrix[x][y] = 3;
				if( x < 7){
					matrix[x+1][y] = 3;
				}
				if( x > 0){
					matrix[x-1][y] = 3;
				}
			}
		}
	}
	
	// Create fort(4)
	
	for (int y=0; y<verticalTilesCount; y++)
	{
		for (int x=0; x<8; x++)
		{
			if( (matrix[x][y-1] == 3 && matrix[x][y] == 0) || (matrix[x][y-1] == 3 && matrix[x][y] == 4) ){
				matrix[x][y] = 3;
				if( x < 7){
					matrix[x+1][y] = 4;
				}
				if( x > 0){
					matrix[x-1][y] = 4;
				}
			}
		}
	}
	
	// Create joints-between fort and tower(5)
	
	for (int y=0; y<verticalTilesCount; y++)
	{
		for (int x=0; x<8; x++)
		{
			if( matrix[x][y-1] == 2 && matrix[x][y+1] == 4 ){
				matrix[x][y] = 5;
			}
		}
	}
	
	// Create fills(6)
	
	for (int y=0; y<verticalTilesCount; y++)
	{
		for (int x=0; x<8; x++)
		{
			if( matrix[x][y-1] > 0 && matrix[x][y] == 0 && y > 0 ){
				matrix[x][y] = 4;
			}
		}
	}
	
	// Correct towers(2)
	
	for (int y=0; y<verticalTilesCount; y++)
	{
		for (int x=0; x<8; x++)
		{
			if( matrix[x][y-1] == 2 && matrix[x][y+1] == 2 && matrix[x][y] == 1 ){
				matrix[x][y] = 2;
			}
		}
	}
	
	// Correct forts(3)
	
	for (int y=0; y<verticalTilesCount; y++)
	{
		for (int x=0; x<8; x++)
		{
			if( matrix[x][y-1] == 0 && matrix[x][y] == 4 ){
				matrix[x][y] = 3;
			}
		}
	}
	
	// Correct joints(5)
	
	for (int y=0; y<verticalTilesCount; y++)
	{
		for (int x=0; x<8; x++)
		{
			if( matrix[x][y-1] == 2 && matrix[x][y] == 3 ){
				matrix[x][y] = 5;
			}
			if( matrix[x][y-1] == 1 && matrix[x][y] == 3 ){
				matrix[x][y] = 5;
			}
		}
	}
	
	// Add doors(7)
	
	for (int y=0; y<verticalTilesCount; y++)
	{
		for (int x=0; x<8; x++)
		{
			if( matrix[x][y] == 1 ){
				if(arc4random() % 4 == 0){
					matrix[x][verticalTilesCount-1] = 7;
				}
			}
		}
	}
	
	// Correct filling(5)
	
	for (int y=0; y<verticalTilesCount; y++)
	{
		for (int x=0; x<8; x++)
		{
			if( matrix[x][y-1] == 3 && matrix[x][y] == 3 ){
				matrix[x][y] = 4;
			}
			if( matrix[x][y-1] > 0 && matrix[x][y] == 3 ){
				matrix[x][y] = 4;
			}
		}
	}
	
	// Add windows(6)
	
	for (int y=0; y<verticalTilesCount; y++)
	{
		for (int x=0; x<8; x++)
		{
			if( matrix[x][y-1] == 4 && matrix[x][y+1] == 4 && matrix[x-1][y] == 4 && matrix[x+1][y] == 4 ){
				if( matrix[x-1][y-1] == 4 && matrix[x+1][y+1] == 4 && matrix[x-1][y+1] == 4 && matrix[x+1][y-1] == 4 ){
					matrix[x][y] = 6;
				}
			}
		}
	}
	
	// Add grass(8)
	
	for (int x=0; x<8; x++)
	{
		if( matrix[x][verticalTilesCount-1] == 0 ){
			matrix[x][verticalTilesCount-1] = 8;
		}
	}
	
	// Add different fils(9)
	
	for (int y=0; y<verticalTilesCount; y++)
	{
		for (int x=0; x<8; x++)
		{
			if( matrix[x][y] == 4 && arc4random() % 3 == 0 ){
				matrix[x][y] = 9;
			}
			if( matrix[x][y] == 4 && arc4random() % 13 == 0 ){
				matrix[x][y] = 10;
			}
		}
	}
	
	// Add stars
	
	for (int y=0; y<verticalTilesCount; y++)
	{
		for (int x=0; x<8; x++)
		{
			if( matrix[x][y-1] == 0 && matrix[x][y+1] == 0 && matrix[x-1][y] == 0 && matrix[x+1][y] == 0 ){
				if( matrix[x-1][y-1] == 0 && matrix[x+1][y+1] == 0 && matrix[x-1][y+1] == 0 && matrix[x+1][y-1] == 0 ){
					if (arc4random() % 4 == 0 ) {
						matrix[x][y] = 11;
					}
					
				}
			}
		}
	}
	
	// Empty View
	
	NSArray *viewsToRemove = [self.castleView subviews];
	for (UIView *v in viewsToRemove) {
		[v removeFromSuperview];
	}
	
	// Print
	
	CGFloat margin = self.view.frame.size.width/16;
	CGFloat tileSize = (self.view.frame.size.width - (2*margin))/8;
	
	self.castleView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width);
	self.castleView.backgroundColor = [UIColor clearColor];
	
	for (int x=0; x<8; x++)
	{
		for (int y=0; y<verticalTilesCount; y++)
		{
			NSLog(@"x:%d y:%d - > %d", x,y,(int)matrix[x][y] );
			
			UIImageView * castleTile = [[UIImageView alloc] initWithFrame:CGRectMake(margin + (tileSize*x), margin + (tileSize*y), tileSize, tileSize)];
			
			castleTile.backgroundColor = [UIColor blackColor];
			
			if( matrix[x][y] == 1 ){
				castleTile.image = [UIImage imageNamed:@"piece.tower"];
			}
			if( matrix[x][y] == 2 ){
				castleTile.image = [UIImage imageNamed:@"piece.vertical"];
			}
			if( matrix[x][y] == 3 ){
				castleTile.image = [UIImage imageNamed:@"piece.edge"];
			}
			if( matrix[x][y] == 4 ){
				castleTile.image = [UIImage imageNamed:@"piece.fill.1"];
			}
			if( matrix[x][y] == 5 ){
				castleTile.image = [UIImage imageNamed:@"piece.junction"];
			}
			if( matrix[x][y] == 6 ){
				castleTile.image = [UIImage imageNamed:@"piece.window"];
			}
			if( matrix[x][y] == 7 ){
				castleTile.image = [UIImage imageNamed:@"piece.door"];
			}
			if( matrix[x][y] == 8 ){
				castleTile.image = [UIImage imageNamed:@"piece.grass"];
			}
			if( matrix[x][y] == 9 ){
				castleTile.image = [UIImage imageNamed:@"piece.fill.2"];
			}
			if( matrix[x][y] == 10 ){
				castleTile.image = [UIImage imageNamed:@"piece.fill.3"];
			}
			if( matrix[x][y] == 11 ){
				castleTile.image = [UIImage imageNamed:@"piece.star"];
			}
			
			[self.castleView addSubview:castleTile];
		}
	}
	
	
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
	_scoreLabel.frame = CGRectMake(margin, self.view.frame.size.height-(7*margin), self.view.frame.size.width-(2*margin), margin*2);
	
	_scoreLabel.text = [NSString stringWithFormat:@"%d",[user loadHighScore]];
	_scoreLabel.textColor = [UIColor colorWithWhite:0.3 alpha:1];
}

- (BOOL)prefersStatusBarHidden {
	return YES;
}

@end

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

typedef NS_ENUM(NSInteger, CastleTile) {
    CastleBlank,
    CastlePeak,
    CastleTower,
    CastleBridge,
    CastleFort,
    CastleJoint,
    CastleFill,
    CastleDoor,
    CastleGrass
};

-(void)generateCastle
{
	NSLog(@"Generate Castle");
	
	float matrix[8][8];
	
	// Create Blank
	
	for (int x=0; x<8; x++)
	{
		for (int y=0; y<8; y++)
		{
			matrix[x][y] = CastleBlank;
		}
	}
	
	// Create Peaks(1)
	
	for (int x=0; x<8; x++)
	{
		for (int y=0; y<3; y++)
		{
			if( arc4random() % 5 == 0 ){
				matrix[x][y] = CastlePeak;
			}
			
		}
	}
	
	// Create Towers(2)
	
	for (int y=0; y<3; y++)
	{
		for (int x=0; x<8; x++)
		{
			if( (int)matrix[x][y] == CastlePeak ){
				
				matrix[x][y+1] = CastleTower;
				if( arc4random() % 3 == 0 ){
					matrix[x][y+2] = CastleTower;
				}
				if( arc4random() % 4 == 0 ){
					matrix[x][y+3] = CastleTower;
				}
			}
		}
	}
	
	// Create bridges(3)
	
	for (int y=0; y<8; y++)
	{
		for (int x=0; x<8; x++)
		{
			if( matrix[x][y-1] == CastleTower && matrix[x][y] == CastleBlank ){
				matrix[x][y] = CastleBridge;
				if( x < 7){
					matrix[x+1][y] = CastleBridge;
				}
				if( x > 0){
					matrix[x-1][y] = CastleBridge;
				}
			}
		}
	}
	
	// Create fort(4)
	
	for (int y=0; y<8; y++)
	{
		for (int x=0; x<8; x++)
		{
			if( (matrix[x][y-1] == CastleBridge && matrix[x][y] == CastleBlank) || (matrix[x][y-1] == CastleBridge && matrix[x][y] == CastleFort) ){
				matrix[x][y] = CastleBridge;
				if( x < 7){
					matrix[x+1][y] = CastleFort;
				}
				if( x > 0){
					matrix[x-1][y] = CastleFort;
				}
			}
		}
	}
	
	// Create joints-between fort and tower(5)
	
	for (int y=0; y<8; y++)
	{
		for (int x=0; x<8; x++)
		{
			if( matrix[x][y-1] == CastleTower && matrix[x][y+1] == CastleFort ){
				matrix[x][y] = CastleJoint;
			}
		}
	}
	
	// Create fills(6)
	
	for (int y=0; y<8; y++)
	{
		for (int x=0; x<8; x++)
		{
			if( matrix[x][y-1] > CastleBlank && matrix[x][y] == CastleBlank && y > 0 ){
				matrix[x][y] = CastleFort;
			}
		}
	}
	
	// Correct towers(2)
	
	for (int y=0; y<8; y++)
	{
		for (int x=0; x<8; x++)
		{
			if( matrix[x][y-1] == CastleTower && matrix[x][y+1] == CastleTower && matrix[x][y] == CastlePeak ){
				matrix[x][y] = CastleTower;
			}
		}
	}
	
	// Correct forts(3)
	
	for (int y=0; y<8; y++)
	{
		for (int x=0; x<8; x++)
		{
			if( matrix[x][y-1] == CastleBlank && matrix[x][y] == CastleFort ){
				matrix[x][y] = CastleBridge;
			}
		}
	}
	
	// Correct joints(5)
	
	for (int y=0; y<8; y++)
	{
		for (int x=0; x<8; x++)
		{
			if( matrix[x][y-1] == CastleTower && matrix[x][y] == CastleBridge ){
				matrix[x][y] = CastleJoint;
			}
			if( matrix[x][y-1] == CastlePeak && matrix[x][y] == CastleBridge ){
				matrix[x][y] = CastleJoint;
			}
		}
	}
	
	// Add doors(7)
	
	for (int y=0; y<8; y++)
	{
		for (int x=0; x<8; x++)
		{
			if( matrix[x][y] == CastlePeak ){
				if(arc4random() % 4 == 0){
					matrix[x][7] = CastleDoor;
				}
			}
		}
	}
	
	// Correct filling(5)
	
	for (int y=0; y<8; y++)
	{
		for (int x=0; x<8; x++)
		{
			if( matrix[x][y-1] == CastleBridge && matrix[x][y] == CastleBridge ){
				matrix[x][y] = CastleFort;
			}
			if( matrix[x][y-1] > CastleBlank && matrix[x][y] == CastleBridge ){
				matrix[x][y] = CastleFort;
			}
		}
	}
	
	// Add windows(6)
	
	for (int y=0; y<8; y++)
	{
		for (int x=0; x<8; x++)
		{
			if( matrix[x][y-1] == CastleFort && matrix[x][y+1] == CastleFort && matrix[x-1][y] == CastleFort && matrix[x+1][y] == CastleFort ){
				if( matrix[x-1][y-1] == CastleFort && matrix[x+1][y+1] == CastleFort && matrix[x-1][y+1] == CastleFort && matrix[x+1][y-1] == CastleFort ){
					matrix[x][y] = CastleFill;
				}
			}
		}
	}
	
	// Add grass(8)
	
	for (int x=0; x<8; x++)
	{
		if( matrix[x][7] == CastleBlank ){
			matrix[x][7] = CastleGrass;
		}
	}
	
	
	// Print
	
	CGFloat margin = self.view.frame.size.width/16;
	CGFloat tileSize = (self.view.frame.size.width - (2*margin))/8;
	
	self.castleView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width);
	self.castleView.backgroundColor = [UIColor clearColor];
	
	for (int x=0; x<8; x++)
	{
		for (int y=0; y<8; y++)
		{
			NSLog(@"x:%d y:%d - > %d", x,y,(int)matrix[x][y] );
			
			UIImageView * castleTile = [[UIImageView alloc] initWithFrame:CGRectMake(margin + (tileSize*x), margin + (tileSize*y), tileSize, tileSize)];
			
			castleTile.backgroundColor = [UIColor blackColor];

            switch ((int)matrix[x][y]) {
                case CastlePeak:
                    castleTile.image = [UIImage imageNamed:@"piece.tower"];
                    break;
                case CastleTower:
                    castleTile.image = [UIImage imageNamed:@"piece.vertical"];
                    break;
                case CastleBridge:
                    castleTile.image = [UIImage imageNamed:@"piece.edge"];
                    break;
                case CastleFort:
                    castleTile.image = [UIImage imageNamed:@"piece.fill.1"];
                    break;
                case CastleJoint:
                    castleTile.image = [UIImage imageNamed:@"piece.junction"];
                    break;
                case CastleFill:
                    castleTile.image = [UIImage imageNamed:@"piece.window"];
                    break;
                case CastleDoor:
                    castleTile.image = [UIImage imageNamed:@"piece.door"];
                    break;
                case CastleGrass:
                    castleTile.image = [UIImage imageNamed:@"piece.grass"];
                    break;
                default:
                    break;
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

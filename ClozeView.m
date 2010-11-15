//
//  ClozeView.m
//  OmarMariam
//
//  Created by A.L.L.Y.K. on 10/26/10.
//  Copyright 2010 Brainstorm Technologies Sdn Bhd. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ClozeView.h"


@implementation ClozeView

@synthesize viewController, activeImageView, activeLabel, hitPoint;
@synthesize gameview;
@synthesize pathToMusicFile, soundPlay;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (void)awakeFromNib {
	self.pathToMusicFile = [[NSString alloc] initWithString:
							[[NSBundle mainBundle] pathForResource:@"correct"
															ofType:@"mp3"]];
	/*
	 * Success sound
	 */
	
	self.soundPlay = [[AVAudioPlayer alloc] init];

	self.soundPlay = [soundPlay initWithContentsOfURL:[NSURL fileURLWithPath:self.pathToMusicFile] 
												error:NULL];
	self.soundPlay.delegate = self;
	
	[self.soundPlay prepareToPlay];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	//NSLog(@"touches began");
	
	for (UITouch *touch in touches) 
	{
		//for (UIImageView *imageView in [self.viewController imageViews]) 
		for (UILabel *label in [self.viewController labelViews])
		{
			if (CGRectContainsPoint([label frame], [touch locationInView:self.superview]) 
				&& label.tag != -1) 
			{
				// find 2 hierarchy of views.
				
				UILabel * copiedActiveLabel = [[UILabel alloc] initWithFrame:label.frame];
				
				copiedActiveLabel.text = label.text;
				copiedActiveLabel.tag = label.tag;
				copiedActiveLabel.font = [UIFont systemFontOfSize:40];
				copiedActiveLabel.textColor = [UIColor colorWithRed:0./255. green:51./255. blue:111./255. alpha:1.];
				copiedActiveLabel.backgroundColor = label.backgroundColor;
				
				//[label removeFromSuperview];
				[self.gameview addSubview:copiedActiveLabel];
				self.activeLabel = copiedActiveLabel;
				
				copiedActiveLabel.center = [touch locationInView:self.gameview];
				
				self.hitPoint = copiedActiveLabel.center;
				
				[copiedActiveLabel release];
				label.hidden = YES;
				
				
				return;
			}
		}
	}
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	//NSLog(@"touches moved");
	for (UITouch *touch in touches) 
	{
		
		[self bringSubviewToFront:self.activeLabel];
		
		self.activeLabel.center = [touch locationInView:self.gameview];		
	}
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	//activeImageView = nil;
	
	for (UITouch * touch in touches) 
	{	
		for (UIView * dropView in [self.viewController dropViews]) 
		{		
			//NSLog(@"%d %d", dropView.tag, activeLabel.tag);
			if (CGRectContainsPoint([dropView frame], [touch locationInView:self.gameview])
				&& dropView.tag == activeLabel.tag)
			{
				//NSLog(@"MATCHED");
					  
				UILabel *_matchedWord = [[UILabel alloc] initWithFrame:CGRectZero];
				
				CGRect aFrame;
				aFrame.size = activeLabel.frame.size;
				
				_matchedWord.text = activeLabel.text;
				_matchedWord.frame = aFrame;
				_matchedWord.backgroundColor = activeLabel.backgroundColor;
				_matchedWord.textColor = activeLabel.textColor;
				_matchedWord.center = [dropView convertPoint:dropView.center fromView:self.gameview];
				_matchedWord.font = activeLabel.font;
				
				[dropView addSubview:_matchedWord];
				
				[self.soundPlay play];
				/*
				 * Check question and move to next level if completed.
				 */
				viewController.questionLeft = viewController.questionLeft - 1;
				if ([viewController noQuestionLeft]) 
				{
					[viewController nextLevel];
				}
				
				//				activeLabel.center = dropView.center;
				activeLabel.tag = -1;	
				[activeLabel removeFromSuperview];
				[activeLabel release];
				activeLabel = nil;
				
				break;
			}
			
		}
		
		if (nil != activeLabel) {
			for (UILabel *_theLabel in [self.viewController labelViews]) {
				if (_theLabel.tag == activeLabel.tag) {
					_theLabel.hidden = NO;
				}
			}
		}
		
		[activeLabel removeFromSuperview];
		[activeLabel release];
		activeLabel = nil;
	}
	
}
/*
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSLog(@"touches cancel");
} */

@end

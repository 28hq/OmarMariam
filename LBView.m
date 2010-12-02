//
//  LBView.m
//  OmarMariam
//
//  Created by A.L.L.Y.K. on 11/14/10.
//  Copyright 2010 Brainstorm Technologies Sdn Bhd. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "LBView.h"
#import "Constants.h"

@implementation LBView

@synthesize viewController;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc {
    [super dealloc];
}

- (void)createButton {
	
	CATransition *transition = [CATransition animation];
	transition.duration = .3;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	
	//NSString *transitionTypes[4] = { kCATransitionPush, kCATransitionMoveIn, kCATransitionReveal, kCATransitionFade };
	transition.type = kCATransitionMoveIn;
	
	//NSString *transitionSubtypes[4] = { kCATransitionFromRight, kCATransitionFromLeft, kCATransitionFromTop, kCATransitionFromBottom };
	transition.subtype = kCATransitionFromBottom;
	
	// main library.
	UIButton *toBookMenu = [UIButton buttonWithType:UIButtonTypeCustom];
	toBookMenu.tag = kButtonsView;
	toBookMenu.frame = CGRectMake(5.0, 5.0, 150.0, 30.0);
	toBookMenu.backgroundColor = [UIColor brownColor];
	toBookMenu.alpha = 0.8;
	
	toBookMenu.titleLabel.font = [UIFont boldSystemFontOfSize:18];
	[toBookMenu setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
	[toBookMenu setTitle:@"Book Menu" forState:UIControlStateNormal];
	
	toBookMenu.layer.borderColor = [[UIColor blackColor] CGColor];
	toBookMenu.layer.borderWidth = 1;
	toBookMenu.layer.cornerRadius = 5;
	
	[toBookMenu addTarget:self.viewController 
				   action:@selector(toBookMenu) 
		 forControlEvents:UIControlEventTouchUpInside];
	
	[toBookMenu.layer addAnimation:transition forKey:nil];
	
	[self addSubview:toBookMenu];
}

- (void)oneTap 
{	
	// create uiview for buttons.
	
	if ([self viewWithTag:kButtonsView]) 
	{
		[[self viewWithTag:kButtonsView] removeFromSuperview];
	}
	
	else 
	{
		//-- create buttons.
		[self createButton];		
	}
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{
	NSLog(@"touch began");
	// Detect touch anywhere
	UITouch *touch = [touches anyObject];
	
	switch ([touch tapCount]) 
	{
		case 1:
			[self performSelector:@selector(oneTap) withObject:nil afterDelay:.5];
			break;
			
//		case 2:
//			[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(oneTap) object:nil];
//			[self performSelector:@selector(twoTaps) withObject:nil afterDelay:.5];
//			break;
//			
//		case 3:
//			[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(twoTaps) object:nil];
//			[self performSelector:@selector(threeTaps) withObject:nil afterDelay:.5];
//			break;
			
		default:
			break;
	}
}


@end

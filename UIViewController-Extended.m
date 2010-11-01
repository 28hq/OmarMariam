//
//  UIViewController-Extended.m
//  Payday
//
//  Created by Robert on 17/12/2009.
//  Copyright 2009 Electric TopHat Ltd. All rights reserved.
//

#import "UIViewController-Extended.h"
#import <QuartzCore/QuartzCore.h>


@implementation UIViewController (UIViewController_Expanded)

- (void)dismissModalViewControllerWithAnimatedTransition:(UIViewControllerAnimationTransition)transition
{
	[self dismissModalViewControllerWithAnimatedTransition:transition WithDuration:0.75f];
}

- (void)presentModalViewController:(UIViewController*)viewController withAnimatedTransition:(UIViewControllerAnimationTransition)transition
{
	[self presentModalViewController:viewController withAnimatedTransition:transition WithDuration:0.75f];
}

- (void)dismissModalViewControllerWithAnimatedTransition:(UIViewControllerAnimationTransition)transition WithDuration:(float)duration
{	
	if ( transition >= UIViewControllerAnimationTransitionFlipFromLeft )
	{
		UIViewAnimationTransition trans = UIViewAnimationTransitionNone;
		switch (transition) 
		{
			case UIViewControllerAnimationTransitionFlipFromLeft:
				trans = UIViewAnimationTransitionFlipFromLeft;
				break;
			case UIViewControllerAnimationTransitionFlipFromRight:
				trans = UIViewAnimationTransitionFlipFromRight;
				break;
			case UIViewControllerAnimationTransitionCurlUp:
				trans = UIViewAnimationTransitionCurlUp;
				break;
			case UIViewControllerAnimationTransitionCurlDown:
				trans = UIViewAnimationTransitionCurlDown;
				break;
			default:
				break;
		}
		
		UIWindow * window = [[self view] window]; 
		
		[[self view] setClipsToBounds:NO];
		
		UIView * sview = [[self view] superview];
		
		[UIView beginAnimations: @"AnimatedTransition_DismissModal" context: nil];
		[UIView setAnimationTransition:trans forView:window cache:YES];
		[UIView setAnimationDuration:duration];
		[[self view] removeFromSuperview];
		[UIView commitAnimations];
		
		[sview addSubview:[self view]];
		[self dismissModalViewControllerAnimated:NO];
	}
	else if ( transition >= UIViewControllerAnimationTransitionFade )
	{
		NSString * trans = nil;
		NSString * dir   = nil;
		switch (transition) 
		{
			case UIViewControllerAnimationTransitionFade:
				trans = kCATransitionFade;
				break;
			case UIViewControllerAnimationTransitionPushFromTop:
				trans = kCATransitionPush;
				dir   = kCATransitionFromTop;
				break;
			case UIViewControllerAnimationTransitionPushFromRight:
				trans = kCATransitionPush;
				dir   = kCATransitionFromRight;
				break;
			case UIViewControllerAnimationTransitionPushFromBottom:
				trans = kCATransitionPush;
				dir   = kCATransitionFromBottom;
				break;
			case UIViewControllerAnimationTransitionPushFromLeft:
				trans = kCATransitionPush;
				dir   = kCATransitionFromLeft;
				break;
			case UIViewControllerAnimationTransitionMoveInFromTop:
				trans = kCATransitionMoveIn;
				dir   = kCATransitionFromTop;
				break;
			case UIViewControllerAnimationTransitionMoveInFromRight:
				trans = kCATransitionMoveIn;
				dir   = kCATransitionFromRight;
				break;
			case UIViewControllerAnimationTransitionMoveInFromBottom:
				trans = kCATransitionMoveIn;
				dir   = kCATransitionFromBottom;
				break;
			case UIViewControllerAnimationTransitionMoveInFromLeft:
				trans = kCATransitionMoveIn;
				dir   = kCATransitionFromLeft;
				break;
			case UIViewControllerAnimationTransitionRevealFromTop:
				trans = kCATransitionReveal;
				dir   = kCATransitionFromTop;
				break;
			case UIViewControllerAnimationTransitionRevealFromRight:
				trans = kCATransitionMoveIn;
				dir   = kCATransitionFromRight;
				break;
			case UIViewControllerAnimationTransitionRevealFromBottom:
				trans = kCATransitionReveal;
				dir   = kCATransitionFromBottom;
				break;
			case UIViewControllerAnimationTransitionRevealFromLeft:
				trans = kCATransitionReveal;
				dir   = kCATransitionFromLeft;
				break;
			default:
				break;
		}
		
		UIWindow * window = [[self view] window];
		
		[[self.parentViewController view] setClipsToBounds:NO];
		
		// Set up the animation
		CATransition *animation = [CATransition animation];
		[animation setType:trans];
		[animation setSubtype:dir];
		
		// Set the duration and timing function of the transtion -- duration is passed in as a parameter, use ease in/ease out as the timing function
		[animation setDuration:duration];
		[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
		
		[[window layer] addAnimation:animation forKey:@"AnimateTransition"];
		
		[self dismissModalViewControllerAnimated:NO];
	}
	else
	{
		[self dismissModalViewControllerAnimated:NO];
	}
	
}

- (void)presentModalViewController:(UIViewController*)viewController withAnimatedTransition:(UIViewControllerAnimationTransition)transition WithDuration:(float)duration
{
	if ( transition >= UIViewControllerAnimationTransitionFlipFromLeft )
	{
		UIViewAnimationTransition trans = UIViewAnimationTransitionNone;
		switch (transition) {
			case UIViewControllerAnimationTransitionFlipFromLeft:
				trans = UIViewAnimationTransitionFlipFromLeft;
				break;
			case UIViewControllerAnimationTransitionFlipFromRight:
				trans = UIViewAnimationTransitionFlipFromRight;
				break;
			case UIViewControllerAnimationTransitionCurlUp:
				trans = UIViewAnimationTransitionCurlUp;
				break;
			case UIViewControllerAnimationTransitionCurlDown:
				trans = UIViewAnimationTransitionCurlDown;
				break;
			default:
				break;
		}
		
		UIWindow * window = [[self view] window]; 
		UIView * sview = [[self view] superview];
		
		[[viewController view] setClipsToBounds:NO];
		
		[UIView beginAnimations: @"AnimatedTransition_PresentModal" context: viewController];
		[UIView setAnimationTransition:trans forView:window cache:YES];
		[UIView setAnimationDuration:duration];
		
		//[[viewController view] removeFromSuperview];
		[sview addSubview:[viewController view]];
		
		[UIView commitAnimations];
		
		[self presentModalViewController:viewController animated:NO];
	}
	else if ( transition >= UIViewControllerAnimationTransitionFade )
	{
		NSString * trans = nil;
		NSString * dir   = nil;
		switch (transition) 
		{
			case UIViewControllerAnimationTransitionFade:
				trans = kCATransitionFade;
				break;
			case UIViewControllerAnimationTransitionPushFromTop:
				trans = kCATransitionPush;
				dir   = kCATransitionFromTop;
				break;
			case UIViewControllerAnimationTransitionPushFromRight:
				trans = kCATransitionPush;
				dir   = kCATransitionFromRight;
				break;
			case UIViewControllerAnimationTransitionPushFromBottom:
				trans = kCATransitionPush;
				dir   = kCATransitionFromBottom;
				break;
			case UIViewControllerAnimationTransitionPushFromLeft:
				trans = kCATransitionPush;
				dir   = kCATransitionFromLeft;
				break;
			case UIViewControllerAnimationTransitionMoveInFromTop:
				trans = kCATransitionMoveIn;
				dir   = kCATransitionFromTop;
				break;
			case UIViewControllerAnimationTransitionMoveInFromRight:
				trans = kCATransitionMoveIn;
				dir   = kCATransitionFromRight;
				break;
			case UIViewControllerAnimationTransitionMoveInFromBottom:
				trans = kCATransitionMoveIn;
				dir   = kCATransitionFromBottom;
				break;
			case UIViewControllerAnimationTransitionMoveInFromLeft:
				trans = kCATransitionMoveIn;
				dir   = kCATransitionFromLeft;
				break;
			case UIViewControllerAnimationTransitionRevealFromTop:
				trans = kCATransitionReveal;
				dir   = kCATransitionFromTop;
				break;
			case UIViewControllerAnimationTransitionRevealFromRight:
				trans = kCATransitionMoveIn;
				dir   = kCATransitionFromRight;
				break;
			case UIViewControllerAnimationTransitionRevealFromBottom:
				trans = kCATransitionReveal;
				dir   = kCATransitionFromBottom;
				break;
			case UIViewControllerAnimationTransitionRevealFromLeft:
				trans = kCATransitionReveal;
				dir   = kCATransitionFromLeft;
				break;
			default:
				break;
		}
		
		UIWindow * window = [[self view] window];
		
		[[viewController view] setClipsToBounds:NO];
		
		// Set up the animation
		CATransition *animation = [CATransition animation];
		[animation setType:trans];
		[animation setSubtype:dir];
		
		// Set the duration and timing function of the transtion -- duration is passed in as a parameter, use ease in/ease out as the timing function
		[animation setDuration:duration];
		[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
		
		[[window layer] addAnimation:animation forKey:@"AnimateTransition"];
		
		[self presentModalViewController:viewController animated:NO];
	}
	else 
	{
		[self presentModalViewController:viewController animated:NO];
	}
}

@end
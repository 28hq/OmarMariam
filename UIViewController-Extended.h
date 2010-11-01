//
//  UIViewController-Extended.h
//  Payday
//
//  Created by Robert on 17/12/2009.
//  Copyright 2009 Electric TopHat Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum 
{
	UIViewControllerAnimationTransitionNone = 0,
	UIViewControllerAnimationTransitionFade,
	UIViewControllerAnimationTransitionPushFromTop,
	UIViewControllerAnimationTransitionPushFromRight,
	UIViewControllerAnimationTransitionPushFromBottom,
	UIViewControllerAnimationTransitionPushFromLeft,
	UIViewControllerAnimationTransitionMoveInFromTop,
	UIViewControllerAnimationTransitionMoveInFromRight,
	UIViewControllerAnimationTransitionMoveInFromBottom,
	UIViewControllerAnimationTransitionMoveInFromLeft,
	UIViewControllerAnimationTransitionRevealFromTop,
	UIViewControllerAnimationTransitionRevealFromRight,
	UIViewControllerAnimationTransitionRevealFromBottom,
	UIViewControllerAnimationTransitionRevealFromLeft,
	
	UIViewControllerAnimationTransitionFlipFromLeft,
	UIViewControllerAnimationTransitionFlipFromRight,
	UIViewControllerAnimationTransitionCurlUp,
	UIViewControllerAnimationTransitionCurlDown,
} UIViewControllerAnimationTransition;

@interface UIViewController (UIViewController_Expanded) 

- (void)dismissModalViewControllerWithAnimatedTransition:(UIViewControllerAnimationTransition)transition;
- (void)presentModalViewController:(UIViewController*)viewController withAnimatedTransition:(UIViewControllerAnimationTransition)transition;

- (void)dismissModalViewControllerWithAnimatedTransition:(UIViewControllerAnimationTransition)transition WithDuration:(float)duration;
- (void)presentModalViewController:(UIViewController*)viewController withAnimatedTransition:(UIViewControllerAnimationTransition)transition WithDuration:(float)duration;

@end
//
//  LineView.h
//  OmarMariam
//
//  Created by A.L.L.Y.K. on 11/4/10.
//  Copyright 2010 Brainstorm Technologies Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LineGameViewController.h"


@interface LineView : UIView {
	CGPoint currentTouchPoint, startTouchPoint;
	NSInteger objectTagged;
	NSString *objectTouched;
	
	NSMutableArray *lines;
	
	BOOL correct, start;
	
	LineGameViewController *viewController;
}

@property (assign) CGPoint currentTouchPoint, startTouchPoint;
@property (assign) NSInteger objectTagged;
@property (assign) BOOL correct, start;
@property (nonatomic, retain) NSString *objectTouched;
@property (nonatomic, retain) NSMutableArray *lines;

@property (nonatomic, retain) IBOutlet LineGameViewController *viewController;

- (void)drawLine:(CGRect)rect;
- (void)cleanUp;

@end

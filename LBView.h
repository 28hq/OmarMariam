//
//  LBView.h
//  OmarMariam
//
//  Created by A.L.L.Y.K. on 11/14/10.
//  Copyright 2010 Brainstorm Technologies Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LBView : UIView {
	UIViewController			*viewController;
}

@property (retain) IBOutlet UIViewController			*viewController;

- (void)createButton;
- (void)removeButton;

@end

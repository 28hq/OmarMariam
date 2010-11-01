//
//  LBiPadRootViewController.h
//  OmarMariam
//
//  Created by saifuddin on 9/6/10.
//  Copyright 2010 Brainstorm Technologies Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface LBiPadRootViewController : UIViewController
{
	IBOutlet UIButton *btnBook1;
	IBOutlet UIButton *btnBook2;
	IBOutlet UIButton *btnBook3;
	IBOutlet UIButton *btnBook4;
	IBOutlet UIButton *btnBook5;
	IBOutlet UIButton *btnBook6;
	IBOutlet UIButton *btnBook7;
	UINavigationController *nvcBook1;
}

- (void)prepareView;
- (IBAction)openBook1:(id)sender;
- (IBAction)openBook2:(id)sender;
- (IBAction)openBook3:(id)sender;
- (IBAction)openBook4:(id)sender;
- (IBAction)openBook5:(id)sender;
- (IBAction)openBook6:(id)sender;
- (IBAction)openBook7:(id)sender;

@end

//
//  AppDelegate_iPad.h
//  OmarMariam
//
//  Created by saifuddin on 9/1/10.
//  Copyright Brainstorm Technologies Sdn Bhd 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate_Shared.h"
#import "LBiPadRootViewController.h"

@interface AppDelegate_iPad : AppDelegate_Shared 
{
	NSArray *volume1;
	
	LBiPadRootViewController *rootViewController;
}

@property (nonatomic, retain) NSArray *volume1;

@end

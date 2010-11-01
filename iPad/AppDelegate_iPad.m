//
//  AppDelegate_iPad.m
//  OmarMariam
//
//  Created by saifuddin on 9/1/10.
//  Copyright Brainstorm Technologies Sdn Bhd 2010. All rights reserved.

#import "AppDelegate_iPad.h"

@implementation AppDelegate_iPad

@synthesize volume1;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
{    
	
	NSArray *tmpVolume = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Volume1"
																								 ofType:@"plist"]];		
	self.volume1 = tmpVolume;
	[tmpVolume release];
	
	rootViewController = [[LBiPadRootViewController alloc] init];		
	[window addSubview:rootViewController.view];
	[window makeKeyAndVisible];
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive.
     */
}


/**
 Superclass implementation saves changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application {
	[super applicationWillTerminate:application];
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
    [super applicationDidReceiveMemoryWarning:application];
}


- (void)dealloc 
{
	[rootViewController release];
	[super dealloc];
}


@end


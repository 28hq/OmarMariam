//
//  LBiPadRootViewController.m
//  OmarMariam
//
//  Created by saifuddin on 9/6/10.
//  Copyright 2010 Brainstorm Technologies Sdn Bhd. All rights reserved.
//

#import "LBiPadRootViewController.h"
//#import "LBiBook7Page28n29ViewController.h"
#import "BookViewController.h"
#import "LabelViewController.h"
#import "ClozeGameViewController.h"
#import "QuizViewController.h"

@implementation LBiPadRootViewController

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad 
{
    [super viewDidLoad];
	[self prepareView];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


/*
 - (void)viewWillAppear:(BOOL)animated {
 [super viewWillAppear:animated];
 }
 */
/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */
/*
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 }
 */
/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Override to allow orientations other than the default portrait orientation.
    return YES;
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)prepareView
{
	// Customize shelves and book covers here.
	//btnBook2.hidden = YES;
	//btnBook3.hidden = YES;
	btnBook4.hidden = YES;
	//btnBook5.hidden = YES;
	//btnBook6.hidden = YES;
	//btnBook7.hidden = YES;
}

- (void)dealloc 
{
	[btnBook1 release];
	[btnBook2 release];
	[btnBook3 release];
	[btnBook4 release];
	[btnBook5 release];
	[btnBook6 release];
	[btnBook7 release];
	[nvcBook1 release];
    [super dealloc];
}

#pragma mark -
#pragma mark Opening Books

- (IBAction)openBook1:(id)sender
{
//	LBiBook7Page28n29ViewController *rvc = [[[LBiBook7Page28n29ViewController alloc] init] autorelease];
//	nvcBook1 = [[UINavigationController alloc] initWithRootViewController:rvc];
//	nvcBook1.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//	[self presentModalViewController:nvcBook1 animated:YES];
}

- (IBAction)openBook2:(id)sender
{
	UIViewController *viewController;
	
	viewController = [[[BookViewController alloc] initWithBookNumber:2] autorelease];
	[self presentModalViewController:viewController animated:YES];
}

- (IBAction)openBook3:(id)sender
{
	UIViewController *viewController;
	
	viewController = [[[BookViewController alloc] initWithBookNumber:3] autorelease];
	[self presentModalViewController:viewController animated:YES];
}

- (IBAction)openBook4:(id)sender
{
	UIViewController *viewController;
	
	viewController = [[[BookViewController alloc] initWithBookNumber:4] autorelease];
	[self presentModalViewController:viewController animated:YES];
}

- (IBAction)openBook5:(id)sender
{
//	UIViewController *viewController;
//	
//	viewController = [[[BookViewController alloc] initWithBookNumber:5] autorelease];
//	[self presentModalViewController:viewController animated:YES];
	
	QuizViewController *viewController;
	viewController = [[QuizViewController alloc] initWithNibName:@"QuizViewController" bundle:nil];
	[self presentModalViewController:viewController animated:YES];
}

- (IBAction)openBook6:(id)sender
{
//	UIViewController *viewController;
//	
//	viewController = [[[BookViewController alloc] initWithBookNumber:6] autorelease];
//	[self presentModalViewController:viewController animated:YES];
	
	ClozeGameViewController *viewController;
	viewController = [[ClozeGameViewController alloc] initWithNibName:@"ClozeGameViewController" bundle:nil];
	[self presentModalViewController:viewController animated:YES];
}

- (IBAction)openBook7:(id)sender
{
//	UIViewController *viewController;
//	
//	viewController = [[[BookViewController alloc] initWithBookNumber:7] autorelease];
//	[self presentModalViewController:viewController animated:YES];
	
	LabelViewController *viewController; 
	viewController = [[LabelViewController alloc] initWithNibName:@"LabelViewController" bundle:nil];
	[self presentModalViewController:viewController animated:YES];
}

@end


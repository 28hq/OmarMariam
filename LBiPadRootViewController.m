//
//  LBiPadRootViewController.m
//  OmarMariam
//
//  Created by saifuddin on 9/6/10.
//  Copyright 2010 Brainstorm Technologies Sdn Bhd. All rights reserved.
//

#import "LBiPadRootViewController.h"
#import "GamesViewController.h"
#import "BookViewController.h"
#import "LineGameViewController.h"
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
	//btnBook4.hidden = YES;
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
	GamesViewController *gameController;
	
	gameController = [[GamesViewController alloc] initWithNibName:@"GamesViewController" bundle:nil];
	gameController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
	gameController.bookNumber = 1;
	
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:gameController];
	[self presentModalViewController:navController animated:YES];
}

- (IBAction)openBook2:(id)sender
{
	GamesViewController *gameController;
	
	gameController = [[GamesViewController alloc] initWithNibName:@"GamesViewController" bundle:nil];
	gameController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
	gameController.bookNumber = 2;

	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:gameController];
	[self presentModalViewController:navController animated:YES];
}

- (IBAction)openBook3:(id)sender
{
	GamesViewController *gameController;
	
	gameController = [[GamesViewController alloc] initWithNibName:@"GamesViewController" bundle:nil];
	gameController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
	gameController.bookNumber = 3;

	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:gameController];
	[self presentModalViewController:navController animated:YES];
}

- (IBAction)openBook4:(id)sender
{
	GamesViewController *gameController;
	
	gameController = [[GamesViewController alloc] initWithNibName:@"GamesViewController" bundle:nil];
	gameController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
	gameController.bookNumber = 4;

	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:gameController];
	[self presentModalViewController:navController animated:YES];
}

- (IBAction)openBook5:(id)sender
{
	GamesViewController *gameController;
	
	gameController = [[GamesViewController alloc] initWithNibName:@"GamesViewController" bundle:nil];
	gameController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
	gameController.bookNumber = 5;
	
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:gameController];
	[self presentModalViewController:navController animated:YES];
}

- (IBAction)openBook6:(id)sender
{
	GamesViewController *gameController;
	
	gameController = [[GamesViewController alloc] initWithNibName:@"GamesViewController" bundle:nil];
	gameController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
	gameController.bookNumber = 6;

	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:gameController];
	[self presentModalViewController:navController animated:YES];
}

- (IBAction)openBook7:(id)sender
{
	GamesViewController *gameController;
	
	gameController = [[GamesViewController alloc] initWithNibName:@"GamesViewController" bundle:nil];
	gameController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
	gameController.bookNumber = 7;

	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:gameController];
	[self presentModalViewController:navController animated:YES];
}

@end


    //
//  GamesViewController.m
//  OmarMariam
//
//  Created by A.L.L.Y.K. on 11/10/10.
//  Copyright 2010 Brainstorm Technologies Sdn Bhd. All rights reserved.
//

#import "GamesViewController.h"

#import "BookViewController.h"
#import "LineGameViewController.h"
#import "LabelViewController.h"
#import "ClozeGameViewController.h"
#import "QuizViewController.h"

@implementation GamesViewController

@synthesize bookNumber;

@synthesize bookCoverImage;
@synthesize bookButton;
//@synthesize lineGameButton;
//@synthesize labelGameButton;
//@synthesize clozeGameButton;
//@synthesize quizGameButton;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	NSString *imagePath = [[NSString alloc] init];
	imagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"BP%d01", self.bookNumber] 
												ofType:@"jpg"];
	UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
	self.bookCoverImage.image = image;
	[self.bookButton setBackgroundImage:image forState:UIControlStateNormal];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

- (IBAction)bookGame:(id)sender 
{
	UIViewController *viewController;
	viewController = [[[BookViewController alloc] initWithBookNumber:self.bookNumber] autorelease];
	
	[self presentModalViewController:viewController animated:YES];
}

- (IBAction)labelGameButton:(id)sender 
{
	LabelViewController *viewController; 
	viewController = [[LabelViewController alloc] initWithNibName:@"LabelViewController" bundle:nil];
	[self presentModalViewController:viewController animated:YES];
}

- (IBAction)lineGameButton:(id)sender
{
	UIViewController *viewController;
	viewController = [[LineGameViewController alloc] initWithBookNumber:self.bookNumber];
	[self presentModalViewController:viewController animated:YES];
}

- (IBAction)clozeGameButton:(id)sender 
{
	ClozeGameViewController *viewController;
	viewController = [[ClozeGameViewController alloc] initWithNibName:@"ClozeGameViewController" bundle:nil];
	[self presentModalViewController:viewController animated:YES];
}

- (IBAction)quizGameButton:(id)sender 
{
	QuizViewController *viewController;
	viewController = [[QuizViewController alloc] initWithNibName:@"QuizViewController" bundle:nil];
	[self presentModalViewController:viewController animated:YES];
}

- (IBAction)exitToMenu:(id)sender
{
	[self dismissModalViewControllerAnimated:YES];
}

@end

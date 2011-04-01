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

#import "Constants.h"

@implementation GamesViewController

@synthesize bookNumber;
@synthesize bookVolume;
@synthesize bookContents;

@synthesize bookCoverImage;
@synthesize bookButton;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self.navigationController setNavigationBarHidden:YES];
	
	NSString *imagePath = [[NSString alloc] init];
	imagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"v%db%dcp", bookVolume, bookNumber] 
												ofType:@"jpg"];
	UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
	self.bookCoverImage.image = image;
	[self.bookButton setBackgroundImage:image forState:UIControlStateNormal];
	
	self.bookContents = [[NSArray alloc] initWithObjects:
						 [NSDictionary dictionaryWithObjectsAndKeys:@"Book", @"title", @"BookViewController", @"class", nil],
						 [NSDictionary dictionaryWithObjectsAndKeys:@"Line Game", @"title", @"LineGameViewController", @"class", nil],
						 [NSDictionary dictionaryWithObjectsAndKeys:@"Label Game", @"title", @"LabelViewController", @"class", nil],
						 [NSDictionary dictionaryWithObjectsAndKeys:@"Cloze Passage Game", @"title", @"ClozeGameViewController", @"class", nil],
						 [NSDictionary dictionaryWithObjectsAndKeys:@"Quiz Game", @"title", @"QuizViewController", @"class", nil],
						 nil];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Override to allow orientations other than the default portrait orientation.
	NSLog(@"ShouldAutorotate: %@", [self class]);
	return ((interfaceOrientation == UIInterfaceOrientationLandscapeLeft) || 
			(interfaceOrientation == UIInterfaceOrientationLandscapeRight));
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
	
	CATransition *transition = [CATransition animation];
	transition.duration = .3;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	
	//NSString *transitionTypes[4] = { kCATransitionPush, kCATransitionMoveIn, kCATransitionReveal, kCATransitionFade };
	transition.type = kCATransitionMoveIn;
	
	//NSString *transitionSubtypes[4] = { kCATransitionFromRight, kCATransitionFromLeft, kCATransitionFromTop, kCATransitionFromBottom };
	transition.subtype = kCATransitionFromBottom;
	
	// create buttons.
	UIButton *backToLibraryButton = [UIButton buttonWithType:UIButtonTypeCustom];
	backToLibraryButton.tag = kButtonsView;
	backToLibraryButton.frame = CGRectMake(5.0, 5.0, 150.0, 30.0);
	backToLibraryButton.backgroundColor = [UIColor brownColor];
	backToLibraryButton.alpha = 0.8;

	backToLibraryButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
	[backToLibraryButton setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
	[backToLibraryButton setTitle:@"Library" forState:UIControlStateNormal];
	
	backToLibraryButton.layer.borderColor = [[UIColor blackColor] CGColor];
	backToLibraryButton.layer.borderWidth = 1;
	backToLibraryButton.layer.cornerRadius = 5;
	

	[backToLibraryButton addTarget:self
							action:@selector(exitToMenu:) 
				  forControlEvents:UIControlEventTouchUpInside];
	
	
	[backToLibraryButton.layer addAnimation:transition forKey:nil];
	[self.view addSubview:backToLibraryButton];
	
}


- (void)dealloc {
    [super dealloc];
	
	[self.bookContents release];
}

#pragma mark TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.bookContents count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSString *theTitle = @"cell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:theTitle];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:theTitle] autorelease];
	}
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	cell.textLabel.text = [[self.bookContents objectAtIndex:indexPath.row] valueForKey:@"title"];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	Class myClass = NSClassFromString([[self.bookContents objectAtIndex:indexPath.row] valueForKey:@"class"]);
	
	id klass = [[myClass alloc] initWithBook:bookNumber ofVolume:bookVolume];
	[self.navigationController pushViewController:klass animated:YES];
	[klass release];
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)exitToMenu:(id)sender
{
	[self dismissModalViewControllerAnimated:YES];
}

@end

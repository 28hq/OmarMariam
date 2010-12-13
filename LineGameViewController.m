    //
//  LineGameViewController.m
//  OmarMariam
//
//  Created by A.L.L.Y.K. on 10/5/10.
//  Copyright 2010 Brainstorm Technologies Sdn Bhd. All rights reserved.
//

#import "LineGameViewController.h"
#import "AppDelegate_iPad.h"
#import "LineView.h"

#import "Constants.h"

@implementation LineGameViewController

@synthesize theData;
@synthesize questionLeft, totalLevel, isAtLevel;
@synthesize bookNumber;

@synthesize cover, game, end;
@synthesize wordViews, pictureViews; // for array storing the views
@synthesize wordView, pictureView;	 // for assigning instance of the view.
@synthesize gameNumberImage;
@synthesize gameNumber, gameNumber2, levelImageView, levelImageView2;
@synthesize continueButton, levelIndicator;


- (id)initWithBook:(int)bookNumber ofVolume:(int)bookVolume
{
	if (self = [super init]) 
	{
		self.bookNumber = bookVolume;
		
		NSArray *_tmpData = [[NSArray alloc] init];
		self.theData = _tmpData;
		[_tmpData release];
		
		NSMutableArray *_wordViews = [[NSMutableArray alloc] init];
		self.wordViews = _wordViews;
		[_wordViews release];
		
		NSMutableArray *_pictureViews = [[NSMutableArray alloc] init];
		self.pictureViews = _pictureViews;
		[_pictureViews release];
	}
	
	return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.cover.backgroundColor = [UIColor clearColor];
	[self.view addSubview:self.cover];
	
	/*
	 * Set cover image based on the game number.
	 */
	
	int gameNo = 1;
	NSString *imagePath = [[NSString alloc] init];
	imagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"cover%d", self.bookNumber] 
												ofType:@"png"];
	
	UIImage *image = [[UIImage alloc] initWithContentsOfFile:imagePath];
	self.levelImageView.image = image;
	[image release];
	
	imagePath = nil;
	imagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%d", gameNo] 
												ofType:@"png"];
	
	image = [[UIImage alloc] initWithContentsOfFile:imagePath];
	self.gameNumber.image = image;
	self.gameNumber2.image = image;
	self.gameNumberImage = image;
	[image release];
	
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

- (void)toBookMenu 
{
	[[self navigationController] popToRootViewControllerAnimated:YES];
}

- (void)startGame:(id)sender 
{
	
	self.game.backgroundColor = [UIColor clearColor];
	self.wordView.backgroundColor = [UIColor clearColor];
	self.pictureView.backgroundColor = [UIColor clearColor];
	self.levelIndicator.backgroundColor = [UIColor clearColor];
	
	[self.view addSubview:self.game];
	[self.cover removeFromSuperview];
	[self levelSelector:1];
}

- (void)playAgain:(id)sender 
{	
	self.isAtLevel = 1;
	
	[self levelSelector:self.isAtLevel];
	
	[[self.view viewWithTag:503] removeFromSuperview];
}

- (void)levelSelector:(int)level
{
	
	/*
	 * Initialize game.
	 */
	AppDelegate_iPad *delegate = [[UIApplication sharedApplication] delegate];
	
	self.isAtLevel = level;
	self.totalLevel = [[[delegate.volume1 objectAtIndex:self.bookNumber-1] // iBook1, 2, 3 etc.
						objectForKey:@"LineGame"] count];
	
	self.theData = [[[[delegate.volume1 objectAtIndex:self.bookNumber-1] // iBook1, 2, 3 etc.
					  objectForKey:@"LineGame"] // LabelGame, ClozeGame
					 objectAtIndex:level-1] retain]; // Game No.
													 // Level1, 2, 3 etc.

	self.questionLeft = 0;
	
	// Create level indicator
	[self createLevelIndicator];
	
	// Positioning Text & Image on views.
	
	NSMutableArray *pictureImageViews = [[NSMutableArray alloc] init];
	NSMutableArray *wordLabels = [[NSMutableArray alloc] init];
	
	NSUInteger i, count = [self.theData count];
	
	if (0 == count) { return; }
	
	for (i = 0; i < count; i++) 
	{
		NSObject * obj = [[self.theData objectAtIndex:i] retain];
		
		if ([obj isKindOfClass:[NSDictionary class]]) 
		{
			/* Position UILabel & UIImage */
			
			// positioning UILabel:
			CGRect rect = CGRectZero;
			rect.size.width = 200;
			rect.size.height = 100;
			
			UILabel *wordLabel = [[UILabel alloc] initWithFrame:rect];			
			wordLabel.tag = i;
			wordLabel.font = [UIFont systemFontOfSize:40];
			wordLabel.text = [obj valueForKey:@"word"];
			wordLabel.textAlignment = UITextAlignmentCenter;
			wordLabel.backgroundColor = [UIColor clearColor];
			
			
			// centering the word label.
			CGPoint center = wordLabel.center;
			center.x = self.wordView.frame.size.width/2;
			//center.y = center.y + i * (kVerticalGap + wordLabel.frame.size.height);
			wordLabel.center = center;
			
			// adding to view.
			[wordLabels addObject:wordLabel];
						
			[wordLabel release];
			
			// positioning UIImage
			NSString *imagePath = [[NSString alloc] init];
			imagePath = [[NSBundle mainBundle] pathForResource:[obj valueForKey:@"picture"] 
														ofType:@"png"];
			
			rect = CGRectZero;
			rect.size.width = 250;
			rect.size.height = 100;
			rect.origin.x = kLeftGap;
			//rect.origin.y = i * (kVerticalGap + rect.size.height);
			
			UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
			
			imageView.image = [UIImage imageWithContentsOfFile:imagePath];
			imageView.tag = i;
			imageView.contentMode = UIViewContentModeScaleAspectFit;
//			[imageView.layer setBorderColor: [[UIColor blackColor] CGColor]];
//			[imageView.layer setBorderWidth: 2.0];
//			imageView.layer.cornerRadius = 8;
			
			// centering the image view.
			center = imageView.center;
			center.x = self.pictureView.frame.size.width/2;
			imageView.center = center;
			
			// add to view
			//[self.pictureView addSubview:imageView];
			[pictureImageViews addObject:imageView];
			
			[imageView release];
			
			
			// Increase question counter.
			self.questionLeft += 1; 
		}
	}
	
	// randomize position of words and pictures.
	
	/*
	 * create mutable array, iterate through keys generated randomly.
	 */
	
	NSMutableArray *tempArray = [[NSMutableArray alloc] initWithArray:wordLabels];
	
	// randomize word labels.
	int n = count;
	while(n--)
	{
		int key = arc4random() % (n+1);
		
		UILabel *wordLabel = [[UILabel alloc] init];
		wordLabel = [[tempArray objectAtIndex:key] retain];
					 
		// centering the word label.
		CGPoint center = wordLabel.center;
		center.x = self.wordView.frame.size.width/2;
		center.y = center.y + (count-(n+1)) * (kVerticalGap + wordLabel.frame.size.height);
		wordLabel.center = center;
		
		[self.wordView addSubview:wordLabel];
		[self.wordViews addObject:wordLabel];
		
		[tempArray removeObjectAtIndex:key];
		
		[wordLabel release];
	}

	[tempArray release];

	tempArray = [[NSMutableArray alloc] initWithArray:pictureImageViews];	

	// randomize pictures.
	n = count;
	while(n--)
	{
		int key = arc4random() % (n+1);
		
		UIImageView *picView = [[UILabel alloc] init];
		picView = [[tempArray objectAtIndex:key] retain];
		
		// centering the word label.
		CGPoint center = picView.center;
		center.x = self.wordView.frame.size.width/2;
		center.y = center.y + (count-(n+1)) * (kVerticalGap + picView.frame.size.height);
		picView.center = center;
		
		[self.pictureView addSubview:picView];
		[self.pictureViews addObject:picView];
		[tempArray removeObjectAtIndex:key];

		[picView release];
	}
	
	[tempArray release];
	
	[wordLabels release];
	[pictureImageViews release];
	
	[self.theData release];
	self.theData = nil;
 
}

- (void)createLevelIndicator {
	
	// Creating level state indicator

	for (int i = 0; i < self.totalLevel; i++) 	
	{
		UIView * indicatorBox = [[UIView alloc] init];
		indicatorBox.tag = kLevelIndicatorViewID;
		
		CGRect indicatorFrame = CGRectMake(self.levelIndicator.frame.origin.x 
										   + self.levelIndicator.frame.size.width
										   - i * 10
										   - (i+1) * kIndicatorWidth, 
										   self.levelIndicator.frame.origin.y 
										   + (self.levelIndicator.frame.size.height 
											  - kIndicatorHeight)/2, 
										   kIndicatorWidth, kIndicatorHeight);
		indicatorBox.frame = indicatorFrame;
		if ((self.totalLevel - i) <= self.isAtLevel) {
			indicatorBox.backgroundColor = [UIColor yellowColor];
		}
		else {
			indicatorBox.backgroundColor = [UIColor lightGrayColor];
		}
		
		
		[self.view addSubview:indicatorBox];
		
		[indicatorBox release];
		
	}
	
	UILabel * labelLevel = [[UILabel alloc] init];
	CGRect aFrame = CGRectMake(self.levelIndicator.frame.origin.x 
							   + self.levelIndicator.frame.size.width
							   - (self.totalLevel) * (kIndicatorWidth+10)
							   - 100, 
							   self.levelIndicator.frame.origin.y 
							   + (self.levelIndicator.frame.size.height 
								  - kIndicatorHeight)/2, 100, 30);
	
	labelLevel.frame = aFrame;
	labelLevel.backgroundColor = [UIColor clearColor];
	labelLevel.text = @"LEVEL";
	labelLevel.tag = kLevelIndicatorViewID;
	labelLevel.textAlignment = UITextAlignmentRight;
	[self.view addSubview:labelLevel];
	[labelLevel release];
}

- (void)checkLevelCompletion 
{
	if (0 == self.questionLeft) 
	{
		if (self.isAtLevel >= self.totalLevel) 
		{
			[(LineView*)self.game cleanUp];
			
			[self cleanUp];
			
			[self.view addSubview:self.end];
			self.end.backgroundColor = [UIColor clearColor];
			
			return;
		}
		self.isAtLevel = self.isAtLevel + 1;
		
		[self.continueButton superview].hidden = NO;
		
		[self.view bringSubviewToFront:[self.continueButton superview]];
		
		[self.continueButton addTarget:self 
								action:@selector(continueToNextLevel) 
					  forControlEvents:UIControlEventTouchUpInside];
	}
}

- (void)continueToNextLevel {
	
	// clean-up LineView controller.
	[(LineView*)self.game cleanUp];
	
	// clean-up here.
	[self cleanUp];
	
	[self levelSelector:self.isAtLevel];
	
	[self.continueButton superview].hidden = YES;
}

- (void)cleanUp {
	
	// reset question counter.
	self.questionLeft = 0;
	
	/*
	 * Clear all objects on screen
	 */
		
	for (UIView *subview in [self.view subviews]) 
	{
		if (subview.tag == kLevelIndicatorViewID ) 
		{
			[subview removeFromSuperview];
		}
	}
	
	if (0 != [self.wordViews count]) 
	{
		//NSLog(@"%d", [self.wordViews count]);
		for (UILabel *_aView in self.wordViews) 
		{
			[_aView removeFromSuperview];
		}
		[self.wordViews removeAllObjects];
	}
		
	if (0 != [self.pictureViews	count]) 
	{
		for (UIView * _aView in self.pictureViews) 
		{
			[_aView removeFromSuperview];
		}
		[self.pictureViews removeAllObjects];
	}
	
}

@end

    //
//  LabelViewController.m
//  OmarMariam
//
//  Created by A.L.L.Y.K. on 10/20/10.
//  Copyright 2010 Brainstorm Technologies Sdn Bhd. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "LabelViewController.h"
#import "LabelView.h"

#import "Constants.h"

@interface LabelViewController()

extern int const LBPaddingTop;
extern int const LBPaddingRight;
extern int const LBPaddingBottom;
extern int const LBPaddingLeft;
extern int const LBGap;
extern int const LBWidth;
extern float const LBMagnification;

@end

@implementation LabelViewController

@synthesize imageViews, labelViews, imagesPath, dropViews;
@synthesize wordListView, labelView;
@synthesize _volume1, _theData;
@synthesize questionLeft, totalLevel, isAtLevel, bookNumber;

// IBOutlet
@synthesize gameNumber, levelIndicator;
@synthesize continueButtonView, continueButton;
@synthesize wordListScrollView;
@synthesize cover, game, end;

int const LBPaddingTop = 50;
int const LBPaddingRight = 100;
int const LBPaddingBottom = 100;
int const LBPaddingLeft = 80;
int const LBGap = 80;
int const LBWidth = 200;
float const LBMagnification = 2.0;


// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithBookNumber:(int)number  {
    if ((self = [super initWithNibName:@"LabelViewController" bundle:nil])) {
        // Custom initialization
		
		// The instantiation of property this way is said to avoid leak.
		NSMutableArray *_imageViews = [[NSMutableArray alloc] init];
		self.imageViews = _imageViews;
		[_imageViews release];
		
		NSMutableArray *_labelViews = [[NSMutableArray alloc] init];
		self.labelViews = _labelViews;
		[_labelViews release];
		
		NSMutableArray *_dropViews = [[NSMutableArray alloc] init];
		self.dropViews = _dropViews;
		[_dropViews release];
		
		NSArray *_tmpData = [[NSArray alloc] init];
		self._theData = _tmpData;
		[_tmpData release];
		
		NSArray *_tmpVolume = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Volume1"
																									  ofType:@"plist"]];		
		self._volume1 = _tmpVolume;
		[_tmpVolume release];

		self.isAtLevel = 1;
		self.bookNumber = number;
    }
    return self;
}


/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */

/*
 
 NOTES
 currently, the plist file is extracted here. later on, the plist will be loaded 
 in application delegate (or equivalent) and reside in the memory until user select
 different volume.
 
 */

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	// set game number.

	UIImage *img = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%d", self.bookNumber]
																						   ofType:@"png"]];
	
	self.gameNumber.image = img;
	
	[self levelSelector:self.isAtLevel];
}

- (void)nextLevel {

	// is at the end of the game. encounter last question.
	if (self.isAtLevel == self.totalLevel) {
		[self.view addSubview:self.end];
		return;
	}
	self.isAtLevel = self.isAtLevel + 1;
	self.continueButtonView.hidden = NO;
	[self.view bringSubviewToFront:self.continueButtonView];
	
	[self.continueButton addTarget:self 
							action:@selector(continueToNextLevel) 
				  forControlEvents:UIControlEventTouchUpInside];
}

- (void)continueToNextLevel {
	self.questionLeft = 0;
	[self levelSelector:self.isAtLevel];
	self.continueButtonView.hidden = YES;
}

- (void)levelSelector:(int)level {
	
	self.totalLevel = [[[self._volume1 objectAtIndex:self.bookNumber-1] // iBook1, 2, 3 etc.
						objectForKey:@"LabelGame"] count];
	
	self._theData = [[[[self._volume1 objectAtIndex:self.bookNumber-1] // iBook1, 2, 3 etc.
						  objectForKey:@"LabelGame"] // LabelGame, ClozeGame
						 objectAtIndex:level-1] retain]; // Level1, 2, 3 etc.

	self.questionLeft = [self._theData count];

	// Clear current objects
	if (0 != [self.labelViews count]) {
		for (UIView * _aView in self.labelViews) {
			//[self.labelViews removeObject:_aView];
			[_aView removeFromSuperview];
			//[_aView release];
			//_aView = nil;
		}
		[self.labelViews removeAllObjects];
	}
	
	if (0 != [self.imageViews count]) {
		for (UIView * _bView in self.imageViews) {
			//[self.imageViews removeObject:_bView];
			[_bView removeFromSuperview];
			//[_bView release];
			//_bView = nil;
		}
		[self.imageViews removeAllObjects];
	}
	
	if (0 != [self.dropViews count]) {
		for (UIView * _dView in self.dropViews) {
			//[self.dropViews removeObject:_dView];
			[_dView removeFromSuperview];
			//[_dView release];
			//_dView = nil;
		}
		[self.dropViews removeAllObjects];
	}
	
	// Create level indicator
	[self createLevelIndicator];
	
	// Positioning Text on views.
	NSUInteger i, count = [self._theData count];
	
	if (0 == count) {
		return;
	}
	
	for (i = 0; i < count; i++) 
	{
		NSObject * obj = [[self._theData objectAtIndex:i] retain];
		
		if ([obj isKindOfClass:[NSDictionary class]]) 
		{
			
			// Set the location of the `word`
			NSString * word = [[NSString alloc] initWithString:[obj valueForKey:@"word"]];
			
			UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
			textLabel.text = word;
			textLabel.backgroundColor = [UIColor clearColor];
			textLabel.tag = i;
			
			textLabel.font = [UIFont boldSystemFontOfSize:40];
			CGSize size = [word sizeWithFont:[UIFont boldSystemFontOfSize:40]];
			
			CGRect rect;
			rect.origin.x = self.wordListView.frame.size.width - size.width - 30;
			rect.origin.y = kLBPaddingTop + i * (size.height + 20);
			rect.size = size;
			
			textLabel.frame = rect;
			
			[self.wordListView addSubview:textLabel];
			[self.labelViews addObject:textLabel];
			
			[textLabel release];
			[word release];

			
			self.wordListScrollView.layer.borderColor = [[UIColor blueColor] CGColor];
			self.wordListScrollView.layer.borderWidth = 3;
			self.wordListScrollView.layer.cornerRadius = 5;
			
			self.wordListScrollView.backgroundColor = [UIColor whiteColor];
			self.wordListScrollView.clipsToBounds = YES;
			self.wordListScrollView.contentSize = CGSizeMake(self.wordListScrollView.frame.size.width, (i+1) * (size.height + 30));
			self.wordListScrollView.scrollEnabled = YES;
			self.wordListScrollView.delegate = self;

			self.wordListView.frame = CGRectMake(0.0, 0.0, self.wordListScrollView.frame.size.width, self.wordListScrollView.contentSize.height);

			if (nil == [obj valueForKey:@"picture"]) {
				self.questionLeft -= 1;
			}
			else 
			{
				NSString *directory = [NSString stringWithFormat:@"Volume1/LabelGames/Game%d/Images", self.bookNumber];
				NSFileManager *fileMgr = [NSFileManager defaultManager];
				NSString *filePath = [[NSBundle mainBundle] pathForResource:[obj valueForKey:@"picture"]
																	 ofType:@"png"
																inDirectory:directory];
				
				// Automatically determine the existence of image.
				// If image does not exist in book directory, find it in root directory.
				
				if (![fileMgr fileExistsAtPath:filePath]) {
					filePath = [[NSBundle mainBundle] pathForResource:[obj valueForKey:@"picture"]
															   ofType:@"png"];
				}
				
				// Set the location of the `picture`
				
				UIImage *image = [[UIImage alloc] initWithContentsOfFile:filePath];
				
				if (nil != image) 
				{
					UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
					
					CGRect imageRect;

					imageRect.size.width = LBWidth;
					imageRect.size.height = (LBWidth / image.size.width) * image.size.height;

					imageView.frame = imageRect;
					imageView.image = image;
					
					
					CGRect frame = imageView.frame;
					
					
					if (i == 2 || i == 3) {
						frame.origin.x = 1024 - 2 * (frame.size.width + LBPaddingRight);
						frame.origin.y = LBPaddingTop + 40 + (i-2) * (imageRect.size.height + LBGap);
					}
					else if (i == 4) {
						frame.origin.x = 1024 - 3 * (frame.size.width + LBPaddingRight);
						frame.origin.y = LBPaddingTop + 40 + (1) * (imageRect.size.height + LBGap);
					}
					else {
						frame.origin.x = 1024 - frame.size.width - LBPaddingRight;
						frame.origin.y = LBPaddingTop + 40 + i * (imageRect.size.height + LBGap);
					}
					
					imageView.frame = frame;
					
					[self.imageViews addObject:imageView];				
					[self.view addSubview:imageView];
					[imageView release];
					
					
					// Create drop placeholder.
					CGRect dropRect = frame;
					dropRect.size.height = 60;
					dropRect.origin.y = frame.origin.y + frame.size.height;
					
					UIView *dropPlace = [[UIView alloc] initWithFrame:dropRect];
					dropPlace.backgroundColor = [UIColor clearColor];
					dropPlace.layer.borderColor = [[UIColor blackColor] CGColor];
					dropPlace.layer.borderWidth = 1;
					dropPlace.layer.cornerRadius = 20;
					dropPlace.tag = i;
									
					[self.dropViews addObject:dropPlace];
					[self.view addSubview:dropPlace];
					[dropPlace release];
					
				}
				[image release];
				image = nil;
			}
				NSLog(@"%d", self.questionLeft);
		}
		[obj release];
	}
		
	[self._theData release];
	self._theData = nil;
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

- (IBAction)startGameAtLevel:(id)sender {
	[self levelSelector:(int)[sender tag]];
}

- (IBAction)playAgain:(id)sender 
{	
	self.isAtLevel = 1;
	
	[self levelSelector:self.isAtLevel];
	
	[[self.view viewWithTag:503] removeFromSuperview];
}

- (IBAction)backButton:(id)sender {
	[self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)toBookMenu 
{
	[[self navigationController] popToRootViewControllerAnimated:YES];
}

- (BOOL)noQuestionLeft 
{
	if ( 0 == self.questionLeft) {
		return YES;
	}
	return NO;
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	
	[self.imagesPath release];
	[self.imageViews release];
	[self.dropViews release];
	[self.labelViews release];
	
	[_volume1 release];
	[_theData release];
}


@end

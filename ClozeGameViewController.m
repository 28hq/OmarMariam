    //
//  ClozeGameViewController.m
//  OmarMariam
//
//  Created by A.L.L.Y.K. on 10/25/10.
//  Copyright 2010 Brainstorm Technologies Sdn Bhd. All rights reserved.
//

#import "ClozeGameViewController.h"
#import "AppDelegate_iPad.h"

#import "Constants.h"


@implementation ClozeGameViewController

@synthesize theData;

@synthesize labelViews, dropViews, sentenceViews;
@synthesize questionLeft, totalLevel, isAtLevel, bookNumber;
@synthesize gameNumberImage;

// IBOutlet
@synthesize gameNumber, gameNumber2, levelIndicator, levelImageView, levelImageView2, cover, game;
@synthesize continueButtonView, continueButton;
@synthesize wordListView, end;
@synthesize wordListScrollView;

- (id)initWithBookNumber:(int)number 
{
    if ((self = [super initWithNibName:@"ClozeGameViewController" bundle:nil])) {
        // Custom initialization
		self.bookNumber = number;
		
		gameNumberImage = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%d", number] 
																				ofType:@"png"]];

		
		NSMutableArray *_labelViews = [[NSMutableArray alloc] init];
		self.labelViews = _labelViews;
		[_labelViews release];
		
		NSMutableArray *_dropViews = [[NSMutableArray alloc] init];
		self.dropViews = _dropViews;
		[_dropViews release];
		
		NSMutableArray *_sentenceViews = [[NSMutableArray alloc] init];
		self.sentenceViews = _sentenceViews;
		[_sentenceViews release];
		
		//imagePaths = [[NSArray alloc] initWithArray:[[NSBundle mainBundle] pathsForResourcesOfType:@"png" inDirectory:@"Volume1/ClozeGames/Game1/Images"]];
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	/*
	 * Set cover image based on the game number.
	 */
	
	

	levelImageView.image = [self getImage:@"cover"];

	gameNumber.image = self.gameNumberImage;
	
}

- (void)startGame:(id)sender 
{
	[self.view addSubview:game];
	[self levelSelector:1];
	
}

- (IBAction)playAgainButton:(id)sender 
{
	self.isAtLevel = 1;
	[self levelSelector:self.isAtLevel];
	[[self end] setHidden:YES];
}

- (void)levelSelector:(int)level
{
	/*
	 * Clear all objects on screen
	 */
	
	for (UIView * subview in [self.view subviews]) 
	{
		if (subview.tag == kUnderlineViewID || subview.tag == kLevelIndicatorViewID) {
			[subview removeFromSuperview];
			//break;
		}
	}
	
	if (0 != [self.labelViews count]) {
		for (UIView * _aView in self.labelViews) {
			//[self.labelViews removeObject:_aView];
			[_aView removeFromSuperview];
			//[_aView release];
			//_aView = nil;
		}
		[self.labelViews removeAllObjects];
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
	
	if (0 != [self.sentenceViews count]) {
		for (UIView * _sView in self.sentenceViews) 
		{
			[_sView removeFromSuperview];
		}
		
		[self.sentenceViews removeAllObjects];
	}
	
	
	/*
	 * Initialize game.
	 */
	AppDelegate_iPad *delegate = [[UIApplication sharedApplication] delegate];

	self.isAtLevel = level;
	
	self.totalLevel = [[[delegate.volume1 objectAtIndex:self.bookNumber - 1] // iBook1, 2, 3 etc.
						objectForKey:@"ClozeGame"] count];

	self.theData = [[[[delegate.volume1 objectAtIndex:self.bookNumber - 1] // iBook1, 2, 3 etc.
						objectForKey:@"ClozeGame"] // LabelGame, ClozeGame
						objectAtIndex:level-1] retain]; // Game No.
											   // Level1, 2, 3 etc.
	self.questionLeft = 0;
	
	gameNumber2.image = gameNumberImage;
	
	// Create level indicator
	[self createLevelIndicator];
	
	// Positioning Text on views.
	NSUInteger i, count = [self.theData count];
	
	if (0 == count) { return; }

	int wordCount = 0;
	//NSMutableArray *sizes = [[NSMutableArray alloc] init];
	
	for (i = 0; i < count; i++) 
	{
		NSObject * obj = [[self.theData objectAtIndex:i] retain];
		
		if ([obj isKindOfClass:[NSDictionary class]] && [(NSDictionary*)obj count] > 0) 
		{
			int tag = i;
			CGSize size;
			// Set the location of the `word`
			
			if ([[obj valueForKey:@"word"] isKindOfClass:[NSArray class]]) {
				int counter = 0;
				for (NSString *_word in [obj valueForKey:@"word"]) {
					
					counter += 1;
					wordCount += 1;
					tag = i + (10 * counter); 
					
					UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
					textLabel.text = _word;
					textLabel.backgroundColor = [UIColor clearColor];
					textLabel.tag = tag;
					textLabel.textAlignment = UITextAlignmentRight;
					
					textLabel.font = [UIFont boldSystemFontOfSize:40];
					size = [_word sizeWithFont:[UIFont boldSystemFontOfSize:40]];
					//[sizes addObject:[NSValue valueWithCGSize:size]];
					
					CGRect rect;
					rect.origin.x = self.wordListView.frame.size.width - size.width - 30;
					rect.origin.y = kLBPaddingTop + (wordCount-1) * (size.height + 20);
					rect.size = size;
					
					textLabel.frame = rect;
					
					
					[self.wordListScrollView addSubview:textLabel];
					[self.labelViews addObject:textLabel];
					
					
					[textLabel release];
					[_word release];
				}
			}
			else if (nil != [obj valueForKey:@"word"]) {
				wordCount += 1;
				
				NSString * word = [[NSString alloc] initWithString:[obj valueForKey:@"word"]];
				
				UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
				textLabel.text = word;
				textLabel.backgroundColor = [UIColor clearColor];
				textLabel.tag = i;
				textLabel.textAlignment = UITextAlignmentRight;
				
				textLabel.font = [UIFont boldSystemFontOfSize:40];
				size = [word sizeWithFont:[UIFont boldSystemFontOfSize:40]];
				//[sizes addObject:[NSValue valueWithCGSize:size]];
				
				CGRect rect;
				rect.origin.x = self.wordListView.frame.size.width - size.width - 30;
				rect.origin.y = kLBPaddingTop + (wordCount-1) * (size.height + 20);
				rect.size = size;
				
				textLabel.frame = rect;
				
				
				[self.wordListScrollView addSubview:textLabel];
				[self.labelViews addObject:textLabel];
				
				
				[textLabel release];
				[word release];				
			}

			
			self.wordListScrollView.layer.borderColor = [[UIColor blueColor] CGColor];
			self.wordListScrollView.layer.borderWidth = 3;
			self.wordListScrollView.layer.cornerRadius = 5;
			
			self.wordListScrollView.backgroundColor = [UIColor whiteColor];
			self.wordListScrollView.clipsToBounds = YES;
			self.wordListScrollView.contentSize = CGSizeMake(self.wordListScrollView.frame.size.width, (wordCount) * (size.height + 20));
			self.wordListScrollView.scrollEnabled = YES;
			self.wordListScrollView.delegate = self;	
			
			self.wordListView.frame = CGRectMake(0.0, 0.0, self.wordListScrollView.frame.size.width, self.wordListScrollView.contentSize.height);

			
			// Create sentences.
			
			
			CGRect lastPosition = CGRectMake(1000, 0, 0, 0);
			
			NSArray *stringArray = [[NSArray alloc] init];
			stringArray = [[[[self theData] objectAtIndex:i] valueForKey:@"sentence"] componentsSeparatedByString:@"#"];
			
			NSUInteger j, count = [stringArray count];
			
			
			for (j = 0; j < count; j++) 
			{
				NSString * ayat = [stringArray objectAtIndex:j];
				
				//NSLog(@"%@", ayat);			
				
				UILabel *sentence = [[UILabel alloc] initWithFrame:CGRectZero];
				sentence.backgroundColor = [UIColor clearColor];
				
				CGRect frame;
				
				frame.origin.x = 1024 - (j * kBlankWidth) - 30;
				frame.origin.y = 4 * kLBPaddingTop + i * (30 + kLBGap);
				frame.size.height = 30;
				
				sentence.frame = frame;
				sentence.text = ayat;
				sentence.font = [UIFont systemFontOfSize:kClozeGameFontSize];
				[sentence sizeToFit];
				//NSLog(@"%@", NSStringFromCGRect(sentence.frame));
				
				
				if (j!=0) frame.origin.x = lastPosition.origin.x - (1 * kBlankWidth) - sentence.frame.size.width;
				else frame.origin.x = lastPosition.origin.x - sentence.frame.size.width;
				
				sentence.frame = frame;
				[sentence sizeToFit];
				
				//NSLog(@"%@", NSStringFromCGRect(sentence.frame));
				lastPosition = sentence.frame;
				
				[self.sentenceViews addObject:sentence];
				[self.view addSubview:sentence];

				[sentence release];
				
				CGRect dropRect = lastPosition;
				
				if (0 != j) {
					
					// Create drop placeholder.
					dropRect.origin.x = dropRect.origin.x + dropRect.size.width;
					dropRect.size.width = kBlankWidth;
					
					if (0 == dropRect.size.height) {
						dropRect.size.height = 70;
					}
					
					UIView *dropPlace = [[UIView alloc] init];
					dropPlace.backgroundColor = [UIColor clearColor];
					
					if (tag > 10) {
						dropPlace.tag = i + (10 * j);
						//dropRect.size.width = [[sizes objectAtIndex:j-1] CGSizeValue].width;
					}
					else {
						dropPlace.tag = tag;
						//dropRect.size.width = [[sizes objectAtIndex:0] CGSizeValue].width;
					}
					
					dropPlace.frame = dropRect;

					
					[self.dropViews addObject:dropPlace];
					
					//NSLog(@"%@", NSStringFromCGRect([[self.dropViews objectAtIndex:0] frame]));

					
					[self.view addSubview:dropPlace];
					[dropPlace release];
					
					// Create underline.
					UIView *underline = [[UIView alloc] initWithFrame:dropRect];
					underline.backgroundColor = [UIColor blackColor];
					underline.tag = kUnderlineViewID;
					CGRect lineFrame = dropRect;
					
					lineFrame.size.height = 4.0;				
					lineFrame.origin.y += dropRect.size.height - 5.0;
					underline.frame = lineFrame;
					
					[self.view addSubview:underline];
					[underline release];
					
					// Increase question numbers.
					self.questionLeft += 1; 
				}
				
			}		

		}
		// The data is of type string. :must be info on the image.
		else if ([obj isKindOfClass:[NSString class]]) 
		{
			levelImageView2.image = [self getImage:(NSString *)obj];
		}

		[obj release];
	}
	
	[self.theData release];
	self.theData = nil;
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
	
	[gameNumberImage release];

	[self.dropViews release];
	[self.labelViews release];
	[self.sentenceViews release];
}

- (void)createLevelIndicator {
	
	// Creating level state indicator
	//NSLog(@"level: %d", self.totalLevel);
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

- (UIImage *)getImage:(NSString *)imageName 
{

	NSString *directory = [NSString stringWithFormat:@"Volume1/ClozeGames/Game%d/Images", self.bookNumber];

	NSString *imagePath;
	
	NSRange range = [imageName rangeOfString:@"."];

	if (range.location != NSNotFound) 
	{
		imagePath = [[NSBundle mainBundle] pathForResource:[imageName substringToIndex:range.location]
															  ofType:[imageName substringFromIndex:range.location+1]
														 inDirectory:directory];
	}
	else {
		imagePath = [[NSBundle mainBundle] pathForResource:imageName
															  ofType:@"png"
														 inDirectory:directory];
	}
	
	UIImage * image = [[UIImage alloc] initWithContentsOfFile:imagePath];

	[image autorelease];
	
	return image;	
}

- (BOOL)noQuestionLeft 
{
	if ( 0 == self.questionLeft) 
	{
		return YES;
	}
	return NO;
}

- (void)nextLevel {

	if (self.isAtLevel >= self.totalLevel) {
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

	[self levelSelector:self.isAtLevel];
	
	self.continueButtonView.hidden = YES;
}

- (void)toBookMenu 
{
	[[self navigationController] popToRootViewControllerAnimated:YES];
}

@end

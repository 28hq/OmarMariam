    //
//  ExampleViewController.m
//  Leaves
//
//  Created by Tom Brow on 4/18/10.
//  Copyright 2010 Tom Brow. All rights reserved.
//

#import "BookViewController.h"
#import "Utilities.h"

#define SOUND_POS_X (1024/4 + 175)
#define SOUND_POS_Y 30
#define SOUND_WIDTH 44
#define SOUND_HEIGHT 44

@implementation BookViewController

@synthesize bookNumber;
@synthesize playBtnPositionIsRight, showSound;
@synthesize btnPlay;
@synthesize transitionType;

- (id)initWithBookNumber:(int)number 
{
	self.bookNumber = number;
	//self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	
	NSString *bookPath = [NSString stringWithFormat:@"Volume1/iBooks/iBook%d", number];
//    		(LeavesViewController*)self.viewController = self;

	if (self = [super init]) 
	{
		//		(LeavesViewController*) = self;
		//leavesView.viewController = self;
		[self leavesView].viewController = self;
		
		NSBundle* myBundle = [NSBundle mainBundle];
		
		NSArray *imagesPath = [myBundle pathsForResourcesOfType:@"jpg"
													inDirectory:bookPath];

		/*
		 For some reason, if the last page is odd (is it even??), the Leaves
		 class/library will create a NSArray error of out of bound.
		 
		 Thus, the code below added a blank page to the array if condition true.
		 */
		if (0 != imagesPath.count) {
			images = [[NSMutableArray alloc] initWithArray:imagesPath];
			
			if (images.count % 2 == 0) {
				[images addObject:[myBundle pathForResource:@"blank" ofType:@"jpg"]];
			}
		}		
		
		btnPlay = [UIButton buttonWithType:UIButtonTypeCustom];
		[btnPlay setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
		btnPlay.frame = (playBtnPositionIsRight) ? CGRectMake(SOUND_POS_X, SOUND_POS_Y, SOUND_WIDTH, SOUND_HEIGHT) : CGRectMake(930, 30, 44,44);
		btnPlay.showsTouchWhenHighlighted = NO;
		btnPlay.adjustsImageWhenHighlighted = NO;
		btnPlay.hidden = YES;
		[self.view addSubview:btnPlay];
    }
    return self;
}

- (void)dealloc {
	[images release];
    [super dealloc];
}

- (void)exitBook {
	[self dismissModalViewControllerAnimated:YES];
}

- (void)toBookMenu 
{
	[[self navigationController] popToRootViewControllerAnimated:YES];
}

#pragma mark  LeavesViewDelegate methods

- (void) leavesView:(LeavesView *)leavesView willTurnToPageAtIndex:(NSUInteger)pageIndex {

	[soundPlay stop];	
	
	pathToMusicFile = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"BP%d0%d", bookNumber, pageIndex-2] 
													  ofType:@"mp3" 
												 inDirectory:[NSString stringWithFormat:@"Volume1/iBooks/iBook%d", bookNumber]];
	
	playBtnPositionIsRight = NO;
	
	if (0 != [pathToMusicFile length]) 
	{		
		showSound = YES;
		btnPlay.hidden = NO;
	}
	else 
	{
		showSound = NO;
		btnPlay.hidden = YES;
	}

	
	self.navigationItem.hidesBackButton = YES; 
	if (showSound)//showsound is a boolean value tht needs to be set on the pg where ot will be shown
	{
		
		[btnPlay addTarget:self action:@selector(playSound:) forControlEvents:UIControlEventTouchDown];
		
		
		soundPlay = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:pathToMusicFile] error:NULL];
		soundPlay.delegate = self;
	}
	
	// last page.
	
	if (pageIndex >= images.count-1) {
		[self performSelector:@selector(exitBook) withObject:self afterDelay:3];
	}
}

#pragma mark LeavesViewDataSource methods

- (NSUInteger) numberOfPagesInLeavesView:(LeavesView*)leavesView {
	return images.count;
}

- (void) renderPageAtIndex:(NSUInteger)index inContext:(CGContextRef)ctx 
{	
	UIImage *image = [UIImage imageWithContentsOfFile:[images objectAtIndex:index]];
	CGRect imageRect = CGRectMake(0, 0, image.size.width, image.size.height);
	CGAffineTransform transform = aspectFit(imageRect,
											CGContextGetClipBoundingBox(ctx));
	CGContextConcatCTM(ctx, transform);
	CGContextDrawImage(ctx, imageRect, [image CGImage]);
}


#pragma mark Audio Player

- (void)playSound:(id)sender
{
	NSLog(@"playing sound");
	[soundPlay play];
}

@end

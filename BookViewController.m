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
@synthesize leftPlayButton;
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

		[btnPlay setImage:[UIImage imageNamed:@"playBlack.png"] forState:UIControlStateNormal];
		[btnPlay setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateSelected];
//		[btnPlay setBackgroundImage:[UIImage imageNamed:@"playBlack.png"] forState:UIControlStateNormal];
//		[btnPlay setBackgroundImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateHighlighted];
		btnPlay.frame = CGRectMake(930, 30, 44,44);
		btnPlay.showsTouchWhenHighlighted = NO;
		btnPlay.adjustsImageWhenHighlighted = YES;
		btnPlay.hidden = YES;
		[self.view addSubview:btnPlay];
		
//		leftPlayButton = [UIButton buttonWithType:UIButtonTypeCustom];
//		[leftPlayButton setImage:[UIImage imageNamed:@"playBlack.png"] forState:UIControlStateNormal];
//		[leftPlayButton setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateHighlighted];
//		leftPlayButton.frame = CGRectMake(SOUND_POS_X, SOUND_POS_Y, SOUND_WIDTH, SOUND_HEIGHT);
//		leftPlayButton.showsTouchWhenHighlighted = NO;
//		leftPlayButton.adjustsImageWhenHighlighted = NO;
//		leftPlayButton.hidden = YES;
//		[self.view addSubview:leftPlayButton];
		
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
	
//	NSLog(@"%@", [NSString stringWithFormat:@"BP%d%02d", bookNumber, pageIndex-2]);
	pathToMusicFile = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"BP%d%02d", bookNumber, pageIndex-2] 
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
		[soundPlay prepareToPlay];
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
	btnPlay.layer.backgroundColor = [[UIColor brownColor] CGColor];
	btnPlay.layer.borderColor = [[UIColor brownColor] CGColor];
	btnPlay.layer.borderWidth = 1.0f;
	btnPlay.layer.cornerRadius = 10.0f;
	btnPlay.selected = YES;
	[soundPlay play];
}

#pragma mark Audio Player delegates

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
	if (flag) {
		btnPlay.layer.backgroundColor = [[UIColor clearColor] CGColor];
		btnPlay.layer.borderColor = [[UIColor clearColor] CGColor];
		btnPlay.layer.borderWidth = 0.0f;
		btnPlay.layer.cornerRadius = 0.0f;
		btnPlay.selected = NO;
	}
}

@end

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
@synthesize bookVolume;
@synthesize playBtnPositionIsRight, showSound;
@synthesize btnPlay;
@synthesize leftPlayButton;
@synthesize activeButtonPlayed;
@synthesize transitionType;

- (id)initWithBook:(int)aBookNumber ofVolume:(int)aBookVolume	
{
	bookNumber = aBookNumber;
	bookVolume = aBookVolume;
	
	NSString *bookPath = [NSString stringWithFormat:@"Volume%d/iBooks/iBook%d", aBookVolume, aBookNumber];

	if (self = [super init]) 
	{
		[self leavesView].viewController = self;
		
		NSBundle *myBundle = [NSBundle mainBundle];
		
		NSArray *imagesPath = [myBundle pathsForResourcesOfType:@"jpg" inDirectory:bookPath];
		
		/*
		 For some reason, if the last page is odd (is it even??), the Leaves
		 class/library will create a NSArray error of out of bound.
		 
		 Thus, the code below added a blank page to the array if condition true.
		 */
        
		
		if (imagesPath.count != 0)
		{
			images = [[NSMutableArray alloc] init];
			
			NSMutableArray *tempArray = [[NSMutableArray alloc] init];
			NSString *cp, *bp;
			
			for (NSString *string in imagesPath) 
			{				
				if ([[[string lastPathComponent] stringByDeletingPathExtension] isEqualToString:@"cp"]) {
					cp = string;
				}
				
				else if ([[[string lastPathComponent] stringByDeletingPathExtension] isEqualToString:@"bp"]) {
					bp = string;
				}
				
				else {
					[tempArray addObject:string];
				}

			}
			
			if (cp != nil) { 
				[images addObject:cp];	
				[images addObject:[myBundle pathForResource:@"blank" ofType:@"jpg"]];
			}
			
			[images addObjectsFromArray:tempArray];
			
			if (bp != nil) { [images addObject:bp]; }
			
			[tempArray release];
			
			if (images.count % 2 == 0) {
				[images addObject:[myBundle pathForResource:@"blank" ofType:@"jpg"]];
			}			
		}
		
		btnPlay = [UIButton buttonWithType:UIButtonTypeCustom];

		[btnPlay setImage:[UIImage imageNamed:@"playBlack.png"] forState:UIControlStateNormal];
		[btnPlay setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateSelected];

		btnPlay.frame = CGRectMake(930, 30, 44,44);
		btnPlay.showsTouchWhenHighlighted = NO;
		btnPlay.adjustsImageWhenHighlighted = YES;
		btnPlay.hidden = YES;
		[self.view addSubview:btnPlay];
		
		leftPlayButton = [UIButton buttonWithType:UIButtonTypeCustom];
		
		[leftPlayButton setImage:[UIImage imageNamed:@"playBlack.png"] forState:UIControlStateNormal];
		[leftPlayButton setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateSelected];
		
		leftPlayButton.frame = CGRectMake(SOUND_POS_X, SOUND_POS_Y, SOUND_WIDTH, SOUND_HEIGHT);
		leftPlayButton.showsTouchWhenHighlighted = NO;
		leftPlayButton.adjustsImageWhenHighlighted = YES;
		leftPlayButton.hidden = YES;
		[self.view addSubview:leftPlayButton];
		
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

- (void)clearPlayButtonAttributesForButton:(UIButton *)aButton
{
	aButton.layer.backgroundColor = [[UIColor clearColor] CGColor];
	aButton.layer.borderColor = [[UIColor clearColor] CGColor];
	aButton.layer.borderWidth = 0.0f;
	aButton.layer.cornerRadius = 0.0f;
	aButton.selected = NO;
}

#pragma mark  LeavesViewDelegate methods

- (void) leavesView:(LeavesView *)leavesView willTurnToPageAtIndex:(NSUInteger)pageIndex {

	[soundPlay stop];
	
	btnPlay.hidden = leftPlayButton.hidden = YES;
	
//	NSLog(@"%@", [NSString stringWithFormat:@"BP%d%02d", bookNumber, pageIndex-2]);
	
	pathToMusicFile = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%02d", pageIndex-1] 
													  ofType:@"mp3" 
												 inDirectory:[NSString stringWithFormat:@"Volume%d/iBooks/iBook%d", bookVolume, bookNumber]];
	
	BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:pathToMusicFile];
	
	if (fileExists) {
		btnPlay.hidden = NO;
		
		[self clearPlayButtonAttributesForButton:btnPlay];
		
		[btnPlay addTarget:self action:@selector(playSound:) forControlEvents:UIControlEventTouchDown];
		
		soundPlay = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:pathToMusicFile] error:NULL];
		soundPlay.delegate = self;
		[soundPlay prepareToPlay];
	}
	
	else {
		pathToMusicFile = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%02d", pageIndex-2] 
														  ofType:@"mp3" 
													 inDirectory:[NSString stringWithFormat:@"Volume%d/iBooks/iBook%d", bookVolume, bookNumber]];
		
		BOOL file2Exists = [[NSFileManager defaultManager] fileExistsAtPath:pathToMusicFile];
		
		if (file2Exists) {

			leftPlayButton.hidden = NO;
			
			[self clearPlayButtonAttributesForButton:leftPlayButton];
			
			[leftPlayButton addTarget:self action:@selector(playSound:) forControlEvents:UIControlEventTouchDown];
			
			soundPlay = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:pathToMusicFile] error:NULL];
			soundPlay.delegate = self;
			[soundPlay prepareToPlay];
		}
		
		else {
			btnPlay.hidden = YES;
			leftPlayButton.hidden = YES;
		}

		
	}
	
	self.navigationItem.hidesBackButton = YES; 
	
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
	
	[sender layer].backgroundColor = [[UIColor brownColor] CGColor];
	[sender layer].borderColor = [[UIColor brownColor] CGColor];
	[sender layer].borderWidth = 1.0f;
	[sender layer].cornerRadius = 10.0f;
	[(UIButton*)sender setSelected:YES];
	[soundPlay play];
	
	activeButtonPlayed = sender;
}

#pragma mark Audio Player delegates

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
	if (flag) {
		[self clearPlayButtonAttributesForButton:activeButtonPlayed];
	}
}

@end

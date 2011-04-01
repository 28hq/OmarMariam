//
//  LineView.m
//  OmarMariam
//
//  Created by A.L.L.Y.K. on 11/4/10.
//  Copyright 2010 Brainstorm Technologies Sdn Bhd. All rights reserved.
//

#import "LineView.h"
#import "LBView.h"

CGFloat distance(CGPoint a, CGPoint b);

@implementation LineView

@synthesize aLineGameViewController, correct, start, redrawToPrevious, dragged, touchEnded;
@synthesize	objectTouched, objectTagged, lines;
@synthesize currentTouchPoint, startTouchPoint;

- (void)awakeFromNib {

	// Initialization code
	self.objectTouched = [[NSString alloc] init];
	self.lines = [[NSMutableArray alloc] init];
	self.redrawToPrevious = NO;
	self.dragged = NO;
	self.touchEnded = NO;
	
	[self initSounds];
}

- (void)initSounds {
	
	NSString *pathToSound = [[NSBundle mainBundle] pathForResource:@"correct" ofType:@"mp3"];
	BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:pathToSound];
	
	if (fileExists) {
		correctSound = [[AVAudioPlayer alloc] initWithContentsOfURL:
						[NSURL fileURLWithPath:pathToSound] error:NULL];
		correctSound.delegate = self;
		[correctSound prepareToPlay];
	}
	
	pathToSound = [[NSBundle mainBundle] pathForResource:@"incorrect" ofType:@"mp3"];
	fileExists = [[NSFileManager defaultManager] fileExistsAtPath:pathToSound];
	
	if (fileExists) {
		incorrectSound = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:pathToSound] error:NULL];
		incorrectSound.delegate = self;
		[incorrectSound prepareToPlay];
	}
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
	[self drawLine:rect];
}

- (void)dealloc {
	[self.objectTouched release];
	[self.lines release];
	[correctSound release];
	[incorrectSound release];
	
    [super dealloc];
}

- (void)drawLine:(CGRect)rect 
{
	CGContextRef context = UIGraphicsGetCurrentContext();

	CGContextClearRect(context, rect);
	CGContextSetLineWidth(context, 5.0f);
	CGFloat gray[4] = {0.0f, 0.0f, 0.0f, 1.0f};
	CGContextSetStrokeColor(context, gray);
	
	if ([self.lines count]) 
	{
		for (NSArray *arr in self.lines) 
		{
			CGPoint point = CGPointFromString([arr valueForKey:@"startTouchPoint"]);
			//NSLog(@"%@", NSStringFromCGPoint(point));
			CGContextMoveToPoint(context, point.x, point.y);
			
			point = CGPointFromString([arr valueForKey:@"currentTouchPoint"]);
			CGContextAddLineToPoint(context, point.x, point.y);
			CGContextStrokePath(context);
		}
	}
	
	if (!correct && !touchEnded) {
		CGContextMoveToPoint(context, self.startTouchPoint.x, self.startTouchPoint.y);
		CGContextAddLineToPoint(context, self.currentTouchPoint.x, self.currentTouchPoint.y);
	}

	CGContextStrokePath(context);
	
}

- (void)cleanUp {
	// clear lines array.
	[self.lines removeAllObjects];
	
	// set scalar values to zero;
	objectTagged = 0;
	currentTouchPoint = startTouchPoint = CGPointZero;
	objectTouched = @"";
	correct = NO;
	start = NO;
	
	[self setNeedsDisplay];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [event.allTouches anyObject];
	self.startTouchPoint = [touch locationInView:self];

	self.correct = NO;
	dragged = NO;
	touchEnded = NO;
	
	for (UITouch *touch in touches) 
	{
		// check if touch in wordView.
		for (UILabel *word in [self.aLineGameViewController wordViews]) 
		{
			CGRect wordRect = [word.superview convertRect:word.frame toView:self];
			if (CGRectContainsPoint(wordRect, [touch locationInView:self])) 
			{
				self.startTouchPoint = [touch locationInView:self];
				self.objectTouched = @"word";
				self.objectTagged = word.tag;
				self.start = YES;
				
				break;
			}
		}
		
		// check if touch in pictureView.
		for (UILabel *picture in [self.aLineGameViewController pictureViews]) 
		{
			CGRect pictureRect = [picture.superview convertRect:picture.frame toView:self];
			if (CGRectContainsPoint(pictureRect, [touch locationInView:self])) 
			{
				self.startTouchPoint = [touch locationInView:self];
				self.objectTouched = @"picture";
				self.objectTagged = picture.tag;
				self.start = YES;
				
				break;
			}
		}
	}

	
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	dragged = YES;
	if ([[touches allObjects] count] > 0)  
	{
		self.currentTouchPoint = [[[touches allObjects] objectAtIndex:0] locationInView:self];

		if (self.objectTouched == @"picture" || self.objectTouched == @"word") 
		{
			[self setNeedsDisplay];
		}
	}
	
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (self.start && [self.objectTouched isEqual:@"word"] && !dragged) 
	{
		// Play sound for the TOUCHED word.
		if (self.aLineGameViewController.isAtLevel <= 1) {
			[self.aLineGameViewController playSoundFor:@"picture" withTag:self.objectTagged];
		}		
	}
	
	if (self.start && [self.objectTouched isEqual:@"picture"] && !dragged) 
	{
		// Play sound for the TOUCHED picture.
		if (self.aLineGameViewController.isAtLevel <= 2) {
			[self.aLineGameViewController playSoundFor:@"picture" withTag:self.objectTagged];
		}
	}
	
	self.correct = NO;
	touchEnded = YES;
	
	UITouch *touch = [event.allTouches anyObject];
	
	CGPoint touchPoint = [touch locationInView:self];
	// 10 is drag threshold.
	dragged = distance(touchPoint, startTouchPoint) > 100;

	if (self.objectTouched == @"picture" && dragged) 
	{
		for (UILabel *word in [self.aLineGameViewController wordViews])
		{
			CGRect wordRect = [word.superview convertRect:word.frame toView:self];
			if (CGRectContainsPoint(wordRect, self.currentTouchPoint) 
				&& word.tag == self.objectTagged) 
			{
				self.correct = YES;
				NSMutableDictionary	*line = [[NSMutableDictionary alloc] init];

				[line setValue:NSStringFromCGPoint(self.startTouchPoint) forKey:@"startTouchPoint"];
				[line setValue:NSStringFromCGPoint(self.currentTouchPoint) forKey:@"currentTouchPoint"];
				
				[self.lines addObject:line];
				
				[line release];
				
				/*
				 * Check question and move to next level if completed.
				 */
				self.aLineGameViewController.questionLeft = self.aLineGameViewController.questionLeft - 1;
				
				[self.aLineGameViewController checkLevelCompletion];

				break;
			}
		}
	}
	else if (self.objectTouched == @"word" && dragged) 
	{
		for (UIImageView *picture in [self.aLineGameViewController pictureViews])
		{
			CGRect pictureRect = [picture.superview convertRect:picture.frame toView:self];
			if (CGRectContainsPoint(pictureRect, self.currentTouchPoint)
				&& picture.tag == self.objectTagged) 
			{
				self.correct = YES;
				NSMutableDictionary *line = [[NSMutableDictionary alloc] init];
				
				[line setValue:NSStringFromCGPoint(self.startTouchPoint) forKey:@"startTouchPoint"];
				[line setValue:NSStringFromCGPoint(self.currentTouchPoint) forKey:@"currentTouchPoint"];

				[self.lines addObject:line];

				[line release];
				
				
				/*
				 * Check question and move to next level if completed.
				 */
				self.aLineGameViewController.questionLeft = self.aLineGameViewController.questionLeft - 1;
				
				[self.aLineGameViewController checkLevelCompletion];
				
				break;
			}
		}		
	}
	else if (!dragged && [touch tapCount] == 1) {
		[self performSelector:@selector(oneTap) withObject:nil afterDelay:.5];
	}
	
	
	/*
	 * Play Correct/Incorrect Sound.
	 */
	
	if (dragged && start) 
	{
		NSLog(@"Dragged");
		if (self.correct) {
			[correctSound play];
		}
		else {
			[incorrectSound play];
		}	
	}
	
	self.start = NO;
	[self setNeedsDisplay];
	
}

@end

    //
//  QuizViewController.m
//  OmarMariam
//
//  Created by A.L.L.Y.K. on 10/31/10.
//  Copyright 2010 Brainstorm Technologies Sdn Bhd. All rights reserved.
//

#import "QuizViewController.h"
#import "AppDelegate_iPad.h"

@implementation QuizViewController

@synthesize countQuestions;
@synthesize gameNumberImage;
@synthesize theData;
// IBOutlet
@synthesize cover, game, end;
@synthesize continueButtonView, questionLabel, choicesView;
@synthesize levelImageView, gameNumber, gameNumber2, questionImageView;
@synthesize choice1, choice2, choice3;


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		
		self.gameNumberImage = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"1" 
																								  ofType:@"png"]];
		self.theData = [[NSArray alloc] init];
    }
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	/*
	 * Set cover image based on the game number.
	 */
	
	int gameNo = 1;
	NSString *directory = [[NSString alloc] initWithFormat:@"Volume1/Quizzes/Quiz%d/Images", gameNo];
	
	NSString *imagePath = [[NSString alloc] init];
	imagePath = [[NSBundle mainBundle] pathForResource:@"cover" 
												ofType:@"png" 
										   inDirectory:directory];
	
	UIImage *image = [[UIImage alloc] initWithContentsOfFile:imagePath];
	levelImageView.image = image;
	[image release];
	
	image = nil;
	imagePath = nil;
	imagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%d", gameNo] 
												ofType:@"png"];
	
	image = [[UIImage alloc] initWithContentsOfFile:imagePath];
	gameNumber.image = image;
	[image release];
	
	[directory release];
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
	
	[self.theData release];
	[self.gameNumberImage release];
}

- (void)startGame:(id)sender 
{
	[self.view addSubview:game];
	[self loadQuestion:1];
}

- (void)loadQuestion:(int)no 
{
	/*
	 * Initialize game.
	 */
	
	AppDelegate_iPad *delegate = [[UIApplication sharedApplication] delegate];
	
	//self.isAtLevel = level;
	self.countQuestions = [[[delegate.volume1 objectAtIndex:0] // iBook1, 2, 3 etc.
						objectForKey:@"QuizGame"] count];
	
	self.theData = [[[[delegate.volume1 objectAtIndex:0] // iBook1, 2, 3 etc.
					  objectForKey:@"QuizGame"] // LabelGame, ClozeGame
					 objectAtIndex:no-1] retain]; // Game No.
													 //self.questionLeft = 0;
	
	gameNumber2.image = gameNumberImage;
	
	/*
	 * Populating the Questions and Choices.
	 */
	
	
	self.questionLabel.text = [self.theData valueForKey:@"question"];
	
	NSString *imagePath = [[NSString alloc] init];
	
	// Create question's picture.
	imagePath = [[NSBundle mainBundle] pathForResource:[self.theData valueForKey:@"picture"] 
												ofType:@"jpg"
										   inDirectory:@"Volume1/Quizzes/Quiz1/Images"];
	UIImage *image = [[UIImage alloc] initWithContentsOfFile:imagePath];
	
	self.questionImageView.image = image;
	
	// Get total of questions
	int nQuestion = [[self.theData valueForKey:@"choices"] count];
	
	// Answer field exists;
	if (nil != [self.theData valueForKey:@"answer"]) {
		nQuestion += 1;
	}
	
	// Assign the choices to mutable array.
	NSMutableArray *choicesList = [[NSMutableArray alloc] init];
	[choicesList addObjectsFromArray:[self.theData valueForKey:@"choices"]];
	
	[choicesList addObject:[self.theData valueForKey:@"answer"]];
	
	NSLog(@"%@", [choicesList description]);
	
	// Create answer's choices.
	CGRect choiceFrame;
	
	int count = [choicesList count];
	
	while(count--) 
	{
		int i = random() % (count+1);
		
		choiceFrame = CGRectMake(0, 0, 50.0, 50.0);
		UIButton *choiceButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[choiceButton setFrame:choiceFrame];
		
		// Resetting the button position
		choiceFrame = choiceButton.frame;
		switch (i) {
			case 0:
				choiceFrame.origin.x = choiceFrame.origin.x + self.choicesView.frame.size.width 
										- choiceFrame.size.width;
				[choiceButton setTitle:@"A" forState:UIControlStateNormal];
				break;
			case 1:
				choiceFrame.origin.x = choiceFrame.origin.x + self.choicesView.frame.size.width 
										- choiceFrame.size.width;
				choiceFrame.origin.y += choiceFrame.size.height + 20;
				[choiceButton setTitle:@"B" forState:UIControlStateNormal];
				break;
			case 2:
				choiceFrame.origin.x = choiceFrame.origin.x + self.choicesView.frame.size.width 
										- choiceFrame.size.width - self.choicesView.frame.size.width/2;
				[choiceButton setTitle:@"C" forState:UIControlStateNormal];
				break;
			case 3:
				choiceFrame.origin.x = choiceFrame.origin.x + self.choicesView.frame.size.width 
										- choiceFrame.size.width - self.choicesView.frame.size.width/2;
				choiceFrame.origin.y += choiceFrame.size.height + 20;
				[choiceButton setTitle:@"D" forState:UIControlStateNormal];
				break;
			default:
				break;
		}
		
		// The last value is the correct answer.
		if (i == nQuestion-1) {
			[choiceButton addTarget:self 
							 action:@selector(correctAnswer:) 
				   forControlEvents:UIControlEventTouchUpInside];
		}
		
		choiceButton.frame = choiceFrame;
		
		[self.choicesView addSubview:choiceButton];
		
		// Add label
		UILabel *answerChoice = [[UILabel alloc] init];
		
		choiceFrame.origin.x -= 10;
		answerChoice.frame = choiceFrame;
		answerChoice.font = [UIFont systemFontOfSize:40];
		answerChoice.text = [choicesList objectAtIndex:i];
		[answerChoice sizeToFit];
		
		// Resetting the label view since the x origin has change after sending the 
		// command sizeToFit
		choiceFrame = answerChoice.frame;
		choiceFrame.origin.x -= answerChoice.frame.size.width;
		answerChoice.frame = choiceFrame;
		
		[self.choicesView addSubview:answerChoice];
		
		[choicesList removeObjectAtIndex:i];
		
		[answerChoice release];
	}
	
	[choicesList release];
	[image release];
	[self.theData release];
}

- (void)correctAnswer:(id)sender {
	NSLog(@"correct");
}


@end

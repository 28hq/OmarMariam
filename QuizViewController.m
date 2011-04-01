    //
//  QuizViewController.m
//  OmarMariam
//
//  Created by A.L.L.Y.K. on 10/31/10.
//  Copyright 2010 Brainstorm Technologies Sdn Bhd. All rights reserved.
//

#import "QuizViewController.h"
#import "AppDelegate_iPad.h"
#import "Constants.h"

@implementation QuizViewController

@synthesize countQuestions;
@synthesize currentQuestionNo;
@synthesize totalCorrectAnswer;
@synthesize rightAnswer;
@synthesize gameNumberImage;
@synthesize theData;
@synthesize countdownTimer;
@synthesize time;
@synthesize timer;
@synthesize totalScore;
@synthesize bookNumber;

// IBOutlet
@synthesize cover, game, end;
@synthesize continueButtonView, questionLabel, choicesView;
@synthesize levelImageView, gameNumber, gameNumber2, questionImageView;
@synthesize countdownTime, score;
@synthesize popupView;
@synthesize finalScore, finalTotalCorrectAnswers, 
finalTotalWrongAnswers, finalPercentage, finalPercentageRequiredToPass;
@synthesize finalStatus;


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithBook:(int)bookNumber ofVolume:(int)bookVolume
{
    if ((self = [super initWithNibName:@"QuizViewController" bundle:nil])) {
        // Custom initialization
		self.bookNumber = bookVolume;
		self.gameNumberImage = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%d", bookVolume] 
																								  ofType:@"png"]];
    }
	[self initSounds];
	
    return self;
}

- (void)initSounds {
	
	NSString *pathToSound = [[NSBundle mainBundle] pathForResource:@"correct" ofType:@"mp3"];
	BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:pathToSound];
	
	if (fileExists) {
		correctSound = [[AVAudioPlayer alloc] initWithContentsOfURL:
						[NSURL fileURLWithPath:pathToSound] error:NULL];
		[correctSound prepareToPlay];
	}
	
	pathToSound = [[NSBundle mainBundle] pathForResource:@"incorrect" ofType:@"mp3"];
	fileExists = [[NSFileManager defaultManager] fileExistsAtPath:pathToSound];
	
	if (fileExists) {
		incorrectSound = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:pathToSound] error:NULL];
		[incorrectSound prepareToPlay];
	}
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	/*
	 * Set cover image based on the game number.
	 */
	
	self.currentQuestionNo = 1;
	self.totalScore = 0;
	self.totalCorrectAnswer = 0;

	NSString *directory = [[NSString alloc] initWithFormat:@"Volume1/Quizzes/Quiz%d/Images", self.bookNumber];
	
	NSString *imagePath = [[NSString alloc] init];
	imagePath = [[NSBundle mainBundle] pathForResource:@"cover" 
												ofType:@"png" 
										   inDirectory:directory];
	
	UIImage *image = [[UIImage alloc] initWithContentsOfFile:imagePath];
	levelImageView.image = image;
	[image release];
	
	image = nil;
	imagePath = nil;
	imagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%d", self.bookNumber] 
												ofType:@"png"];
	
	image = [[UIImage alloc] initWithContentsOfFile:imagePath];
	gameNumber.image = image;
	gameNumber2.image = gameNumberImage;
	[image release];
	
	[directory release];
	
	/*
	 * Setting other views
	 */
	
	self.popupView.layer.borderColor = [[UIColor orangeColor] CGColor];
	self.popupView.layer.borderWidth = 6.0;
	self.popupView.layer.cornerRadius = 6;
	
	self.score.text = [NSString stringWithFormat:@"%d", self.totalScore];
	
	// setting final end view.
	self.finalScore.backgroundColor = [UIColor whiteColor];
	self.finalScore.alpha = 0.6;
	self.finalScore.layer.cornerRadius = 20;
	
	self.finalTotalCorrectAnswers.backgroundColor = [UIColor whiteColor];
	self.finalTotalCorrectAnswers.alpha = 0.6;
	self.finalTotalCorrectAnswers.layer.cornerRadius = 20;
	
	self.finalTotalWrongAnswers.backgroundColor = [UIColor whiteColor];
	self.finalTotalWrongAnswers.alpha = 0.6;
	self.finalTotalWrongAnswers.layer.cornerRadius = 20;
	
	self.finalPercentage.backgroundColor = [UIColor whiteColor];
	self.finalPercentage.alpha = 0.6;
	self.finalPercentage.layer.cornerRadius = 20;
	
	self.finalPercentageRequiredToPass.backgroundColor = [UIColor whiteColor];
	self.finalPercentageRequiredToPass.alpha = 0.6;
	self.finalPercentageRequiredToPass.layer.cornerRadius = 20;
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
	
	//[self.theData release];
	[self.gameNumberImage release];
}

- (void)startGame:(id)sender 
{
	NSLog(@"start game");
	
	if (![self.view viewWithTag:501]) {
		[self.view addSubview:game];
	}
	[self loadQuestion:1];
	[self startTimer];
}

- (void)nextQuestion 
{
	if (self.countQuestions == self.currentQuestionNo) 
	{
		[self.view addSubview:self.end];
		
		float percentage = (float)self.totalCorrectAnswer / (float)self.countQuestions * 100.0;
		
		if (self.totalCorrectAnswer >= 3) {
			self.finalStatus.text = @"YOU PASSED!";
		}
		else {
			self.finalStatus.text = @"YOU FAILED!";
		}


		self.finalScore.text = [NSString stringWithFormat:@"Score: %d", self.totalScore];
		self.finalTotalCorrectAnswers.text = [NSString stringWithFormat:@"Correct Answers: %d", self.totalCorrectAnswer];
		self.finalTotalWrongAnswers.text = [NSString stringWithFormat:@"Incorrect Answers: %d", self.countQuestions - self.totalCorrectAnswer];
		self.finalPercentage.text = [NSString stringWithFormat:@"Percentage Correct: %.0f%%", percentage];
		self.finalPercentageRequiredToPass.text = [NSString stringWithFormat:@"Percentage Required to Pass: %.0f%%", 100.0 - percentage];
		
		return;
	}
	
	self.currentQuestionNo += 1;
	
	[self cleanUp];

	if ([self.countdownTimer isValid]) 
	{
		[self.countdownTimer invalidate];
	}

	[self loadQuestion:self.currentQuestionNo];

	[self startTimer];
}

- (void)loadQuestion:(int)no 
{
	/*
	 * Initialize game.
	 */
	
	AppDelegate_iPad *delegate = [[UIApplication sharedApplication] delegate];
	
	self.countQuestions = [[[delegate.volume1 objectAtIndex:0] // iBook1, 2, 3 etc.
						objectForKey:@"QuizGame"] count];
	
	NSMutableDictionary *questions = [[NSMutableDictionary alloc] init];

	questions = [[[delegate.volume1 objectAtIndex:0] // iBook1, 2, 3 etc.
					  objectForKey:@"QuizGame"] // LabelGame, ClozeGame
					 objectAtIndex:no-1]; // Q No.
													 //self.questionLeft = 0;

	//NSLog(@"%@", [self.theData description]);
	/*
	 * Populating the Questions and Choices.
	 */
	
	self.timer = [(NSNumber *)[questions valueForKey:@"timer"] integerValue];
	self.questionLabel.text = [questions valueForKey:@"question"];
	
	//NSLog(@"%@", [questions valueForKey:@"question"]);
	
	NSString *imagePath = [[NSString alloc] init];
	
	// Create question's picture.
	
	NSString *directory = [NSString stringWithString:@"Volume1/Quizzes/Quiz1/Images"];
	NSFileManager *fileMgr = [NSFileManager defaultManager];
	imagePath = [[NSBundle mainBundle] pathForResource:[questions valueForKey:@"picture"]
												ofType:@"jpg"
										   inDirectory:directory];
	[directory release];
	// Automatically determine the existence of image.
	// If image does not exist in book directory, find it in root directory.
	
	if (![fileMgr fileExistsAtPath:imagePath]) 
	{
		[imagePath release];
		imagePath = [[NSBundle mainBundle] pathForResource:[questions valueForKey:@"picture"]
												   ofType:@"png"];
	}
	
	UIImage *image = [[UIImage alloc] initWithContentsOfFile:imagePath];
	
	self.questionImageView.image = image;
	
	// cannot release image here. will cause a problem.
	//[image release];
	
	// Get total of questions
	int nQuestion = [[questions valueForKey:@"choices"] count];
	
	// Answer field exists;
	if (nil != [questions valueForKey:@"answer"]) {
		self.rightAnswer = [questions valueForKey:@"answer"];
		nQuestion += 1;
	}
	
	// Assign the choices to mutable array.
	NSMutableArray *choicesList = [[NSMutableArray alloc] init];
	//[choicesList addObjectsFromArray:[self.theData valueForKey:@"choices"]];
	
	// Populate all the incorrect answers.
	NSArray *choices = [NSArray arrayWithArray:[questions valueForKey:@"choices"]];
	for (id obj in choices) 
	{
		UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[btn setTitle:obj forState:UIControlStateNormal];
		[btn setFrame:CGRectMake(0, 0, 50.0, 50.0)];
		[btn addTarget:self action:@selector(wrongAnswer) forControlEvents:UIControlEventTouchUpInside];
		
		[choicesList addObject:btn];
	}
	NSLog(@"end load question");
	// Add the correct answer.
	UIButton *answerBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[answerBtn setTitle:[questions valueForKey:@"answer"] forState:UIControlStateNormal];
	[answerBtn setFrame:CGRectMake(0.0, 0.0, 50.0, 50.0)];
	[answerBtn addTarget:self action:@selector(correctAnswer) forControlEvents:UIControlEventTouchUpInside];
	
	[choicesList addObject:answerBtn];
	
	// Create tmp_array for randomizer.
	NSMutableArray *tmp_array = [[NSMutableArray alloc] initWithArray:choicesList];
	int count = [tmp_array count];
	
	while(count--) 
	{
		int key = arc4random() % (count+1);
		
		CGRect choiceFrame = [[tmp_array objectAtIndex:key] frame];
		float btnXOrigin = self.choicesView.frame.size.width - choiceFrame.size.width;
		
		// Add label
		UILabel *answerLabel = [[UILabel alloc] init];

		answerLabel.font = [UIFont systemFontOfSize:40];
		answerLabel.text = [[tmp_array objectAtIndex:key] titleLabel].text;
		
		//NSLog(@"%d", nQuestion - count);
		switch (nQuestion - count) {
			case 1:
				choiceFrame.origin.x += btnXOrigin;
				
				[[tmp_array objectAtIndex:key] setTitle:@"A" forState:UIControlStateNormal];
				break;
			case 2:
				choiceFrame.origin.x += btnXOrigin;
				choiceFrame.origin.y += choiceFrame.size.height + 20;
				
				[[tmp_array objectAtIndex:key] setTitle:@"B" forState:UIControlStateNormal];
				break;
			case 3:
				choiceFrame.origin.x += self.choicesView.frame.size.width/2 - choiceFrame.size.width;
				
				[[tmp_array objectAtIndex:key] setTitle:@"C" forState:UIControlStateNormal];
				break;
			case 4:
				choiceFrame.origin.x += self.choicesView.frame.size.width/2 - choiceFrame.size.width;
				choiceFrame.origin.y += choiceFrame.size.height + 20;
				
				[[tmp_array objectAtIndex:key] setTitle:@"D" forState:UIControlStateNormal];
				break;
			default:
				break;
		}
		
		[[tmp_array objectAtIndex:key] setFrame:choiceFrame];
		
		[self.choicesView addSubview:[tmp_array objectAtIndex:key]];
		
		// Add label		
		choiceFrame.origin.x -= 10;
		
		answerLabel.frame = choiceFrame;		
		[answerLabel sizeToFit];
		
		// Resetting the label view since the x origin has change after sending the 
		// command sizeToFit
		choiceFrame = answerLabel.frame;
		choiceFrame.origin.x -= answerLabel.frame.size.width;
		
		answerLabel.frame = choiceFrame;
		
		[self.choicesView addSubview:answerLabel];
		[answerLabel release];
		
		[tmp_array removeObjectAtIndex:key];	
	}
	
	[tmp_array release];
	[choicesList release];
	[image release];

	
	// tak release sbb klu release ad EXEC_BAD_EXCESS
	//[questions release];

}

- (void)correctAnswer {
	
	if ([self.countdownTimer isValid]) 
	{
		/*
		 * Play Correct/Incorrect Sound.
		 */
		
		[correctSound play];
		
		[self.countdownTimer invalidate];
		
		self.totalCorrectAnswer += 1;
		
		// clear all subviews added.
		for (UIView *aView in [self.popupView subviews]) 
		{
			[aView removeFromSuperview];
		}
		
		UILabel *label = [[UILabel alloc] initWithFrame:self.popupView.frame];
		label.text = @"Correct!";
		label.font = [UIFont systemFontOfSize:50];
		[label sizeToFit];
		
		label.center = [self.view convertPoint:self.popupView.center toView:self.popupView];
		
		[self.popupView addSubview:label];
		[label release];

		
		[self.popupView setHidden:NO];
		
		self.totalScore += kCorrectAnswerScore;
		self.score.text = [NSString stringWithFormat:@"%d", self.totalScore];
		[self performSelector:@selector(nextQuestion) withObject:nil afterDelay:kDelay];
	}
}

- (void)wrongAnswer {
	
	if ([self.countdownTimer isValid]) 
	{
		[incorrectSound play];
		
		[self.countdownTimer invalidate];
		
		// clear all subviews added.
		for (UIView *aView in [self.popupView subviews]) 
		{
			[aView removeFromSuperview];
		}
		
		UITextView *textView = [[UITextView alloc] initWithFrame:self.popupView.frame];
		textView.editable = NO;
		textView.text = [NSString stringWithFormat:@"Incorrect!\nThe correct answer is:\n%@", self.rightAnswer];
		textView.font = [UIFont systemFontOfSize:30];
		textView.textAlignment = UITextAlignmentCenter;
		
		textView.center = [self.view convertPoint:self.popupView.center toView:self.popupView];
		
		[self.popupView addSubview:textView];
		[textView release];
		
		[self.popupView setHidden:NO];
		
		self.totalScore -= kWrongAnswerScore;

		self.score.text = [NSString stringWithFormat:@"%d", self.totalScore];
		[self performSelector:@selector(nextQuestion) withObject:nil afterDelay:kDelay];
	}
}

- (void)startTimer:(int)initialTime {
	self.time = initialTime;
	self.countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 
														   target:self													  
														 selector:@selector(countdown)
														 userInfo:nil 
														  repeats:YES];
}

- (void)startTimer {
	self.countdownTime.text = [NSString stringWithFormat:@"0:%02d", self.timer];
	[self startTimer:self.timer];
}

- (void)countdown {
	self.time -= 1;
	
	// timeout.
	if (0 == self.time) 
	{
		NSLog(@"timeout");
		[self wrongAnswer];
		self.countdownTime.text = [NSString stringWithFormat:@"0:%02d", self.time];
	}
	else
	{		
		self.countdownTime.text = [NSString stringWithFormat:@"0:%02d", self.time];
	}
}

- (void)cleanUp {
	
	/*
	 * Clear all objects on screen
	 */
	
	self.continueButtonView.hidden = YES;
	self.popupView.hidden = YES;
	self.countdownTime.text = [NSString stringWithFormat:@"0:%d", self.time];

//	self.questionImageView.image = nil;
	
	for (UIView *subview in [self.choicesView subviews]) 
	{
//		if (subview.tag == kLevelIndicatorViewID ) 
//		{
//			[subview removeFromSuperview];
//		}
		[subview removeFromSuperview];
	}
	
//	if (0 != [self.choicesView count]) 
//	{
//		for (UILabel *_aView in self.choicesView) 
//		{
//			[_aView removeFromSuperview];
//		}
//		[self.choicesView removeAllObjects];
//	}
	
//	if (0 != [self.pictureViews	count]) 
//	{
//		for (UIView * _aView in self.pictureViews) 
//		{
//			[_aView removeFromSuperview];
//		}
//		[self.pictureViews removeAllObjects];
//	}
	
}

- (IBAction)playAgain:(id)sender 
{				
	[self cleanUp];
	
	self.score.text = @"0";
	
	if ([self.countdownTimer isValid]) 
	{
		[self.countdownTimer invalidate];
	}
	
	
	self.currentQuestionNo = 1;
	self.totalScore = 0;
	
	[[self.view viewWithTag:503] removeFromSuperview];
	
	[self loadQuestion:self.currentQuestionNo];
	
	[self startTimer];
}

- (void)toBookMenu 
{
	[[self navigationController] popToRootViewControllerAnimated:YES];
}


@end

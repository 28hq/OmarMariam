//
//  QuizViewController.h
//  OmarMariam
//
//  Created by A.L.L.Y.K. on 10/31/10.
//  Copyright 2010 Brainstorm Technologies Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface QuizViewController : UIViewController {
	int bookNumber;
	int countQuestions;
	int currentQuestionNo;
	int totalScore;
	int totalCorrectAnswer;
	
	NSMutableDictionary *theData;
	UIImage				*gameNumberImage;
	NSString			*rightAnswer;
	
	// Countdown.
	NSTimer *countdownTimer;
	NSInteger time;
	NSInteger timer;
	
	// IBOutlet
	UIView *cover, *game, *end;
	UIView *continueButtonView, *choicesView;
	UILabel *questionLabel;
	UIImageView *levelImageView, *gameNumber, *gameNumber2, *questionImageView;
}

@property (assign) int bookNumber;
@property (assign) int countQuestions;
@property (assign) int currentQuestionNo;
@property (assign) int totalScore;
@property (assign) int totalCorrectAnswer;

@property (retain) UIImage		*gameNumberImage;
@property (retain) NSDictionary	*theData;
@property (retain) NSTimer		*countdownTimer;
@property (retain) NSString		*rightAnswer;
@property (assign) NSInteger	time;
@property (assign) NSInteger	timer;

// IBOutlet
@property (nonatomic, retain) IBOutlet UIView *cover, *game, *end;
@property (nonatomic, retain) IBOutlet UIView *continueButtonView, *choicesView;
@property (nonatomic, retain) IBOutlet UILabel *questionLabel;
@property (nonatomic, retain) IBOutlet UIImageView *levelImageView, *gameNumber, 
	*gameNumber2, *questionImageView;

@property (retain) IBOutlet UITextField *countdownTime;
@property (retain) IBOutlet UITextField *score;
@property (retain) IBOutlet UIView		*popupView;

// final Outlets
@property (retain) IBOutlet UILabel		*finalScore;
@property (retain) IBOutlet UILabel		*finalTotalCorrectAnswers;
@property (retain) IBOutlet UILabel		*finalTotalWrongAnswers;
@property (retain) IBOutlet UILabel		*finalPercentage;
@property (retain) IBOutlet UILabel		*finalPercentageRequiredToPass;
@property (retain) IBOutlet UILabel		*finalStatus;



- (void)loadQuestion:(int)no;
- (void)correctAnswer;
- (void)wrongAnswer;
- (void)startTimer;
- (void)startTimer:(int)initialTime;
- (void)nextQuestion;
- (void)cleanUp;
- (void)toBookMenu;

// IBAction
- (IBAction)startGame:(id)sender;
- (IBAction)playAgain:(id)sender;

@end

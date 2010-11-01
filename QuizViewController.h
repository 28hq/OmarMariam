//
//  QuizViewController.h
//  OmarMariam
//
//  Created by A.L.L.Y.K. on 10/31/10.
//  Copyright 2010 Brainstorm Technologies Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface QuizViewController : UIViewController {

	int countQuestions;
	UIImage *gameNumberImage;
	NSArray *theData;
	
	// IBOutlet
	UIView *cover, *game, *end;
	UIView *continueButtonView, *choicesView;
	UILabel *questionLabel;
	UIImageView *levelImageView, *gameNumber, *gameNumber2, *questionImageView;
	UIButton *choice1, *choice2, *choice3;
}

@property (nonatomic) int countQuestions;
@property (nonatomic, retain) UIImage *gameNumberImage;
@property (nonatomic, retain) NSArray *theData;

// IBOutlet
@property (nonatomic, retain) IBOutlet UIView *cover, *game, *end;
@property (nonatomic, retain) IBOutlet UIView *continueButtonView, *choicesView;
@property (nonatomic, retain) IBOutlet UILabel *questionLabel;
@property (nonatomic, retain) IBOutlet UIImageView *levelImageView, *gameNumber, 
	*gameNumber2, *questionImageView;
@property (nonatomic, retain) IBOutlet UIButton *choice1, *choice2, *choice3;



- (void)loadQuestion:(int)no;
- (void)correctAnswer:(id)sender;
// IBAction
- (IBAction)startGame:(id)sender;

@end

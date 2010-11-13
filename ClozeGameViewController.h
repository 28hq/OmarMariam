//
//  ClozeGameViewController.h
//  OmarMariam
//
//  Created by A.L.L.Y.K. on 10/25/10.
//  Copyright 2010 Brainstorm Technologies Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ClozeGameViewController : UIViewController {
	NSMutableArray * labelViews;
	NSMutableArray * dropViews;
	NSMutableArray * sentenceViews;
	NSArray * theData;
	UIImage * gameNumberImage;
	int bookNumber;
	int questionLeft;
	int isAtLevel;
	int totalLevel;
	
	// IBOutlet
	UIView * cover, * game, *end;
	UIView * wordListView, * levelIndicator, * continueButtonView;
	UIButton * continueButton;
	UIImageView *levelImageView, *levelImageView2, *gameNumber, *gameNumber2;
}

@property (nonatomic, retain) NSArray *theData;
@property (nonatomic, retain) NSMutableArray *labelViews;
@property (nonatomic, retain) NSMutableArray *dropViews, *sentenceViews;
@property (nonatomic, retain) UIImage *gameNumberImage;

@property int questionLeft, isAtLevel, totalLevel, bookNumber;

@property (nonatomic, retain) IBOutlet UIView *wordListView, *levelIndicator, *continueButtonView;
@property (nonatomic, retain) IBOutlet UIView *cover, *game, *end;
@property (nonatomic, retain) IBOutlet UIButton *continueButton;
@property (nonatomic, retain) IBOutlet UIImageView *levelImageView, *levelImageView2, *gameNumber, *gameNumber2;

- (void)startGame:(id)sender;
- (UIImage *)getImage:(NSString *)imageName;
- (BOOL)noQuestionLeft;
- (void)nextLevel;
- (void)levelSelector:(int)level;
- (void)createLevelIndicator;
- (IBAction)playAgainButton:(id)sender;

@end

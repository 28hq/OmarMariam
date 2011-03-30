//
//  LabelViewController.h
//  OmarMariam
//
//  Created by A.L.L.Y.K. on 10/20/10.
//  Copyright 2010 Brainstorm Technologies Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@class LabelView;

@interface LabelViewController : UIViewController <UIScrollViewDelegate> {
	NSMutableArray * imageViews;
	NSMutableArray * labelViews;
	NSMutableArray * dropViews;
	
	NSArray * imagesPath;
	
	LabelView * labelView;
	NSArray *_volume1, *_theData;
	int questionLeft;
	int isAtLevel;
	int totalLevel;
	int bookNumber;
	
	// IBOutlet
	UIView * wordListView, * levelIndicator, * continueButtonView;
	UIButton * continueButton;
	UIImageView * gameNumber;
	UIScrollView *wordListScrollView;
}

@property (nonatomic, retain) NSMutableArray *imageViews;
@property (nonatomic, retain) NSMutableArray *labelViews;
@property (nonatomic, retain) NSMutableArray *dropViews;

@property (nonatomic, retain) NSArray *imagesPath;
@property (nonatomic, retain) NSArray *_volume1, *_theData;
@property int questionLeft, isAtLevel, totalLevel, bookNumber;

@property (nonatomic, retain) LabelView *labelView;

@property (nonatomic, retain) IBOutlet UIView *wordListView, *levelIndicator;
@property (nonatomic, retain) IBOutlet UIView *continueButtonView;
@property (nonatomic, retain) IBOutlet UIButton *continueButton;
@property (nonatomic, retain) IBOutlet UIImageView *gameNumber;
@property (nonatomic, retain) IBOutlet UIScrollView *wordListScrollView;

@property (nonatomic, retain) IBOutlet UIView *cover;
@property (nonatomic, retain) IBOutlet UIView *game;
@property (nonatomic, retain) IBOutlet UIView *end;

- (void)levelSelector:(int)level;
- (BOOL)noQuestionLeft;
- (void)nextLevel;
- (void)createLevelIndicator;
- (void)toBookMenu;
- (void)playCompletedLevel;

- (IBAction)startGameAtLevel:(id)sender;
- (IBAction)playAgain:(id)sender;
- (IBAction)backButton:(id)sender;

@end
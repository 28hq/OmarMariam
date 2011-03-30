//
//  LineGameViewController.h
//  OmarMariam
//
//  Created by A.L.L.Y.K. on 10/5/10.
//  Copyright 2010 Brainstorm Technologies Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface LineGameViewController : UIViewController <AVAudioPlayerDelegate> {
	NSMutableArray *wordViews;
	NSMutableArray *pictureViews;

	AVAudioPlayer *soundPlay;
	NSArray * theData;
	UIImage * gameNumberImage;
	int questionLeft;
	int isAtLevel;
	int totalLevel;
	int bookNumber;
	
	// IBOutlet
	UIView *cover, *game, *end;
	UIView *levelIndicator;
	UIView *wordView, *pictureView;
	UIButton *continueButton;
	UIImageView *levelImageView, *levelImageView2, *gameNumber, *gameNumber2;

}

@property (nonatomic, retain) NSMutableArray	*wordViews;
@property (nonatomic, retain) NSMutableArray	*pictureViews;
@property (nonatomic, retain) UIImage			*gameNumberImage;
@property (nonatomic, retain) NSArray			*theData;
@property int questionLeft, isAtLevel, totalLevel, bookNumber;

// IBOutlet
@property (nonatomic, retain) IBOutlet UIView		*cover, *game, *end;
@property (nonatomic, retain) IBOutlet UIView		*levelIndicator;
@property (nonatomic, retain) IBOutlet UIView		*wordView, *pictureView;
@property (nonatomic, retain) IBOutlet UIButton		*continueButton;
@property (nonatomic, retain) IBOutlet UIImageView *levelImageView, *levelImageView2, *gameNumber, *gameNumber2;


- (IBAction)startGame:(id)sender;
- (IBAction)playAgain:(id)sender;
- (void)levelSelector:(int)level;
- (void)createLevelIndicator;
- (void)checkLevelCompletion;
- (void)continueToNextLevel;
- (void)cleanUp;
- (void)playCompletedLevel;

@end

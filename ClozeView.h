//
//  ClozeView.h
//  OmarMariam
//
//  Created by A.L.L.Y.K. on 10/26/10.
//  Copyright 2010 Brainstorm Technologies Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#import "ClozeGameViewController.h"

@interface ClozeView : UIView <AVAudioPlayerDelegate> {
	ClozeGameViewController *viewController;
	UIImageView *activeImageView;
	UILabel *activeLabel;
	CGPoint hitPoint;
	
	UIView * gameview;
	NSString * pathToMusicFile;
	AVAudioPlayer * soundPlay;
}

@property (nonatomic, retain) IBOutlet ClozeGameViewController *viewController;
@property (nonatomic, retain) IBOutlet UIView * gameview;

@property (nonatomic, retain) UIImageView *activeImageView;
@property (nonatomic, retain) UILabel *activeLabel;
@property (nonatomic, retain) NSString * pathToMusicFile;
@property (nonatomic, retain) AVAudioPlayer * soundPlay;

@property CGPoint hitPoint;

@end

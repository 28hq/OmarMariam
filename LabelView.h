//
//  LabelView.h
//  OmarMariam
//
//  Created by A.L.L.Y.K. on 10/20/10.
//  Copyright 2010 Brainstorm Technologies Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#import "LabelViewController.h"

@interface LabelView : UIView <AVAudioPlayerDelegate> {
	LabelViewController *viewController;
	UIImageView *activeImageView;
	UILabel *activeLabel;
	CGPoint hitPoint;
	
	UIView * superView;
	NSString * pathToMusicFile;
	AVAudioPlayer * soundPlay;
}

@property (nonatomic, retain) IBOutlet LabelViewController *viewController;
@property (nonatomic, retain) IBOutlet UIView * superView;

@property (nonatomic, retain) UIImageView *activeImageView;
@property (nonatomic, retain) UILabel *activeLabel;
@property (nonatomic, retain) NSString * pathToMusicFile;
@property (nonatomic, retain) AVAudioPlayer * soundPlay;

@property CGPoint hitPoint;

@end

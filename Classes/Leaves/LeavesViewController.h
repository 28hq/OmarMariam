//
//  LeavesViewController.h
//  Leaves
//
//  Created by Tom Brow on 4/18/10.
//  Copyright Tom Brow 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "LeavesView.h"

@interface LeavesViewController : UIViewController <LeavesViewDataSource, LeavesViewDelegate> {
	LeavesView *leavesView;
	AVAudioPlayer *audioPlayer;
}

@property (retain) IBOutlet LeavesView *leavesView;

@end


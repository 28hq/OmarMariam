//
//  GamesViewController.h
//  OmarMariam
//
//  Created by A.L.L.Y.K. on 11/10/10.
//  Copyright 2010 Brainstorm Technologies Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GamesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	int bookNumber;
	NSArray *bookContents;
}

@property (assign) int		bookNumber;
@property (retain) NSArray	*bookContents;

// IBOutlets
@property (retain) IBOutlet UIImageView				*bookCoverImage;
@property (retain) IBOutlet UIButton				*bookButton;


// IBActions
- (IBAction)exitToMenu:(id)sender;

@end

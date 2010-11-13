//
//  GamesViewController.h
//  OmarMariam
//
//  Created by A.L.L.Y.K. on 11/10/10.
//  Copyright 2010 Brainstorm Technologies Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GamesViewController : UIViewController {
	int bookNumber;
}

@property (assign) int	bookNumber;

// IBOutlets
@property (retain) IBOutlet UIImageView	*bookCoverImage;
@property (retain) IBOutlet UIButton	*bookButton;

//@property (retain) IBOutlet UIButton	*labelGameButton;
//@property (retain) IBOutlet UIButton	*lineGameButton;
//@property (retain) IBOutlet UIButton	*clozeGameButton;
//@property (retain) IBOutlet UIButton	*quizGameButton;

// IBActions

- (IBAction)bookGame:(id)sender;
- (IBAction)labelGameButton:(id)sender;
- (IBAction)lineGameButton:(id)sender;
- (IBAction)clozeGameButton:(id)sender;
- (IBAction)quizGameButton:(id)sender;
- (IBAction)exitToMenu:(id)sender;

@end

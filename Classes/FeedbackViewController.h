//
//  FeedbackViewController.h
//  Crystal
//
//  Created by Guillaume on 14/09/12.
//  Copyright (c) 2012 Guillaume Cendre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface FeedbackViewController : UIViewController <MFMailComposeViewControllerDelegate>


@property (retain, nonatomic) IBOutlet MFMailComposeViewController* picker;

- (IBAction)mailto:(id)sender;

@end

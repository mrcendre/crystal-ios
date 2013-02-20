//
//  BrowserViewController.h
//  Crystal
//
//  Created by Guillaume on 26/08/12.
//  Copyright (c) 2012 Guillaume Cendre. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrowserViewController : UIViewController <UITextFieldDelegate, UIWebViewDelegate, UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIView *barView;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndictator;
@property (weak, nonatomic) IBOutlet UIView *darkOverlay;
@property (weak, nonatomic) IBOutlet UIButton *overlayButton;

@property (weak, nonatomic) IBOutlet UIView *header;

@property (weak, nonatomic) IBOutlet UIButton *reloadButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;

@property (weak, nonatomic) IBOutlet UIButton *forwardButton;

- (IBAction)viewMiddle:(id)sender;
- (IBAction)viewDown:(id)sender;
- (IBAction)launchWeb:(id)sender;
- (IBAction)reloadPressed:(id)sender;
- (IBAction)stopPressed:(id)sender;

- (IBAction)dismissHead:(id)sender;
- (IBAction)showHeader:(id)sender;

@end

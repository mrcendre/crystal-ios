//
//  TutorialViewController.h
//  Crystal
//
//  Created by Guillaume on 13/09/12.
//  Copyright (c) 2012 Guillaume Cendre. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TutorialViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *acText;
@property (weak, nonatomic) IBOutlet UITextView *homeText;

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIImageView *voiceImage;
@property (weak, nonatomic) IBOutlet UIImageView *acImage;
@property (weak, nonatomic) IBOutlet UITextView *arrowtext;
@property (weak, nonatomic) IBOutlet UIImageView *homeImage;
@property (weak, nonatomic) IBOutlet UITextView *voicetext;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;

@end

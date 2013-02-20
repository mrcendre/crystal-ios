//
//  BackgroundViewController.h
//  Crystal
//
//  Created by Guillaume on 13/09/12.
//  Copyright (c) 2012 Guillaume Cendre. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BackgroundViewController : UIViewController

- (IBAction)graySelected:(id)sender;
- (IBAction)whiteSelected:(id)sender;
- (IBAction)blackSelected:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;

@property (weak, nonatomic) IBOutlet UIImageView *whiteImage;
@property (weak, nonatomic) IBOutlet UIImageView *grayImage;
@property (weak, nonatomic) IBOutlet UIImageView *blackImage;
@end

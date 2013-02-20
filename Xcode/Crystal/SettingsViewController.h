//
//  SettingsViewController.h
//  Crystal
//
//  Created by Guillaume on 02/09/12.
//  Copyright (c) 2012 Guillaume Cendre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface SettingsViewController : UIViewController <ADBannerViewDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *blu;
@property (weak, nonatomic) IBOutlet UIButton *red;
@property (weak, nonatomic) IBOutlet UIButton *green;
@property (weak, nonatomic) IBOutlet UIButton *gray;

@property (weak, nonatomic) IBOutlet ADBannerView* banner;

- (IBAction)rate:(id)sender;
-(IBAction)blueAction:(id)sender;
- (IBAction)redAction:(id)sender;
- (IBAction)greenAction:(id)sender;
- (IBAction)grayAction:(id)sender;

@end

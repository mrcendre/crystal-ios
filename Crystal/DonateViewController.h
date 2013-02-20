//
//  DonateViewController.h
//  Crystal
//
//  Created by Guillaume on 28/08/12.
//  Copyright (c) 2012 Guillaume Cendre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface DonateViewController : UIViewController <ADBannerViewDelegate, UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *paypalText;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;

@property (weak, nonatomic) IBOutlet UIButton *webView;
@property (weak, nonatomic) IBOutlet ADBannerView *banner;
@property (weak, nonatomic) IBOutlet UILabel *explicativeText;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *load;
@property (weak, nonatomic) IBOutlet UILabel *loadingLabel;

@end

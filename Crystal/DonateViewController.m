//
//  DonateViewController.m
//  Crystal
//
//  Created by Guillaume on 28/08/12.
//  Copyright (c) 2012 Guillaume Cendre. All rights reserved.
//

#import "DonateViewController.h"

@interface DonateViewController ()

@end

@implementation DonateViewController
@synthesize paypalText;
@synthesize scroll;
@synthesize webView, load;
@synthesize explicativeText;
@synthesize loadingLabel;


-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    
    [_banner setHidden:YES];
    [explicativeText setHidden:NO];
    [load setHidden:YES];
    [loadingLabel setHidden:YES];
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    [_banner setHidden:YES];
    [explicativeText setHidden:YES];
    [load setHidden:NO];
  [loadingLabel setHidden:NO];
    
    _banner.delegate = self;
}

-(void)bannerViewDidLoadAd:(ADBannerView *)banner {
    [_banner setHidden:NO];
    [explicativeText setHidden:YES];
    [load setHidden:YES];
    [loadingLabel setHidden:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [paypalText setFrame:CGRectMake((320+41), 30, 238, 150)];
    [scroll setContentSize:CGSizeMake((scroll.frame.size.width*2), scroll.frame.size.height)];
    
    [webView setFrame:CGRectMake(320, 200, 320, 84)];
    [scroll setPagingEnabled:YES];
    [scroll setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setWebView:nil];
    [self setBanner:nil];
    [self setExplicativeText:nil];
    [self setLoad:nil];
    [self setLoadingLabel:nil];
    [self setPaypalText:nil];
    [self setScroll:nil];
    [super viewDidUnload];
}
@end

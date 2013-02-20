//
//  PayPalViewController.m
//  Crystal
//
//  Created by Guillaume on 15/09/12.
//  Copyright (c) 2012 Guillaume Cendre. All rights reserved.
//

#import "PayPalViewController.h"

@interface PayPalViewController ()

@end

@implementation PayPalViewController
@synthesize webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://guillaumecendre.alwaysdata.net/apps/crystal/ios/donate/en_US.html"]]];
    [webView setOpaque:NO];
    if ([[webView subviews] count] > 0) {
     // hide the shadows
     for (UIView* shadowView in [[[webView subviews] objectAtIndex:0] subviews]) {
     [shadowView setHidden:YES];
     }
     // show the content
     [[[[[webView subviews] objectAtIndex:0] subviews] lastObject] setHidden:NO];
     }
    
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setWebView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

//
//  TutorialViewController.m
//  Crystal
//
//  Created by Guillaume on 13/09/12.
//  Copyright (c) 2012 Guillaume Cendre. All rights reserved.
//

#import "TutorialViewController.h"

@interface TutorialViewController ()

@end

@implementation TutorialViewController
@synthesize scroll, acImage, acText;
@synthesize homeText, homeImage, voiceImage;
@synthesize backButton, voicetext, arrowtext;



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [scroll setPagingEnabled:YES];
    
    [scroll setContentSize:CGSizeMake((320*4), 480)];
    [homeImage setFrame:CGRectMake(44, (480-233), (320-100), 233)];
    [acImage setFrame:CGRectMake((320+50), (480-233), (320-100), 233)];
    [voiceImage setFrame:CGRectMake((640+50), (480-233), (320-100), 233)];
    
    [voicetext setFrame:CGRectMake((640+30), 80, 260, 185)];
    [homeText setFrame:CGRectMake(30, 80, 260, 185)];
    [acText setFrame:CGRectMake((320+30), 80, 260, 185)];
    [arrowtext setFrame:CGRectMake((320+640+30), 80, 260, 185)];
    
    [backButton setFrame:CGRectMake((320*3), 0, 55, 55)];
    
    [scroll setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setAcText:nil];
    [self setVoiceImage:nil];
    [self setAcImage:nil];
    [self setHomeImage:nil];
    [self setHomeText:nil];
    [self setBackButton:nil];
    [self setScroll:nil];
    [self setBackButton:nil];
    [self setVoicetext:nil];
    [self setArrowtext:nil];
    [super viewDidUnload];
}
@end

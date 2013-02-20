//
//  StartViewController.m
//  Crystal
//
//  Created by Guillaume on 25/08/12.
//  Copyright (c) 2012 Guillaume Cendre. All rights reserved.
//

#import "StartViewController.h"

@interface StartViewController ()

@end

@implementation StartViewController
@synthesize pic;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [NSTimer scheduledTimerWithTimeInterval:4.5 target:self selector:@selector(start:) userInfo:nil repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(fadeout:) userInfo:nil repeats:NO];
    
	// Do any additional setup after loading the view.
}

-(void)start:(id)sender {
    
    [self performSegueWithIdentifier:@"start" sender:self];
    
}


-(void)fadeout:(id)sender {
    
    [UIView beginAnimations: @"Fade Out" context:NULL];
    [UIView setAnimationDuration:0.9];
    pic.transform = CGAffineTransformMakeScale(.70, .70);
    pic.alpha = 0.0;
    [UIView commitAnimations];
    
}




- (void)viewDidUnload
{
    [self setPic:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

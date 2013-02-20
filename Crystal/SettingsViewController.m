//
//  SettingsViewController.m
//  Crystal
//
//  Created by Guillaume on 02/09/12.
//  Copyright (c) 2012 Guillaume Cendre. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController
@synthesize banner;
@synthesize blu, red, green, gray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    [banner setHidden:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [banner setHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)switchAccentedColorTo: (NSString *)color {
    
    NSMutableArray* temp = [[NSMutableArray alloc] initWithObjects:color, nil];
    
    [temp writeToFile:@"infos.plist" atomically:NO];
    
}

- (IBAction)rate:(id)sender {
    
    UIAlertView* alerte = [[UIAlertView alloc] initWithTitle:@"Rate the application" message:@"You are going to be redirected to the App Store application. Do you want to continue ?" delegate:self cancelButtonTitle:@"No, stay on Crystal" otherButtonTitles:@"Yes, App Store !", nil];
    [alerte show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 1:
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/us/app/crystal./id562518806&mt=8"]];
            
            break;default:
            break;}
}

- (void)viewDidUnload {
    [self setBlu:nil];
    [self setRed:nil];
    [self setGreen:nil];
    [self setGray:nil];
    [super viewDidUnload];
}
- (IBAction)redAction:(id)sender {
    
    [blu setBackgroundImage:nil forState:UIControlStateNormal];
    [green setBackgroundImage:nil forState:UIControlStateNormal];
    [gray setBackgroundImage:nil forState:UIControlStateNormal];
    [red setBackgroundImage:[UIImage imageNamed:@"ssquare.png"] forState:UIControlStateNormal];
    [self switchAccentedColorTo:@"red"];
}

- (IBAction)greenAction:(id)sender {
    [red setBackgroundImage:nil forState:UIControlStateNormal];
    [blu setBackgroundImage:nil forState:UIControlStateNormal];
    [gray setBackgroundImage:nil forState:UIControlStateNormal];
    [green setBackgroundImage:[UIImage imageNamed:@"ssquare.png"] forState:UIControlStateNormal];
    [self switchAccentedColorTo:@"green"];
}

- (IBAction)grayAction:(id)sender {
    [blu setBackgroundImage:nil forState:UIControlStateNormal];
    [green setBackgroundImage:nil forState:UIControlStateNormal];
    [red setBackgroundImage:nil forState:UIControlStateNormal];
    [gray setBackgroundImage:[UIImage imageNamed:@"ssquare.png"] forState:UIControlStateNormal];
    [self switchAccentedColorTo:@"gray"];
}


-(IBAction)blueAction:(id)sender{
    [red setBackgroundImage:nil forState:UIControlStateNormal];
    [green setBackgroundImage:nil forState:UIControlStateNormal];
    [gray setBackgroundImage:nil forState:UIControlStateNormal];
    [blu setBackgroundImage:[UIImage imageNamed:@"ssquare.png"] forState:UIControlStateNormal];
    [self switchAccentedColorTo:@"blue"];
}
@end

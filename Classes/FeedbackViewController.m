//
//  FeedbackViewController.m
//  Crystal
//
//  Created by Guillaume on 14/09/12.
//  Copyright (c) 2012 Guillaume Cendre. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()

@end

@implementation FeedbackViewController
@synthesize picker;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self setPicker:nil];
    // Release any retained subviews of the main view.
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    [self dismissModalViewControllerAnimated:YES];
    
}

-(void)launchMailOnAppDevice{
    NSString *recipients = @"mailto:crystal-feedback@live.fr?&subject=Crystal on iOS";
	
	NSString *email = [NSString stringWithFormat:@"%@", recipients];
	email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}

-(void)displayComposerSheet {
    
    picker = [[MFMailComposeViewController alloc] init];
    [picker.navigationItem setTitle:@""];
    [picker.navigationBar setTintColor:[UIColor lightGrayColor]];
    [picker setMailComposeDelegate:self];
    
    [picker setSubject:@"Crystal on iOS"];
    [picker setToRecipients:[NSArray arrayWithObject:@"crystal-feedback@live.fr"]];
    
    [self presentModalViewController:picker animated:YES];
}


- (IBAction)mailto:(id)sender {
    
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (mailClass != nil){
    if ([mailClass canSendMail])
    {
        [self displayComposerSheet];
    }
    else {[self launchMailOnAppDevice];}
    }
    else
    {
        [self launchMailOnAppDevice];
    }
    
}
@end

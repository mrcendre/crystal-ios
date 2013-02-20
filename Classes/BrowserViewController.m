//
//  BrowserViewController.m
//  Crystal
//
//  Created by Guillaume on 26/08/12.
//  Copyright (c) 2012 Guillaume Cendre. All rights reserved.
//

#import "BrowserViewController.h"

@interface BrowserViewController ()

@end

@implementation BrowserViewController
@synthesize webView;
@synthesize barView;
@synthesize urlTextField;
@synthesize activityIndictator;
@synthesize darkOverlay, overlayButton;
@synthesize reloadButton, forwardButton;
@synthesize stopButton, header;

NSString *request;
NSArray *infos;
NSURL* url;

int refreshTimes;
bool didTest;

bool isHeaderVisible;

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error 
{
    if (refreshTimes > 5) {
        NSString *pathNoNetwork = [[NSBundle mainBundle] pathForResource:@"network" ofType:@"html"];
        NSFileHandle *readHandleNoNetwork = [NSFileHandle fileHandleForReadingAtPath:pathNoNetwork];
        NSString *htmlStringNoNetwork = [[NSString alloc] initWithData:
                                         [readHandleNoNetwork readDataToEndOfFile] encoding:NSUTF8StringEncoding];
        [self.webView loadHTMLString:htmlStringNoNetwork baseURL:nil];
        [self.webView setUserInteractionEnabled:NO];
    }
    else {[self retestConnection];}

    }

-(void)retestConnection {[self.webView reload];didTest = YES;refreshTimes++;}

-(void)goForwad {
    [webView goForward];
}
    
- (void)viewDidLoad
{
    [super viewDidLoad];
    [forwardButton addTarget:self action:@selector(goForwad) forControlEvents:UIControlEventTouchUpInside];
    isHeaderVisible = YES;
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"home" ofType:@"html"]isDirectory:NO]]];
    
    [overlayButton addTarget:self action:@selector(viewDown:) forControlEvents:UIControlEventTouchUpInside];
    
    UISwipeGestureRecognizer *downscrollDetector = [[UISwipeGestureRecognizer alloc] initWithTarget:self  action:@selector(dismissHead:)];
    downscrollDetector.direction = UISwipeGestureRecognizerDirectionUp;
    downscrollDetector.delegate = self;
    [webView.scrollView addGestureRecognizer:downscrollDetector];
    
    UISwipeGestureRecognizer *upscrollDetector = [[UISwipeGestureRecognizer alloc] initWithTarget:self  action:@selector(showHeader:)];
    upscrollDetector.direction = UISwipeGestureRecognizerDirectionDown;
    upscrollDetector.delegate = self;
    [webView.scrollView addGestureRecognizer:upscrollDetector];
    
    [webView setFrame:CGRectMake(0, 65, 320, 363)];
    
    [barView setFrame:CGRectMake(0, 428, 320, 52)];
    [stopButton setHidden:YES];
    [stopButton setEnabled:NO];
    [darkOverlay setAlpha:0];
    [activityIndictator setHidesWhenStopped:NO];
    
    urlTextField.placeholder = @"google.com/";
    urlTextField.frame = CGRectMake(50, 12, 164, 30.5);
    
    if ([[webView subviews] count] > 0) {
        // hide the shadows
        for (UIView* shadowView in [[[webView subviews] objectAtIndex:0] subviews]) {
            [shadowView setHidden:YES];
        }
        // show the content
        [[[[[webView subviews] objectAtIndex:0] subviews] lastObject] setHidden:NO];
    }
    
    
    NSString *infosPlistPath = [[NSBundle mainBundle] pathForResource:@"infos" ofType:@"plist"];
    NSMutableArray* infosMA = [[NSMutableArray alloc] initWithContentsOfFile:infosPlistPath];
    infos = [[NSArray alloc] initWithArray:infosMA];
    
    request = @"http://www.google.com/";
    
    url =[NSURL URLWithString:[NSString stringWithFormat:@"%@", request]];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
}


- (void)viewDidUnload {
    [self setWebView:nil];
    [self setUrlTextField:nil];
    [self setBarView:nil];
    [self setReloadButton:nil];
    [self setStopButton:nil];
    [self setActivityIndictator:nil];
    [self setDarkOverlay:nil];
    [self setHeader:nil];
    [self setOverlayButton:nil];
    [self setForwardButton:nil];
    [super viewDidUnload];
}
-(void)webViewDidStartLoad:(UIWebView *)webView {
    
    [activityIndictator startAnimating];
    [activityIndictator setHidden:NO];
    [reloadButton setHidden:YES];
    [reloadButton setEnabled:NO];
    [stopButton setHidden:NO];
    [stopButton setEnabled:YES];
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [UIView beginAnimations:@"finishLoad" context:NULL];
    [UIView setAnimationDuration:0.2];
    activityIndictator.alpha = 0;
    [UIView commitAnimations];
    [stopButton setHidden:YES];
    [stopButton setEnabled:NO];
    [reloadButton setHidden:NO];
    [reloadButton setEnabled:YES];
    
}

-(IBAction)reloadPressed:(id)sender {
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(reloadWeb:) userInfo:nil repeats:NO];
    [activityIndictator startAnimating];
    [activityIndictator setHidden:NO];
    [reloadButton setHidden:YES];
    [stopButton setHidden:NO];
}


- (void)stopPressed:(id)sender {
    
    [stopButton setHidden:YES];
    [stopButton setEnabled:NO];
    [reloadButton setHidden:NO];
    [reloadButton setEnabled:YES];
    [webView stopLoading];
    
    [activityIndictator setHidesWhenStopped:YES];
    [activityIndictator stopAnimating];
    [activityIndictator setHidden:NO];
    
}

- (IBAction)dismissHead:(id)sender {
    if (isHeaderVisible == YES) {
        
        [UIView beginAnimations:@"dismissingHeader" context:NULL];
        [UIView setAnimationDuration:0.3];
        header.transform = CGAffineTransformMakeTranslation(0, -65);
        webView.frame = CGRectMake(0, 0, 320, 428);
        [UIView commitAnimations];
        isHeaderVisible = NO;
    }
}
- (IBAction)showHeader:(id)sender {
    if (isHeaderVisible == NO) {
        
        [UIView beginAnimations:@"showingHeader" context:NULL];
        [UIView setAnimationDuration:0.3];
        [webView setFrame:CGRectMake(0, 65, 320, 363)];
        header.transform = CGAffineTransformMakeTranslation(0, 0);
        [UIView commitAnimations];
        
        isHeaderVisible = YES;
    }
}

-(void)reloadWeb:(id)sender {[webView reload];}


-(void)launchWeb:(id)sender {
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@""]]];
    request = urlTextField.text;

    
    /**
     Looking for the request type; is it a search or an URL ?
     **/
    
    NSRange whiteSpaceRange = [request rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]];
    if (whiteSpaceRange.location != NSNotFound) {
        NSLog(@"Found whitespace");
    }
    
    if (![request hasSuffix:@"/"]) {
        
        NSLog(@"no slash slash");
        
    }
    
    
        if (whiteSpaceRange.location == NSNotFound) {
            
            if ([request hasSuffix:@".com"] || [request hasSuffix:@".net"] || [request hasSuffix:@".de"] || [request hasSuffix:@".fr"] || [request hasSuffix:@".co.uk"] || [request hasSuffix:@".org"] || [request hasSuffix:@".us"] || [request hasSuffix:@".tv"] || [request hasSuffix:@".gl"] || [request hasSuffix:@".ly"] || [request hasSuffix:@".mx"])
            {
                if([request hasPrefix:@"http://"] || [request hasPrefix:@"https://"]) {
                    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/", request]]]];}
                else if (![request hasPrefix:@"http://"] || ![request hasPrefix:@"https://"]){
                    
                    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@/", request]]]];
                    
                }
            }
            if ([request hasPrefix:@"http://"] || [request hasPrefix:@"https://"] || [request hasPrefix:@"ftp://"]) {
            
                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", request]]]];

            
            }
            else
            {
        
            [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@", request]]]];
            
        }
    }
    else {
        
        if ([request hasSuffix:@".com"] || [request hasSuffix:@".net"] || [request hasSuffix:@".de"] || [request hasSuffix:@".fr"] || [request hasSuffix:@".co.uk"] || [request hasSuffix:@".org"] || [request hasSuffix:@".us"] || [request hasSuffix:@".tv"] || [request hasSuffix:@".gl"] || [request hasSuffix:@".ly"] || [request hasSuffix:@".mx"])
        {
            if (whiteSpaceRange.location == NSNotFound) {
                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@/", request]]]];}
        }
    
        else /*if request contains space*/{
            if (whiteSpaceRange.location != NSNotFound) {

                NSString *finalRequest = [request stringByReplacingOccurrencesOfString:@" " withString: @"+"];
                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.google.com/search?q=%@&ie=UTF-8", finalRequest]]]];
                }
            }
            if (whiteSpaceRange.location == NSNotFound) {
                if ([request hasSuffix:@"/"]) {
                    if ([request hasPrefix:@"http://"] || [request hasPrefix:@"https://"]){
                        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", request]]]];

                    } else {
                     [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@", request]]]];
                    }
                    }
                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.google.com/search?q=%@&ie=UTF-8", request]]]];
            }
            
    }
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;}


- (IBAction)viewMiddle:(id)sender {
    
    [UIView beginAnimations:@"moveUpToolbarView" context:NULL];
    [UIView setAnimationDuration:0.25];
    barView.transform = CGAffineTransformMakeTranslation(0, -215);
    darkOverlay.alpha = 0.6;
    urlTextField.frame = CGRectMake(12.25, 12, 250, 30.5);
    [UIView commitAnimations];
    [forwardButton addTarget:self action:@selector(viewDown:) forControlEvents:UIControlEventTouchUpInside];
}


- (IBAction)viewDown:(id)sender {

    [UIView beginAnimations:@"moveDownToolbarView" context:NULL];
    [UIView setAnimationDuration:0.3];
    barView.transform = CGAffineTransformMakeTranslation(0, 0);
    urlTextField.frame = CGRectMake(50, 12, 164, 30.5);
    darkOverlay.alpha = 0;
    [UIView commitAnimations];
    [forwardButton addTarget:self action:@selector(goForwad) forControlEvents:UIControlEventTouchUpInside];
    [self launchWeb:self];
    [urlTextField endEditing:YES];

}

@end

//
//  HomeViewController.m
//  Crystal
//
//  Created by Guillaume on 25/08/12.
//  Copyright (c) 2012 Guillaume Cendre. All rights reserved.
//

#import "HomeViewController.h"
#import <OpenEars/PocketsphinxController.h> // Please note that unlike in previous versions of OpenEars, we now link the headers through the framework.
#import <OpenEars/FliteController.h>
#import <OpenEars/LanguageModelGenerator.h>
#import <OpenEars/OpenEarsLogging.h>
#import <OpenEars/OpenEarsEventsObserver.h>


@interface HomeViewController ()

@end


@implementation HomeViewController
@synthesize settingsLabel, settingsButton;
@synthesize aboutLabel, aboutButton;
@synthesize bookmarksLabel, browserLabel;
@synthesize bookmarksButton, browserButton;
@synthesize scroll, voiceView, uiUpdateTimer;
@synthesize voiceTitle, crystalTitle, requestField;
@synthesize speechSnipet, microphoneButton;
@synthesize pocketsphinxController, audioPlayer;
@synthesize pathToDictionaryToStartAppWith;
@synthesize pathToGrammarToStartAppWith;
@synthesize image, openEarseventsObserver;
@synthesize whatWouldYouLike, possibilitiesLabel;
@synthesize note, voiceTile, donateTile, donateButton;
@synthesize darkenView, dateLabel, batteryStatus;
@synthesize activity;

UIColor* lime;

bool isListening;
bool imgMoved;
bool launchedOnce;

NSMutableArray* colors;
NSMutableArray* backgroundColor;
NSString* infosPlistPath;
NSString* infosPlistPathTwo;

-(PocketsphinxController *)pocketsphinxController {
    if (pocketsphinxController == nil) {
        pocketsphinxController = [[PocketsphinxController alloc] init];
    }    return pocketsphinxController;}
-(OpenEarsEventsObserver *)openEarseventsObserver {
    if (openEarseventsObserver == nil) {
        openEarseventsObserver = [[OpenEarsEventsObserver alloc] init];
    }    return openEarseventsObserver;}


-(void)updateTime {
    NSDate * pDate = [[NSDate alloc] init];
    
    NSDateFormatter * pDateFormatter = [[NSDateFormatter alloc] init];
    [pDateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    [pDateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    // Transforme une NSDate en NSString
    NSString * pString = [pDateFormatter stringFromDate:pDate];
    dateLabel.text = pString;
}

-(void)updateBattery{
    
    UIDevice* device = [UIDevice currentDevice];
    device.batteryMonitoringEnabled = YES;
    
    float charge = device.batteryLevel;
    int bite = charge*100;
    NSString* vBatteryLevel = [NSString stringWithFormat:@"%d%%", bite];
    
    if (device.batteryState == UIDeviceBatteryStateUnplugged){
        
        batteryStatus.text = vBatteryLevel;
        batteryStatus.textColor = [UIColor greenColor];
        if (bite == 100) {
            batteryStatus.textColor = [UIColor greenColor];
        }
        if (bite < 70) {
            batteryStatus.textColor = [UIColor yellowColor];

            if (bite < 30){
            batteryStatus.textColor = [UIColor redColor];
             }}}
    
    
    if (device.batteryState == UIDeviceBatteryStateFull)
    {
        batteryStatus.text= @"Full battery.";
    }
    
    
    if (device.batteryState == UIDeviceBatteryStateCharging) {
        
        batteryStatus.text = vBatteryLevel;
        batteryStatus.textColor = [UIColor greenColor];
    
            if (bite < 70)
            {
            batteryStatus.textColor = [UIColor yellowColor];
            
                if (bite < 30)
                {
                batteryStatus.textColor = [UIColor redColor];
                }}
        
    }
    
}

-(void)setupTilesColorWithColor:(NSString *)color {

    NSString* bigColor = [NSString stringWithFormat:@"%@", color];
    
    if ([bigColor isEqualToString:@"blue"]) { //27 161 226
        UIColor *blue = [UIColor colorWithRed:27.0/255 green:161.0/255 blue:226.0/255 alpha:1];
        [bookmarksLabel setBackgroundColor:blue];
        [browserLabel setBackgroundColor:blue];
        [aboutLabel setBackgroundColor:blue];
        [voiceTile setBackgroundColor:blue];
        [settingsLabel setBackgroundColor:blue];
        [donateTile setBackgroundColor:blue];
        NSLog(@"blue setted up");
    }

    if ([bigColor isEqualToString:@"pink"]) {//230 113 184
        UIColor *pink = [UIColor colorWithRed:230.0/255 green:113.0/255 blue:184.0/255 alpha:1];
        [bookmarksLabel setBackgroundColor:pink];
        [browserLabel setBackgroundColor:pink];
        [aboutLabel setBackgroundColor:pink];
        [voiceTile setBackgroundColor:pink];
        [settingsLabel setBackgroundColor:pink];
        [donateTile setBackgroundColor:pink];
    }
    
    if ([bigColor isEqualToString:@"red"]) {//229 20 0
        UIColor *red = [UIColor colorWithRed:229.0/255 green:20.0/255 blue:0.0/255 alpha:1];
        bookmarksLabel.backgroundColor = [UIColor colorWithRed:229.0/255 green:20.0/255 blue:0.0/255 alpha:1];
        [browserLabel setBackgroundColor:red];
        [aboutLabel setBackgroundColor:red];
        [voiceTile setBackgroundColor:red];
        [settingsLabel setBackgroundColor:red];
        [donateTile setBackgroundColor:red];
    }
    
    
    if ([bigColor isEqualToString:@"teal"]) {//0 171 169
        UIColor *teal = [UIColor colorWithRed:0.0/255 green:171.0/255 blue:169.0/255 alpha:1];
        [bookmarksLabel setBackgroundColor:teal];
        [browserLabel setBackgroundColor:teal];
        [aboutLabel setBackgroundColor:teal];
        [voiceTile setBackgroundColor:teal];
        [settingsLabel setBackgroundColor:teal];
        [donateTile setBackgroundColor:teal];
    }
    
    if ([bigColor isEqualToString:@"lime"]) { //162 193 57
        UIColor *lime = [UIColor colorWithRed:162.0/255 green:193.0/255 blue:57.0/255 alpha:1];
        [bookmarksLabel setBackgroundColor:lime];
        [browserLabel setBackgroundColor:lime];
        [aboutLabel setBackgroundColor:lime];
        [voiceTile setBackgroundColor:lime];
        [settingsLabel setBackgroundColor:lime];
        [donateTile setBackgroundColor:lime];
    }
    
    if ([bigColor isEqualToString:@"mango"]) {//240 150 9
        UIColor *mango = [UIColor colorWithRed:240.0/255 green:150.0/255 blue:9.0/255 alpha:1];
        [bookmarksLabel setBackgroundColor:mango];
        [browserLabel setBackgroundColor:mango];
        [aboutLabel setBackgroundColor:mango];
        [voiceTile setBackgroundColor:mango];
        [settingsLabel setBackgroundColor:mango];
        donateTile.backgroundColor = mango;
    }
    
    if ([bigColor isEqualToString:@"orangeuk"]) {//255 102 0
        UIColor *orange = [UIColor colorWithRed:255.0/255 green:102.0/255 blue:0.0/255 alpha:1];
        [bookmarksLabel setBackgroundColor:orange];
        [browserLabel setBackgroundColor:orange];
        [aboutLabel setBackgroundColor:orange];
        [voiceTile setBackgroundColor:orange];
        [settingsLabel setBackgroundColor:orange];
        [donateTile setBackgroundColor:orange];
    }
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.openEarseventsObserver setDelegate:self];
    
    activity.alpha = 0.0;
    
    //////////////////////////////
    
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"c.plist"]; //3
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path]) //4
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"c" ofType:@"plist"]; //5
        
        [fileManager copyItemAtPath:bundle toPath: path error:&error]; //6
    }
    NSError *errorTwo;
    NSArray *pathsTwo = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
    NSString *documentsDirectoryTwo = [pathsTwo objectAtIndex:0]; //2
    NSString *pathTwo = [documentsDirectoryTwo stringByAppendingPathComponent:@"b.plist"]; //3
    
    NSFileManager *fileManagerTwo = [NSFileManager defaultManager];
    
    if (![fileManagerTwo fileExistsAtPath: pathTwo]) //4
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"b" ofType:@"plist"]; //5
        
        [fileManagerTwo copyItemAtPath:bundle toPath: path error:&errorTwo]; //6
    }
    
    //////////////////////////////
    
    lime = [UIColor colorWithRed:140.0/255 green:191.0/255 blue:38.0/255 alpha:1];
    
    [NSTimer scheduledTimerWithTimeInterval:0.2f target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(updateBattery) userInfo:nil repeats:YES];
    
    darkenView.alpha = 0;
    
    [self updateBattery];
    
    [scroll setContentSize:CGSizeMake(320, 480)];
    scroll.alwaysBounceVertical =NO;
    [self interfaceSetup];
    [self.scroll setBackgroundColor:[UIColor clearColor]];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    infosPlistPath = [[NSBundle mainBundle] pathForResource:@"c" ofType:@"plist"];
    colors = [[NSMutableArray alloc] initWithContentsOfFile:path];
    infosPlistPathTwo = [[NSBundle mainBundle] pathForResource:@"b" ofType:@"plist"];
    [self setupTilesColorWithColor:[colors objectAtIndex:0]];

    backgroundColor = [[NSMutableArray alloc] initWithContentsOfFile:pathTwo];
    [self setupBackgroundColorWithColor:[backgroundColor objectAtIndex:0]];
    
    
    [self.voiceView setFrame:CGRectMake(0, -253, 320, 253)];
    [self.voiceTitle setAlpha:0.0];
    [self.requestField setAlpha:0.0];
    [self.crystalTitle setAlpha:1.0];
    [self.speechSnipet setAlpha:0];
    [self.image setAlpha:0.0];
    isListening = NO;
    
    browserButton.enabled = YES;
    bookmarksButton.enabled = YES;
    aboutButton.enabled = YES;
    settingsButton.enabled = YES;
    
    isListening = NO;
    
    [scroll addSubview:bookmarksLabel];
    
    [self layoutScrollImages];
    
}

-(void)setupBackgroundColorWithColor:(NSString *)value {
    
    UIColor* biatch = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
    
    if ([value isEqualToString:@"white"]){
        [scroll setBackgroundColor:biatch];
        [self.view setBackgroundColor:biatch];
        [self.headerView setBackgroundColor:biatch];
        [self.timeLabel setTextColor:[UIColor darkGrayColor]];
        
        NSLog(@"white");}
    
    if ([value isEqualToString:@"gray"]){
        [scroll setBackgroundColor:[UIColor lightGrayColor]];
        [self.view setBackgroundColor:[UIColor lightGrayColor]];
        [self.headerView setBackgroundColor:[UIColor lightGrayColor]];
        [self.timeLabel setTextColor:[UIColor darkGrayColor]];
        NSLog(@"gray");}

    
    if ([value isEqualToString:@"black"]){
        [scroll setBackgroundColor:[UIColor blackColor]];
        [self.view setBackgroundColor:[UIColor blackColor]];
        [self.headerView setBackgroundColor:[UIColor blackColor]];
        [self.timeLabel setTextColor:[UIColor whiteColor]];
        
        NSLog(@"");}

}



-(void)interfaceSetup {
    
    [bookmarksButton addTarget:self action:@selector(bookmarksPressed:) forControlEvents:UIControlEventTouchDown];    
    [aboutButton addTarget:self action:@selector(aboutPressed:) forControlEvents:UIControlEventTouchUpInside];
    [settingsButton addTarget:self action:@selector(settingsPressed:) forControlEvents:UIControlEventTouchUpInside];
    [browserButton addTarget:self action:@selector(browserPressed:) forControlEvents:UIControlEventTouchDown];
    [donateButton addTarget:self action:@selector(donatePressed:) forControlEvents:UIControlEventTouchDown];
    
}

-(void)donatePressed:(id)sender {
    
    [browserButton setEnabled:NO];
    [settingsButton setEnabled:NO];
    [aboutButton setEnabled:NO];
    [bookmarksButton setEnabled:NO];
    [NSTimer scheduledTimerWithTimeInterval:0.15 target:self selector:@selector(releaseDt) userInfo:nil repeats:NO];
    
    [UIView beginAnimations:@"donateTouched" context:NULL];
    [UIView setAnimationDuration:0.15];
    donateTile.transform = CGAffineTransformMakeScale(0.93, 0.93);
    [UIView commitAnimations];
    
}
-(void)releaseDt {
    [UIView beginAnimations:@"browserTouched" context:NULL];
    [UIView setAnimationDuration:0.2];
    donateTile.transform = CGAffineTransformMakeScale(1, 1);
    [UIView commitAnimations];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(launchDt:) userInfo:nil repeats:NO];
}
-(void)launchDt:(id)sender {[self performSegueWithIdentifier:@"donate" sender:self];}

-(void)bookmarksPressed:(id)sender {
    
    [browserButton setEnabled:NO];
    [settingsButton setEnabled:NO];
    [aboutButton setEnabled:NO];
    [NSTimer scheduledTimerWithTimeInterval:0.15 target:self selector:@selector(releaseBm) userInfo:nil repeats:NO];

    [UIView beginAnimations:@"bookmarksTouched" context:NULL];
    [UIView setAnimationDuration:0.15];
    bookmarksLabel.transform = CGAffineTransformMakeScale(0.93, 0.93);
    [UIView commitAnimations];    
}
-(void)releaseBm{
    [UIView beginAnimations:@"browserTouched" context:NULL];
    [UIView setAnimationDuration:0.2];
    bookmarksLabel.transform = CGAffineTransformMakeScale(1, 1);
    [UIView commitAnimations];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(launchBm:) userInfo:nil repeats:NO];
}
-(void)launchBm:(id)sender {[self performSegueWithIdentifier:@"b" sender:self];}

-(void)browserPressed:(id)sender {
    
    [bookmarksButton setEnabled:NO];
    [settingsButton setEnabled:NO];
    [aboutButton setEnabled:NO];
    [NSTimer scheduledTimerWithTimeInterval:0.15 target:self selector:@selector(releaseBr:) userInfo:nil repeats:NO];

    [UIView beginAnimations:@"browserTouched" context:NULL];
    [UIView setAnimationDuration:0.15];
    browserLabel.transform = CGAffineTransformMakeScale(0.93, 0.93);
    [UIView commitAnimations];
}
-(void)releaseBr:(id)sender{
    [UIView beginAnimations:@"browserTouched" context:NULL];
    [UIView setAnimationDuration:0.2];
    browserLabel.transform = CGAffineTransformMakeScale(1, 1);
    [UIView commitAnimations];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(launchBr:) userInfo:nil repeats:NO];
}
-(void)launchBr:(id)sender {[self performSegueWithIdentifier:@"browser" sender:self];}

-(void)aboutPressed:(id)sender {
    
    [bookmarksButton setEnabled:NO];
    [settingsButton setEnabled:NO];
    [browserButton setEnabled:NO];
    
    [NSTimer scheduledTimerWithTimeInterval:0.15 target:self selector:@selector(releaseAb:) userInfo:nil repeats:NO];
    
    [UIView beginAnimations:@"aboutTouched" context:NULL];
    [UIView setAnimationDuration:0.15];
    aboutLabel.transform = CGAffineTransformMakeScale(0.93, 0.93);
    [UIView commitAnimations];
}
-(void)releaseAb:(id)sender {
    [UIView beginAnimations:@"aboutTouched" context:NULL];
    [UIView setAnimationDuration:0.2];
    aboutLabel.transform = CGAffineTransformMakeScale(1, 1);
    [UIView commitAnimations];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(launchAb:) userInfo:nil repeats:NO];
}
-(void)launchAb:(id)sender {[self performSegueWithIdentifier:@"about" sender:self];}


-(void)settingsPressed:(id)sender {
    
    [bookmarksButton setEnabled:NO];
    [aboutButton setEnabled:NO];
    [browserButton setEnabled:NO];
    
    [NSTimer scheduledTimerWithTimeInterval:0.15 target:self selector:@selector(releaseSt:) userInfo:nil repeats:NO];
    
    [UIView beginAnimations:@"settingsTouched" context:NULL];
    [UIView setAnimationDuration:0.15];
    settingsLabel.transform = CGAffineTransformMakeScale(0.93, 0.93);
    [UIView commitAnimations];
}
-(void)releaseSt:(id)sender{
    [UIView beginAnimations:@"settingsRelease" context:NULL];
    [UIView setAnimationDuration:0.2];
    settingsLabel.transform = CGAffineTransformMakeScale(1, 1);
    [UIView commitAnimations];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(launchSt:) userInfo:nil repeats:NO];
}
-(void)launchSt:(id)sender {
    [self performSegueWithIdentifier:@"settings" sender:self];
}




-(void)layoutScrollImages{
    
	UIImageView *view = nil;
	NSArray *subviews = [scroll subviews];
    
	CGFloat curXLoc = 0;
	for (view in subviews)
	{
		if ([view isKindOfClass:[UIImageView class]] && view.tag > 0)
		{
			CGRect frame = view.frame;
			frame.origin = CGPointMake(curXLoc, 0);
			view.frame = frame;
			
			curXLoc += (320);
		}
	}
    [self.scroll setContentSize:CGSizeMake(320, 520)];}

- (void)viewDidUnload{
    [self setScroll:nil];
    [self setAboutButton:nil];
    [self setAboutLabel:nil];
    [self setSettingsButton:nil];
    [self setSettingsLabel:nil];
    [self setVoiceTitle:nil];
    [self setCrystalTitle:nil];
    [self setVoiceView:nil];
    [self setSpeechSnipet:nil];
    [self setMicrophoneButton:nil];
    [self setImage:nil];
    [self setRequestField:nil];
    [self setNote:nil];
    [self setPossibilitiesLabel:nil];
    [self setWhatWouldYouLike:nil];
    [self setGoButton:nil];
    [self setVoiceTile:nil];
    [self setDonateButton:nil];
    [self setDarkenView:nil];
    [self setDateLabel:nil];
    [self setBatteryStatus:nil];
    [self setActivity:nil];
    [self setHeaderView:nil];
    [self setTimeLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)launchVoice:(id)sender {
    
    [UIView beginAnimations:@"goToVoice" context:NULL];
    [UIView setAnimationDuration:0.5];
    scroll.transform = CGAffineTransformMakeTranslation(0, 100);
    voiceView.transform = CGAffineTransformMakeTranslation(0, 253);
    darkenView.alpha = 0.5;
    [UIView commitAnimations];
    
    
    NSBundle* mainBundle = [NSBundle mainBundle];
    NSString*pathh = [mainBundle pathForResource:@"launch" ofType:@"mp3"];
    //NSURL *audioFileURL = [[NSURL alloc] initFileURLWithPath:pathh];
    NSURL* fesse = [NSURL fileURLWithPath:pathh];
    NSError *error;
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fesse error:&error];
    audioPlayer.volume = 0.4;
    
    [audioPlayer prepareToPlay];
    [audioPlayer setVolume:0.4];
    
}

-(IBAction)dismissVoice:(id)sender {
    
    [UIView beginAnimations:@"dismissdaVoice" context:NULL];
    [UIView setAnimationDuration:0.5];
    scroll.transform = CGAffineTransformMakeTranslation(0, 0);
    voiceView.transform = CGAffineTransformMakeTranslation(0, 0);
    darkenView.alpha = 0;
    speechSnipet.alpha = 0;
    requestField.alpha = 0;
    [self.pocketsphinxController suspendRecognition];
    [UIView commitAnimations];
    
}

#pragma-mark VOICE RECOGNITION !! :D

-(void)pocketsphinxDidCompleteCalibration {
    
    [UIView beginAnimations:@"showImage" context:NULL];
    [UIView setAnimationDuration:0.5];
    activity.alpha = 0.0;
    [microphoneButton setImage:[UIImage imageNamed:@"voiceWhite.png"] forState:UIControlStateNormal];
    image.alpha = 1.0;
    [UIView commitAnimations];
    
    audioPlayer.delegate = self;
    [audioPlayer play];
    
    [pocketsphinxController suspendRecognition];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(soundPlayed) userInfo:nil repeats:NO];
    
    
}

-(void)soundPlayed {
    
    [pocketsphinxController resumeRecognition];
      
}

- (IBAction)tapedMic:(id)sender {
    
    if (isListening == NO) {
    self.pathToGrammarToStartAppWith = [NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] resourcePath], @"5074.languagemodel"];
    isListening = YES;
        
	self.pathToDictionaryToStartAppWith = [NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] resourcePath], @"5074.dic"];
    [self.pocketsphinxController startListeningWithLanguageModelAtPath:self.pathToGrammarToStartAppWith dictionaryAtPath:self.pathToDictionaryToStartAppWith languageModelIsJSGF:FALSE];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(startDisplayingLevels) userInfo:nil repeats:NO];
        if (launchedOnce == NO) {
        [UIView beginAnimations:@"bite" context:NULL];
        [UIView setAnimationDuration:0.3];
        
        note.alpha = 0.0;
        possibilitiesLabel.alpha = 0.0;
        
        activity.alpha = 1.0;
            
        speechSnipet.alpha = 1.0;
        requestField.alpha = 1.0;
        speechSnipet.transform = CGAffineTransformMakeTranslation(0, -20);
        requestField.transform = CGAffineTransformMakeTranslation(0, -20);
        
            [UIView commitAnimations];}}
    
        else {
            
            [self.pocketsphinxController stopListening];
            [self stopDisplayingLevels];
            [UIView beginAnimations:@"cul" context:NULL];
            [UIView setAnimationDuration:0.2];
            speechSnipet.transform = CGAffineTransformMakeTranslation(0, 0);
            requestField.transform = CGAffineTransformMakeTranslation(0, 0);
            speechSnipet.alpha=0;
            requestField.alpha=0;
            image.alpha = 0;
            activity.alpha = 0.0;
            image.transform = CGAffineTransformMakeScale(1, 1);
            [UIView commitAnimations];
            
            [microphoneButton setImage:[UIImage imageNamed:@"voice.png"] forState:UIControlStateNormal];
            
            isListening = NO;
            
        }
    
}

- (IBAction)wantsDissmissing:(id)sender {
    [self dismissVoice:self];
}

- (void) startDisplayingLevels { // Start displaying the levels using a timer
	[self stopDisplayingLevels]; // We never want more than one timer valid so we'll stop any running timers first.
	uiUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/18 target:self selector:@selector(updateLevelsUI) userInfo:nil repeats:YES];
}

- (void) stopDisplayingLevels { // Stop displaying the levels by stopping the timer if it's running.
	if(self.uiUpdateTimer && [self.uiUpdateTimer isValid]) { // If there is a running timer, we'll stop it here.
		[self.uiUpdateTimer invalidate];
		self.uiUpdateTimer = nil;
	}
}

- (void) updateLevelsUI { // And here is how we obtain the levels.  This method includes the actual OpenEars methods and uses their results to update the UI of this view controller.
        
    [UIView beginAnimations:@"updateUI" context:NULL];
    [UIView setAnimationDuration:1.0/18];
    float transform = -100.00/[self.pocketsphinxController pocketsphinxInputLevel];
    image.transform = CGAffineTransformMakeScale(transform, transform);
    [UIView commitAnimations];
    
}

-(void)pocketsphinxDidReceiveHypothesis:(NSString *)hypothesis recognitionScore:(NSString *)recognitionScore utteranceID:(NSString *)utteranceID {
    
    NSLog(@"%@", hypothesis);
    
    NSString *bite = [hypothesis capitalizedString];
    
    NSString *text = [bite stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[bite substringToIndex:1] capitalizedString]];
    
    if (speechSnipet.alpha == 1)
    {
        self.requestField.text = text;
    }
    
}



@end

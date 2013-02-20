//
//  HomeViewController.h
//  Crystal
//
//  Created by Guillaume on 25/08/12.
//  Copyright (c) 2012 Guillaume Cendre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OpenEars/PocketsphinxController.h>
#import <OpenEars/OpenEarsEventsObserver.h>
#import <AVFoundation/AVFoundation.h>

@interface HomeViewController : UIViewController <UIScrollViewDelegate, OpenEarsEventsObserverDelegate, AVAudioPlayerDelegate, AVAudioSessionDelegate> {
    PocketsphinxController *pocketsphinxController;
    NSString* pathToDictionaryToStartAppWith;
    NSString* pathToGrammarToStartAppWith;
    NSTimer* uiUpdateTimer;
    OpenEarsEventsObserver* openEarseventsObserver;
}
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (nonatomic, retain) OpenEarsEventsObserver *openEarseventsObserver;
@property (nonatomic, retain) PocketsphinxController *pocketsphinxController;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *batteryStatus;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIView *darkenView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;

@property (weak, nonatomic) IBOutlet UIButton* bookmarksButton;
@property (weak, nonatomic) IBOutlet UIButton* browserButton;
@property (weak, nonatomic) IBOutlet UIButton* aboutButton;
@property (weak, nonatomic) IBOutlet UIButton* settingsButton;
@property (weak, nonatomic) IBOutlet UIButton *donateButton;

@property (weak, nonatomic) IBOutlet UIView* bookmarksLabel;
@property (weak, nonatomic) IBOutlet UIView* browserLabel;
@property (weak, nonatomic) IBOutlet UIView* aboutLabel;
@property (weak, nonatomic) IBOutlet UIView* settingsLabel;
@property (weak, nonatomic) IBOutlet UIView *voiceTile;
@property (weak, nonatomic) IBOutlet UIView* donateTile;

@property (weak, nonatomic) IBOutlet UILabel *voiceTitle;
@property (weak, nonatomic) IBOutlet UILabel *crystalTitle;

@property (retain, nonatomic) IBOutlet AVAudioPlayer* audioPlayer;


@property (weak, nonatomic) IBOutlet UILabel *note;
@property (weak, nonatomic) IBOutlet UILabel *possibilitiesLabel;
@property (weak, nonatomic) IBOutlet UIButton *goButton;
@property (weak, nonatomic) IBOutlet UILabel *whatWouldYouLike;

@property (weak, nonatomic) IBOutlet UIView *voiceView;
@property (weak, nonatomic) IBOutlet UIImageView *speechSnipet;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UITextView *requestField;


@property (nonatomic, copy) NSString *pathToGrammarToStartAppWith;
@property (nonatomic, copy) NSString *pathToDictionaryToStartAppWith;
@property (nonatomic, strong) NSTimer* uiUpdateTimer;

- (IBAction)launchVoice:(id)sender;
-(IBAction)dismissVoice:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *microphoneButton;
- (IBAction)tapedMic:(id)sender;
- (IBAction)wantsDissmissing:(id)sender;

@end

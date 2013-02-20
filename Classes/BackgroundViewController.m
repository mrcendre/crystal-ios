//
//  BackgroundViewController.m
//  Crystal
//
//  Created by Guillaume on 13/09/12.
//  Copyright (c) 2012 Guillaume Cendre. All rights reserved.
//

#import "BackgroundViewController.h"

@interface BackgroundViewController ()

@end

@implementation BackgroundViewController
@synthesize grayImage, blackImage, whiteImage;
@synthesize scroll;

NSString* infosPlistPath;
NSMutableArray *ma;
NSArray* array;
NSString *path;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.scroll setContentSize:CGSizeMake(320, 300)];
    
    infosPlistPath = [[NSBundle mainBundle] pathForResource:@"b" ofType:@"plist"];
    ma = [[NSMutableArray alloc] initWithContentsOfFile:infosPlistPath];
    
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2
    path = [documentsDirectory stringByAppendingPathComponent:@"b.plist"]; //3
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path]) //4
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"b" ofType:@"plist"]; //5
        
        [fileManager copyItemAtPath:bundle toPath: path error:&error]; //6
    }
    
    NSMutableArray* liste = [[NSMutableArray alloc] initWithContentsOfFile:path];
    
    [self updateImagesWithSelected:[NSString stringWithFormat:@"%@", [liste objectAtIndex:0]]];
	// Do any additional setup after loading the view.
}

-(void)updateImagesWithSelected:(NSString *)color {
    
    if ([color isEqualToString:@"gray"]){
        [grayImage setImage:[UIImage imageNamed:@"ssquare.png"]];
        [blackImage setImage:nil];
        [whiteImage setImage:nil];
    }
    if ([color isEqualToString:@"white"]){
        [grayImage setImage:nil];
        [blackImage setImage:nil];
        [whiteImage setImage:[UIImage imageNamed:@"ssquare.png"]];
    }
    if ([color isEqualToString:@"black"]){
        [grayImage setImage:nil];
        [blackImage setImage:[UIImage imageNamed:@"ssquare.png"]];
        [whiteImage setImage:nil];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {

    [self setWhiteImage:nil];
    [self setGrayImage:nil];
    [self setBlackImage:nil];
    [self setScroll:nil];
    [super viewDidUnload];
}
- (IBAction)graySelected:(id)sender {
    
    array = [[NSArray alloc] initWithObjects:@"gray", nil];
    [array writeToFile:path atomically:NO];
    [self updateImagesWithSelected:@"gray"];
    
}

- (IBAction)whiteSelected:(id)sender {
    array = [[NSArray alloc] initWithObjects:@"white", nil];
    [array writeToFile:path atomically:NO];
    [self updateImagesWithSelected:@"white"];
}

- (IBAction)blackSelected:(id)sender {
    array = [[NSArray alloc] initWithObjects:@"black", nil];
    [array writeToFile:path atomically:NO];
    [self updateImagesWithSelected:@"black"];
}
@end

//
//  ColorsViewController.m
//  Crystal
//
//  Created by Guillaume on 05/09/12.
//  Copyright (c) 2012 Guillaume Cendre. All rights reserved.
//

#import "ColorsViewController.h"

@interface ColorsViewController ()

@end

@implementation ColorsViewController
@synthesize scroll, blueImage, pinkImage;
@synthesize redImage, tealImage, limeImage;
@synthesize mangoImage, orangeImage;

NSArray* array;
NSMutableArray* ma;
NSString* infosPlistPath;
NSString* path;

- (void)viewDidLoad
{
    [super viewDidLoad];
    infosPlistPath = [[NSBundle mainBundle] pathForResource:@"c" ofType:@"plist"];
    ma = [[NSMutableArray alloc] initWithContentsOfFile:infosPlistPath];
    
    [self.scroll setContentSize:CGSizeMake(320, 530)];
    
    
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2
    path = [documentsDirectory stringByAppendingPathComponent:@"c.plist"]; //3
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path]) //4
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"c" ofType:@"plist"]; //5
        
        [fileManager copyItemAtPath:bundle toPath: path error:&error]; //6
    }
    
    NSMutableArray* liste = [[NSMutableArray alloc] initWithContentsOfFile:path];
    
    [self updateImagesWithSelected:[NSString stringWithFormat:@"%@", [liste objectAtIndex:0]]];
    
	// Do any additional setup after loading the view.
}

-(void)updateImagesWithSelected:(NSString*)color {
    
    if ([color isEqualToString:@"blue"]) {
        [blueImage setImage:[UIImage imageNamed:@"ssquare.png"]];
        [pinkImage setImage:nil];
        [redImage setImage:nil];
        [tealImage setImage:nil];
        [limeImage setImage:nil];
        [mangoImage setImage:nil];
        [orangeImage setImage:nil];
    }
    if ([color isEqualToString:@"pink"]) {
        [pinkImage setImage:[UIImage imageNamed:@"ssquare.png"]];
        [blueImage setImage:nil];
        [redImage setImage:nil];
        [tealImage setImage:nil];
        [limeImage setImage:nil];
        [mangoImage setImage:nil];
        [orangeImage setImage:nil];
    }
    if ([color isEqualToString:@"red"]) {
        [redImage setImage:[UIImage imageNamed:@"ssquare.png"]];
        [pinkImage setImage:nil];
        [tealImage setImage:nil];
        [blueImage setImage:nil];
        [limeImage setImage:nil];
        [mangoImage setImage:nil];
        [orangeImage setImage:nil];
    }
    if ([color isEqualToString:@"teal"]) {
        [tealImage setImage:[UIImage imageNamed:@"ssquare.png"]];
        [pinkImage setImage:nil];
        [redImage setImage:nil];
        [blueImage setImage:nil];
        [limeImage setImage:nil];
        [mangoImage setImage:nil];
        [orangeImage setImage:nil];
    }
    if ([color isEqualToString:@"lime"]) {
        [limeImage setImage:[UIImage imageNamed:@"ssquare.png"]];
        [pinkImage setImage:nil];
        [redImage setImage:nil];
        [tealImage setImage:nil];
        [blueImage setImage:nil];
        [mangoImage setImage:nil];
        [orangeImage setImage:nil];
    }
    if ([color isEqualToString:@"mango"]) {
        [mangoImage setImage:[UIImage imageNamed:@"ssquare.png"]];
        [pinkImage setImage:nil];
        [redImage setImage:nil];
        [tealImage setImage:nil];
        [limeImage setImage:nil];
        [blueImage setImage:nil];
        [orangeImage setImage:nil];
    }
    if ([color isEqualToString:@"orangeuk"]) {
        [orangeImage setImage:[UIImage imageNamed:@"ssquare.png"]];
        [pinkImage setImage:nil];
        [redImage setImage:nil];
        [tealImage setImage:nil];
        [limeImage setImage:nil];
        [mangoImage setImage:nil];
        [blueImage setImage:nil];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {

    [self setScroll:nil];
    [self setBlueImage:nil];
    [self setPinkImage:nil];
    [self setRedImage:nil];
    [self setTealImage:nil];
    [self setLimeImage:nil];
    [self setMangoImage:nil];
    [self setOrangeImage:nil];
    [super viewDidUnload];
}


- (IBAction)blue:(id)sender {
    array = [[NSArray alloc] initWithObjects:@"blue", nil];
    [array writeToFile:path atomically:NO];
    [self updateImagesWithSelected:@"blue"];

}

- (IBAction)pink:(id)sender {
    array = [[NSArray alloc] initWithObjects:@"pink", nil];
    [array writeToFile:path atomically:NO];
    [self updateImagesWithSelected:@"pink"];

}
- (IBAction)red:(id)sender {
    array = [[NSArray alloc] initWithObjects:@"red", nil];
    [array writeToFile:path atomically:NO];    NSLog(@"biatch");
    [self updateImagesWithSelected:@"red"];

}

- (IBAction)teal:(id)sender {
    array = [[NSArray alloc] initWithObjects:@"teal", nil];
    [array writeToFile:path atomically:NO];    NSLog(@"biatch");
    [self updateImagesWithSelected:@"teal"];
}

- (IBAction)lime:(id)sender {
    array = [[NSArray alloc] initWithObjects:@"lime", nil];
    [array writeToFile:path atomically:NO];    NSLog(@"biatch");
    [self updateImagesWithSelected:@"lime"];

}

- (IBAction)mango:(id)sender {
    array = [[NSArray alloc] initWithObjects:@"mango", nil];
    [array writeToFile:path atomically:NO];    NSLog(@"biatch");
    [self updateImagesWithSelected:@"mango"];

}

- (IBAction)orange:(id)sender {
    array = [[NSArray alloc] initWithObjects:@"orangeuk", nil];
    [array writeToFile:path atomically:NO];
    [self updateImagesWithSelected:@"orangeuk"];

    NSLog(@"biatch");
}

@end

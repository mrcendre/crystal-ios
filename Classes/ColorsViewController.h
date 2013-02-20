//
//  ColorsViewController.h
//  Crystal
//
//  Created by Guillaume on 05/09/12.
//  Copyright (c) 2012 Guillaume Cendre. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scroll;


@property (weak, nonatomic) IBOutlet UIImageView *blueImage;
@property (weak, nonatomic) IBOutlet UIImageView *pinkImage;
@property (weak, nonatomic) IBOutlet UIImageView *redImage;
@property (weak, nonatomic) IBOutlet UIImageView *tealImage;
@property (weak, nonatomic) IBOutlet UIImageView *limeImage;
@property (weak, nonatomic) IBOutlet UIImageView *mangoImage;
@property (weak, nonatomic) IBOutlet UIImageView *orangeImage;


- (IBAction)blue:(id)sender;
- (IBAction)pink:(id)sender;
- (IBAction)red:(id)sender;
- (IBAction)teal:(id)sender;
- (IBAction)lime:(id)sender;
- (IBAction)mango:(id)sender;
- (IBAction)orange:(id)sender;


@end

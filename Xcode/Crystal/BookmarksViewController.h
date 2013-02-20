//
//  BookmarksViewController.h
//  Crystal
//
//  Created by Guillaume on 26/08/12.
//  Copyright (c) 2012 Guillaume Cendre. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookmarksViewController : UIViewController <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scroll;

@property (weak, nonatomic) IBOutlet UIView *optionsView;
@property (weak, nonatomic) IBOutlet UIButton *showMenuButton;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (weak, nonatomic) IBOutlet UILabel* title1;
@property (weak, nonatomic) IBOutlet UILabel* title2;
@property (weak, nonatomic) IBOutlet UILabel* title3;
@property (weak, nonatomic) IBOutlet UILabel* title4;
@property (weak, nonatomic) IBOutlet UILabel* title5;

@property (weak, nonatomic) IBOutlet UILabel* subtitle1;
@property (weak, nonatomic) IBOutlet UILabel* subtitle2;
@property (weak, nonatomic) IBOutlet UILabel* subtitle3;
@property (weak, nonatomic) IBOutlet UILabel* subtitle4;
@property (weak, nonatomic) IBOutlet UILabel* subtitle5;

@property (weak, nonatomic) IBOutlet UIView* view1;
@property (weak, nonatomic) IBOutlet UIView* view2;
@property (weak, nonatomic) IBOutlet UIView* view3;
@property (weak, nonatomic) IBOutlet UIView* view4;
@property (weak, nonatomic) IBOutlet UIView* view5;

- (IBAction)changePage;

@end

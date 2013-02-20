//
//  BookmarksViewController.m
//  Crystal
//
//  Created by Guillaume on 26/08/12.
//  Copyright (c) 2012 Guillaume Cendre. All rights reserved.
//

#import "BookmarksViewController.h"

@interface BookmarksViewController ()

@end

const int kScreenWidth = 320;

@implementation BookmarksViewController
@synthesize scroll;
@synthesize optionsView;
@synthesize showMenuButton;
@synthesize title1, title2, title3, title4, title5;
@synthesize subtitle1, subtitle2, subtitle3, subtitle4, subtitle5;
@synthesize view1, view2, view3, view4, view5, pageControl;
NSMutableString* infos;
NSMutableArray* names;
NSMutableArray* links;
int numberOfBookmarks;
int current;

UIColor* lime;
UIColor* whiteGray;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    lime = [UIColor colorWithRed:140.0/255 green:191.0/255 blue:38.0/255 alpha:1];
    whiteGray = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
    
    [optionsView setBackgroundColor:[UIColor lightGrayColor]];
    [scroll setBackgroundColor:lime];
        
    NSString *namesPlistPath = [[NSBundle mainBundle] pathForResource:@"names" ofType:@"plist"];
    names = [[NSMutableArray alloc] initWithContentsOfFile:namesPlistPath];
    
    NSString *linksPlistPath = [[NSBundle mainBundle] pathForResource:@"links" ofType:@"plist"];
    links = [[NSMutableArray alloc] initWithContentsOfFile:linksPlistPath];
  
    [scroll setShowsVerticalScrollIndicator:NO];
    
    numberOfBookmarks = 4;
    [scroll setContentSize:CGSizeMake((kScreenWidth*numberOfBookmarks), 480)];
    scroll.alwaysBounceVertical =NO;
    pageControl.numberOfPages = numberOfBookmarks;
    
    [self setupTileWithIndex:0 withLabel:title1 andSubtitle:subtitle1 andView:view1];
    [self setupTileWithIndex:1 withLabel:title2 andSubtitle:subtitle2 andView:view2];
    [self setupTileWithIndex:2 withLabel:title3 andSubtitle:subtitle3 andView:view3];
    [self setupTileWithIndex:3 withLabel:title4 andSubtitle:subtitle4 andView:view4];

    [showMenuButton addTarget:self action:@selector(displayMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    [self layoutScrollImages];
    [scroll setPagingEnabled:YES];
            
	// Do any additional setup after loading the view.
}


-(void)setupTileWithIndex:(int)index withLabel:(UILabel*)title andSubtitle:(UILabel*)subtitle andView:(UIView*)view {
    
    
    [title setHidden:NO];
    [subtitle setHidden:NO];
    [view setHidden:NO];
    
    NSString *namesPlistPath = [[NSBundle mainBundle] pathForResource:@"names" ofType:@"plist"];
    NSArray *propertieNames = [[NSMutableArray alloc] initWithContentsOfFile:namesPlistPath];
    
    NSString *linksPlistPath = [[NSBundle mainBundle] pathForResource:@"links" ofType:@"plist"];
    NSArray* propertieLinks = [[NSMutableArray alloc] initWithContentsOfFile:linksPlistPath];
    
    [title setFrame:CGRectMake(((kScreenWidth*index)+20), 52, 280, 122)];
    NSString* titleText = [NSString stringWithFormat:@"%@", [propertieNames objectAtIndex:index]];
    [title setText:titleText];
    [title setTextColor:whiteGray];
    
    [subtitle setFrame:CGRectMake(((kScreenWidth*index)+50), 150, 220, 100)];
    NSString* subtitleText = [NSString stringWithFormat:@"%@", [propertieLinks objectAtIndex:index]];
    [subtitle setText:subtitleText];
    [subtitle setTextColor:whiteGray];
    
    [view setAlpha:1];
    [view setBackgroundColor:lime];
    [view setFrame:CGRectMake((index*kScreenWidth), 30, kScreenWidth, 270)];
    
    if ([title.text isEqualToString:@""] && [subtitle.text isEqualToString:@""]){
        
        [scroll setContentSize:CGSizeMake(((index-1)*kScreenWidth), 480)];
        
    }
    
}

- (IBAction)changePage {
    // update the scroll view to the appropriate page
    CGRect frame;
    frame.origin.x = self.scroll.frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.scroll.frame.size;
    [self.scroll scrollRectToVisible:frame animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scroll.frame.size.width;
    int page = floor((self.scroll.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}

-(void)displayMenu:(id)sender {
    [UIView beginAnimations:@"dismissMenu" context:NULL];
    [UIView setAnimationDuration:0.7];
    optionsView.transform = CGAffineTransformMakeTranslation(0, -449);
    [optionsView setBackgroundColor:lime];
    [UIView commitAnimations];
    [showMenuButton addTarget:self action:@selector(dismissMenu:) forControlEvents:UIControlEventTouchUpInside];

}

-(void)dismissMenu:(id)sender {
    [UIView beginAnimations:@"dismissMenu" context:NULL];
    [UIView setAnimationDuration:0.7];
    optionsView.transform = CGAffineTransformMakeTranslation(0, 0);
    [optionsView setBackgroundColor:[UIColor lightGrayColor]];
    [UIView commitAnimations];
    [showMenuButton addTarget:self action:@selector(displayMenu:) forControlEvents:UIControlEventTouchUpInside];

    
}



-(void)layoutScrollImages     {
    
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
			
			curXLoc += (kScreenWidth);
		}
	}
    [self.scroll setContentSize:CGSizeMake((numberOfBookmarks*kScreenWidth), 224)];}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setScroll:nil];
    [self setOptionsView:nil];
    [self setShowMenuButton:nil];
    [self setPageControl:nil];
    [super viewDidUnload];
}

@end

//
//  METabBarViewController.m
//  MiniEvalApp
//
//  Created by viet on 1/25/13.
//  Copyright (c) 2013 2359media. All rights reserved.
//

#import "METabBarViewController.h"

@interface METabBarViewController ()

@end

@implementation METabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self hideExistingTabBar];
    
    NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"METabbarView"
                                                        owner:self
                                                      options:nil];
    self.customizedTabBarView = [nibObjects objectAtIndex:0];

    CGRect bottomLocation = self.customizedTabBarView.frame;
    bottomLocation.origin.y = self.view.frame.size.height - self.customizedTabBarView.frame.size.height;
    
    [self.customizedTabBarView setFrame:bottomLocation];
    
    self.customizedTabBarView.delegate = self;
    
    self.customizedTabBarView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    
    [self.view addSubview:self.customizedTabBarView];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) hideExistingTabBar
{
    for (UIView *view in self.view.subviews)
    {
        if ([view isKindOfClass:[UITabBar class]])
        {
            view.hidden = YES;
            break;
        }
    }
}

#pragma mark ME TabBarDelegate

- (void) tabWasSelected:(NSInteger)index
{
    self.selectedIndex = index;
//    UIViewController *viewController = [self.viewControllers objectAtIndex:index];
    
}
@end


/*
- (id)initWithFrame:(CGRect)frame 
{
 if ((self = [super initWithFrame:frame])) 
 {
 // Initialization code
 }
 return self;
}
*/
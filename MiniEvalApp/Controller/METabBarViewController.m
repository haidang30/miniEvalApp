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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self hideExistingTabBar];
    
    NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"METabBarView"
                                                        owner:self
                                                      options:nil];
    self.customizedTabBarView = [nibObjects objectAtIndex:0];
 
    self.customizedTabBarView.delegate = self;
    
    [self.view addSubview:self.customizedTabBarView];    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
}
@end


//- (void)viewDidAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    
//    [self hideExistingTabBar];
//    
//    NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"TabBarView" owner:self options:nil];
//    self.customTabBarView = [nibObjects objectAtIndex:0];
//    self.customTabBarView.delegate = self;
//    
//    [self.view addSubview:self.customTabBarView];
//}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self hideExistingTabBar];
    
    NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"METabBarView" owner:self options:nil];
    self.customTabBarView = [nibObjects objectAtIndex:0];
    
    self.customTabBarView.delegate = self;
    
    CGRect bottomLocation = self.customTabBarView.frame;
    bottomLocation.origin.y = self.view.frame.size.height - self.customTabBarView.frame.size.height;
    [self.customTabBarView setFrame:bottomLocation];
    
    
    [self.view addSubview:self.customTabBarView];
}
*/
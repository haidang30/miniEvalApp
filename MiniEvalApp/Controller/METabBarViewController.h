//
//  METabBarViewController.h
//  MiniEvalApp
//
//  Created by viet on 1/25/13.
//  Copyright (c) 2013 2359media. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "METabBarView.h"
@interface METabBarViewController :UITabBarController <METabBarDelegate>

@property (nonatomic, retain) IBOutlet METabBarView *customizedTabBarView;

- (void) hideExistingTabBar;

@end

//
//  MEAppDelegate.m
//  MiniEvalApp
//
//  Created by viet on 1/21/13.
//  Copyright (c) 2013 2359media. All rights reserved.
//

#import "MEAppDelegate.h"
#import "AFNetworkActivityIndicatorManager.h"

@implementation MEAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self customizeAppearance];
    self.tabBarController = (UITabBarController *)self.window.rootViewController;
    self.tabBarController.delegate = self;
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
//    return YES;
//    self.tabBarController = (UITabBarController *)self.window.rootViewController;
//    self.tabBarController.delegate = self;
//    
//    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:235.0/255.0 green:119.0/255.0 blue:63.0/255.0 alpha:1.0]];
//    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor,[UIFont fontWithName:@"Helvetica Neue Bold" size:20.0], UITextAttributeFont, nil]];
//    
//    [[UIApplication sharedApplication] setStatusBarHidden:YES];
//    
//    return YES;
}

- (void)customizeAppearance
{
//    self.tabBarController = (UITabBarController *)self.window.rootViewController;
//    self.tabBarController.delegate = self;
//    
//    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:235.0/255.0 green:119.0/255.0 blue:63.0/255.0 alpha:1.0]];
//    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor,[UIFont fontWithName:@"Helvetica Neue Bold" size:20.0], UITextAttributeFont, nil]];
//    
//    [[UIApplication sharedApplication] setStatusBarHidden:YES];
//    
    //
    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    // Create resizable images
    
    // Set the background image for *all* UINavigationBars
    
    // Customize the title text for *all* UINavigationBars
    
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor colorWithWhite:1.0 alpha:1.0],
      UITextAttributeTextColor,
      [UIColor colorWithWhite:0.0f alpha:0.8f],
      UITextAttributeTextShadowColor,
      [NSValue valueWithUIOffset:UIOffsetMake(0, -1)],
      UITextAttributeTextShadowOffset,
      [UIFont fontWithName:@"Helvetica Neue Bold" size:20.0],
      UITextAttributeFont,
      nil]
     ];
    
    // Customize the corlor for *all* UINavigationBars
    [[UINavigationBar appearance] setTintColor:[UIColor orangeColor]];
    
    // Customize the color for *all* UITabBars
    [[UITabBar appearance] setTintColor:[UIColor orangeColor]];
    
    
//    UIColor *DarkOrganColor = UIColorFromRGB(kDarkOrganColor);
//    UIColor *MainColor = UIColorFromRGB(kMainColor);
//    
//    [[UINavigationBar appearance] setTintColor:MainColor];
//    
//    [[UINavigationBar appearance] setTitleTextAttributes:
//     [NSDictionary dictionaryWithObjectsAndKeys:
//      [UIColor whiteColor],
//      UITextAttributeTextColor,
//      MainColor,
//      UITextAttributeTextShadowColor,
//      [NSValue valueWithUIOffset:UIOffsetMake(0, -1)],
//      UITextAttributeTextShadowOffset,
//      [UIFont fontWithName:@"Helvetica" size:20.0],
//      UITextAttributeFont,
//      nil]];
//    
//    
//    [[UITabBar appearance] setTintColor:DarkOrganColor];
//    
//    [[UIBarButtonItem appearance] setTintColor:DarkOrganColor];

}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
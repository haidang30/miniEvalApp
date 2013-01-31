//
//  MEStaffDetailsTableViewController.h
//  MiniEvalApp
//
//  Created by viet on 1/23/13.
//  Copyright (c) 2013 2359media. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MEStaff.h"

#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MFMessageComposeViewController.h>

@interface MEStaffDetailsTableViewController : UITableViewController

@property (strong, nonatomic) MEStaff *person;

@end

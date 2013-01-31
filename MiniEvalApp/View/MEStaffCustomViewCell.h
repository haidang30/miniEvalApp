//
//  MEStaffViewCell.h
//  MiniEvalApp
//
//  Created by viet on 1/21/13.
//  Copyright (c) 2013 2359media. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MEStaff;

@interface MEStaffCustomViewCell : UITableViewCell

@property (nonatomic, strong) MEStaff *person;

@property (strong, nonatomic) IBOutlet UIImageView *avatar;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;

@property (strong, nonatomic) IBOutlet UIImageView *starImage;

- (void) configureWithData:(MEStaff *) person
                   atIndex:(NSIndexPath *)indexPath;

@end

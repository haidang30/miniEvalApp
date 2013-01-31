//
//  MEStaffViewCell.h
//  MiniEvalApp
//
//  Created by viet on 1/21/13.
//  Copyright (c) 2013 2359media. All rights reserved.
//

#import <UIKit/UIKit.h>

<<<<<<< HEAD
@class MEStaff;

@interface MEStaffCustomViewCell : UITableViewCell

@property (nonatomic, strong) MEStaff *person;
=======
@class MEPerson;

@interface MEStaffCustomViewCell : UITableViewCell

@property (nonatomic, strong) MEPerson *person;
>>>>>>> 91e25c646733968095ddfe63d91d45a8705ed72b

@property (strong, nonatomic) IBOutlet UIImageView *avatar;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;

@property (strong, nonatomic) IBOutlet UIImageView *starImage;

<<<<<<< HEAD
- (void) configureWithData:(MEStaff *) person
                   atIndex:(NSIndexPath *)indexPath;
=======
>>>>>>> 91e25c646733968095ddfe63d91d45a8705ed72b

@end

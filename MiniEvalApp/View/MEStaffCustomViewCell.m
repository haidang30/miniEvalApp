//
//  MEStaffViewCell.m
//  MiniEvalApp
//
//  Created by viet on 1/21/13.
//  Copyright (c) 2013 2359media. All rights reserved.
//

#import "MEStaffCustomViewCell.h"
#import "MEStaff.h"

#import "UIImageView+AFNetworking.h"

@implementation MEStaffCustomViewCell {    
@private
<<<<<<< HEAD
    __strong MEStaff *_person;
=======
    __strong MEPerson *_person;
>>>>>>> 91e25c646733968095ddfe63d91d45a8705ed72b
}

@synthesize person = _person;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
<<<<<<< HEAD
//
//
//- (void)setPerson:(MEStaff *)person {
////    _person = person;
//    
//    self.nameLabel.text = person.name;
//    self.userNameLabel.text = person.userName;
//    if (person.image) {
//        [self.avatar setImageWithURL:[NSURL URLWithString:person.image] placeholderImage:[UIImage imageNamed:@"icon_profile.png"]];
//    }
//        
//    UIColor *genderCellColor;
//    
//    if ([person.gender isEqualToString:@"male"]) {
//        genderCellColor = UIColorFromRGB(kDarkOrganColor);
//    } else {
//        genderCellColor = UIColorFromRGB(kDarkBlueColor);
//    }
//    
//    [self.nameLabel setTextColor:genderCellColor];
//    
//    [self.nameLabel setNumberOfLines:0];
//    [self.userNameLabel setNumberOfLines:0];
//    
//    [self setNeedsLayout];
//}
- (void)configureWithData:(MEStaff *)person
                  atIndex:(NSIndexPath *)indexPath
{
    self.nameLabel.text = person.name;
    self.userNameLabel.text = person.userName;
    if (person.image)
    {
        [self.avatar setImageWithURL:[NSURL URLWithString:person.image] placeholderImage:[UIImage imageNamed:@"icon_profile.png"]];
    } else
    {
        [self.avatar setImage:[UIImage imageNamed:@"icon_profile.png"]];
    }
    
    UIColor *genderColor;
    
    if ([person.gender isEqualToString:@"male"])
    {
        genderColor = UIColorFromRGB(kDarkOrganColor);
    } else {
        genderColor = UIColorFromRGB(kDarkBlueColor);
    }
    
    [self.nameLabel setTextColor:genderColor];
    
    self.starImage.hidden = !person.highestVisitedCount;
=======


- (void)setPerson:(MEStaff *)person {
//    _person = person;
    
    self.nameLabel.text = person.name;
    self.userNameLabel.text = person.userName;
    if (person.image) {
        [self.avatar setImageWithURL:[NSURL URLWithString:person.image] placeholderImage:[UIImage imageNamed:@"icon_profile.png"]];
    }
        
    UIColor *genderCellColor;
    
    if ([person.gender isEqualToString:@"male"]) {
        genderCellColor = UIColorFromRGB(kDarkOrganColor);
    } else {
        genderCellColor = UIColorFromRGB(kDarkBlueColor);
    }
    
    [self.nameLabel setTextColor:genderCellColor];
>>>>>>> 91e25c646733968095ddfe63d91d45a8705ed72b
    
    [self.nameLabel setNumberOfLines:0];
    [self.userNameLabel setNumberOfLines:0];
    
<<<<<<< HEAD
    UIView *backView = [[UIView alloc] initWithFrame:self.frame];
    if (indexPath.row % 2) {
        backView.backgroundColor = UIColorFromRGB(kLightOrganColor);
    } else {
        backView.backgroundColor = [UIColor whiteColor];
    }
    self.backgroundView = backView;
    
    [self setNeedsLayout];
}

=======
    [self setNeedsLayout];
}


>>>>>>> 91e25c646733968095ddfe63d91d45a8705ed72b
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

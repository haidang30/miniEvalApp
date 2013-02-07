//
//  METabBarView.m
//  MiniEvalApp
//
//  Created by viet on 1/25/13.
//  Copyright (c) 2013 2359media. All rights reserved.
//

#import "METabBarView.h"

@implementation METabBarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (IBAction)touchsInfoButton:(id)sender
{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(tabWasSelected:)])
    {
        [self.contactButton setImage:[UIImage imageNamed:@"icon_contacts"] forState:UIControlStateNormal];
        [self.infoButton setImage:[UIImage imageNamed:@"icon_info_selected"] forState:UIControlStateNormal];
        [self.delegate tabWasSelected:self.infoButton.tag];
    }
}

-(IBAction)touchsContactButton:(id)sender
{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(tabWasSelected:)])
    {
        [self.contactButton setImage:[UIImage imageNamed:@"icon_contacts_selected"] forState:UIControlStateNormal];
        [self.infoButton setImage:[UIImage imageNamed:@"icon_info"] forState:UIControlStateNormal];
        [self.delegate tabWasSelected:self.contactButton.tag];
    }

}
@end
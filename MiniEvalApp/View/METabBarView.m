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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (IBAction)touchButton:(id)sender
{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(tabWasSelected:)])
    {
        if (self.selectedButton)
        {
            if (self.selectedButton.tag == 0)
            {
                [self.selectedButton setImage:[UIImage imageNamed:@"icon_info.png"]
                                    forState:UIControlStateNormal];
            }
            else
            {
                [self.selectedButton setImage:[UIImage imageNamed:@"icon_contacts.png"]
                                    forState:UIControlStateNormal];
            }
        }
        
        self.selectedButton = sender;
        if (self.selectedButton.tag == 0)
        {
            [self.selectedButton setImage:[UIImage imageNamed:@"icon_info_selected.png"]
                                 forState:UIControlStateNormal];
            
        }
        else
        {
            [self.selectedButton setImage:[UIImage imageNamed:@"icon_contacts_selected.png"]
                                 forState:UIControlStateNormal];
        }
        [self.delegate tabWasSelected:self.selectedButton.tag];
    }
}
@end



//-(IBAction) touchButton:(id)sender {
//
//    if( delegate != nil && [delegate respondsToSelector:@selector(tabWasSelected:)]) {
//
//        if (selectedButton) {
//            [selectedButton setBackgroundImage:[UIImage imageNamed:@"Button.png"] forState:UIControlStateNormal];
//            [selectedButton release];
//
//        }
//
//        selectedButton = [((UIButton *)sender) retain];
//        [selectedButton setBackgroundImage:[UIImage imageNamed:@"Button_crystal.png"] forState:UIControlStateNormal];
//        [delegate tabWasSelected:selectedButton.tag];
//    }
//}

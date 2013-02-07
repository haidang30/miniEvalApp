//
//  MEStaffDetailsTableViewController.m
//  MiniEvalApp
//
//  Created by viet on 1/23/13.
//  Copyright (c) 2013 2359media. All rights reserved.
//

#import "MEStaffDetailsTableViewController.h"
#import "MEStaffDetailsCustomViewCell.h"
#import "UIImageView+AFNetworking.h"

#define FONT_SIZE 11.0f
#define CELL_CONTENT_WIDTH 222.0f
#define CELL_CONTENT_MARGIN 10.0f



@interface MEStaffDetailsTableViewController () <MFMailComposeViewControllerDelegate, MFMailComposeViewControllerDelegate>
@property (strong, nonatomic) NSMutableArray *items;
@end

@implementation MEStaffDetailsTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self customizeBackButton];
    
    [self customAddContactButton];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.title = self.person.name;
    
    [self initStaffDetailCustomViewCells];
    
    [self.tableView reloadData];
}



#pragma mark - Helpers

- (void)customizeBackButton
{
    if (self.navigationItem.backBarButtonItem != nil)
        return;
    
    // Set the custom back button
    UIImage *buttonImage = [UIImage imageNamed:@"icon_back"];
    
    //create the button and assign the image
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:buttonImage forState:UIControlStateNormal];
    
    //set the frame of the button to the size of the image (see note below)
    button.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
    
    [button addTarget:self action:@selector(onBtnBack:) forControlEvents:UIControlEventTouchUpInside];
    
    //create a UIBarButtonItem with the button as a custom view
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = customBarItem;
    
    [button setImage:buttonImage forState:UIControlStateHighlighted];
}

- (void)customAddContactButton
{
//    UIImageView *customButton = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_add_contact"]];
//    [customButton setFrame:CGRectMake(0, 0, 44, 44)];
//    [self.onBtnAddContact setCustomView:customButton];
//    
//    [self. setBackgroundImage:[UIImage imageNamed:@"icon_add_contact"] forState:nil barMetrics:nil];
}

- (void) initStaffDetailCustomViewCells
{
    self.items = [[NSMutableArray alloc] init];
    
    NSString *imageCell;
    NSString *textCell;
    
    imageCell = @"icon_profile";
    textCell = self.person.role;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithUnsignedInt:TAG_AVATAR_CELL], @"tag",
                                 textCell, @"textCell",
                                 [NSNumber numberWithUnsignedInt:64], @"sizeAmount",
                                 [NSNumber numberWithUnsignedInt:5], @"topleft",
                                 nil];
    [self.items addObject:dict];
    
    imageCell = @"icon_email";
    textCell = self.person.userName;
    [self.items addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                           [NSNumber numberWithUnsignedInt:TAG_EMAIL_CELL], @"tag",
                           imageCell, @"imageCell", textCell, @"textCell", nil]];
    
//    if (self.person.contact)
//    {
        imageCell = @"icon_sms";
        textCell = self.person.contact;
        [self.items addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                               [NSNumber numberWithUnsignedInt:TAG_SMS_CELL], @"tag",
                               imageCell, @"imageCell", textCell, @"textCell", nil]];
        
//    }
    
//    if (self.person.like)
//    {
        imageCell = @"icon_like";
        textCell = self.person.like;
        [self.items addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                               [NSNumber numberWithUnsignedInt:0], @"tag",
                               imageCell, @"imageCell", textCell, @"textCell", nil]];
        
//    }

//    if (self.person.dislike)
//    {
        imageCell = @"icon_dislike";
        textCell = self.person.dislike;
        [self.items addObject:[[NSDictionary alloc] initWithObjectsAndKeys:imageCell, @"imageCell",
                               textCell, @"textCell", [NSNumber numberWithUnsignedInt:0], @"tag", nil]];
//    }
    
    if (self.person.visitedCount)
    {
        imageCell = @"icon_star";
        textCell = [NSString stringWithFormat:@"%@ visitors", self.person.visitedCount];
        [self.items addObject:[[NSDictionary alloc] initWithObjectsAndKeys:imageCell, @"imageCell",
                               textCell, @"textCell",[NSNumber numberWithUnsignedInt:0], @"tag", nil]];
    }
    

}





#pragma mark - Actions

- (void)onBtnBack:(id)sender
{
	// Tell the controller to go back
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)onBtnAddContact:(id)sender
{
    NSLog(@"add Contact");
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"StaffDetails";
    MEStaffDetailsCustomViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (!cell)
    {
        cell = [[MEStaffDetailsCustomViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    switch (indexPath.row)
    {
        case 0:            
            [cell.imageCell setFrame:CGRectMake(4, 4, 64, 64)];
            if (self.person.image)
            {
                [cell.imageCell setImageWithURL:[NSURL URLWithString:self.person.image] placeholderImage:[UIImage imageNamed:@"icon_profile"]];
            }
            else
            {
                [cell.imageCell setImage:[UIImage imageNamed:@"icon_profile"]];
            }
            
            cell.textCell.text = self.person.role;
            break;
            
        case 1:
            [cell.imageCell setImage:[UIImage imageNamed:@"icon_email"]];
            cell.textCell.text = self.person.userName;
            break;
            
        case 2:
//            if (!self.person.contact) {
//                [cell setHidden:YES];
//                [cell setFrame:CGRectZero];
//            } else {
//                [cell.imageCell setImage:[UIImage imageNamed:@"icon_sms"]];
//                cell.textCell.text = self.person.contact;
//            }
            [cell.imageCell setImage:[UIImage imageNamed:@"icon_sms"]];
            cell.textCell.text = self.person.contact;
            
            break;
            
        case 3:
            [cell.imageCell setImage:[UIImage imageNamed:@"icon_like"]];
            cell.textCell.text = self.person.like;
            break;
            
        case 4:
            [cell.imageCell setImage:[UIImage imageNamed:@"icon_dislike"]];
            cell.textCell.text = self.person.dislike;
            break;
        case 5:
            [cell.imageCell setImage:[UIImage imageNamed:@"star"]];
            cell.textCell.text = [NSString stringWithFormat:@"%@ visitors", self.person.visitedCount];
            break;
        default:
            break;
    }
    
    [cell.textCell setNumberOfLines:0];
    [cell.textCell setLineBreakMode:NSLineBreakByWordWrapping];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    CGFloat height = 0;
    
    NSString *text = @"";
    
    // Get the text so we can measure it
    
    switch (indexPath.row) {
        case 0:
            text = self.person.role;
            break;
            
        case 1:
            text = self.person.userName;
            break;
            
        case 2:
            text = self.person.contact;
            break;
            
        case 3:
            text = self.person.like;
            break;
            
        case 4:
            text = self.person.dislike;
            break;
            
        case 5:
//            text = self.person.visitedCount;
            text = [NSString stringWithFormat:@"%@ visitors", self.person.visitedCount];
            break;
            
//        default:
//            break;
    }
    
    //UILabel *content = (UILabel *)[[(UITableViewCell *)[(UITableView *)self cellForRowAtIndexPath:indexPath] contentView] viewWithTag:1];
    //text = [items objectAtIndex:indexPath.row];
    
    // Get a CGSize for the width and, effectively, unlimited height
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    // Get the size of the text given the CGSize we just made as a constraint
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:NSLineBreakByCharWrapping];
    
    // Get the height of our measurement
    if (indexPath.row == 0 && size.height < 64)
    {
        size.height = 54;
    }
    height = size.height;
    
    
    // return the height, with a bit of extra padding in
    return height + (CELL_CONTENT_MARGIN * 2);
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    MEStaffDetailsCustomViewCell *cell = (MEStaffDetailsCustomViewCell *)[tableView cellForRowAtIndexPath:indexPath];
//    cell.textLabel.text
    
    if (indexPath.row == 1)
    {
        NSLog(@"send email ");
        [self showComposer:@",\n !"];
    }
    else if (indexPath.row == 2)
    {
        NSLog(@"send sms");
        [self sendInAppSMS];
    }
}




#pragma mark - Tap to open SMS composing dialog

- (void)sendInAppSMS
{
	MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
    picker.messageComposeDelegate = self;

	if([MFMessageComposeViewController canSendText])
	{
		picker.body = @"please type the message";
		picker.recipients = [NSArray arrayWithObjects:self.person.contact, nil];
		picker.messageComposeDelegate = self;
        [self presentViewController:picker animated:YES completion:^(void){}];
	}
}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    UIAlertView *alert;
    
	switch (result) {
		case MessageComposeResultCancelled:
			NSLog(@"Cancelled");
			break;
            
		case MessageComposeResultFailed:
			alert = [[UIAlertView alloc] initWithTitle:@"MiniEvalApp" message:@"Unknown Error" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			break;
		case MessageComposeResultSent:
            
			break;
            
		default:
			break;
	}
    
    [self dismissViewControllerAnimated:YES completion:^(void){}];
}


#pragma mark - Email composition

// Displays an email composition interface inside the application. Populates all the Mail fields.
- (void) displayComposerSheet:(NSString *)body
{
	
	MFMailComposeViewController *tempMailCompose = [[MFMailComposeViewController alloc] init];
	
	tempMailCompose.mailComposeDelegate = self;
	
	[tempMailCompose setToRecipients:[NSArray arrayWithObject:self.person.userName]];
	//[tempMailCompose setCcRecipients:[NSArray arrayWithObject:@"ipad@me.com"]];
	[tempMailCompose setSubject:@"iPhone App recommendation"];
	[tempMailCompose setMessageBody:body isHTML:NO];
	
    tempMailCompose.view.alpha = 0.5;
    [self presentViewController:tempMailCompose animated:YES completion:^(void){
        [UIView animateWithDuration:0.3 animations:^{
            tempMailCompose.view.alpha = 1;
        }];
    }];
}

// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			NSLog(@"Result: canceled");
			break;
		case MFMailComposeResultSaved:
			NSLog(@"Result: saved");
			break;
		case MFMailComposeResultSent:
			NSLog(@"Result: sent");
			break;
		case MFMailComposeResultFailed:
			NSLog(@"Result: failed");
			break;
		default:
			NSLog(@"Result: not sent");
			break;
	}
    
    self.view.alpha = 0.5;
    [self dismissViewControllerAnimated:YES completion:^(void){
        [UIView animateWithDuration:0.3 animations:^{
            self.view.alpha = 1;
        }];
    }];
}

// Launches the Mail application on the device. Workaround
- (void)launchMailAppOnDevice:(NSString *)body
{
	NSString *recipients = [NSString stringWithFormat:@"mailto:%@?subject=%@", self.person.userName, @"iPhone App recommendation"];
	NSString *mailBody = [NSString stringWithFormat:@"&body=%@", body];
	
	NSString *email = [NSString stringWithFormat:@"%@%@", recipients, mailBody];
	email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}

// Call this method and pass parameters
- (void)showComposer:(id)sender
{
	Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil){
		// We must always check whether the current device is configured for sending emails
		if ([mailClass canSendMail]){
			[self displayComposerSheet:sender];
		} else {
			[self launchMailAppOnDevice:sender];
		}
	} else {
		[self launchMailAppOnDevice:sender];
	}
}

@end

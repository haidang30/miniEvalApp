//
//  MEStaffTableViewController.m
//  MiniEvalApp
//
//  Created by viet on 1/21/13.
//  Copyright (c) 2013 2359media. All rights reserved.
//

#import "MEStaffTableViewController.h"

#import "MECompanyAPIClient.h"
#import "MEStaff.h"
#import "MEStaffDetailsTableViewController.h"
#import "MEStaffCustomViewCell.h"
#import "SVPullToRefresh.h"

#define CELL_HEIGHT                 72

@interface MEStaffTableViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
UITabBarControllerDelegate
>

@property (strong, nonatomic) NSMutableArray *results;
@property (strong, nonatomic) NSMutableArray *persons;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicatorView;
@end

@implementation MEStaffTableViewController

#pragma mark - UIViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.activityIndicatorView.hidesWhenStopped = YES;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.activityIndicatorView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                           target:self
                                                                                           action:@selector(onBtnRefresh:)];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorColor = [UIColor clearColor];
    
    
    [self loadDataFromServer];
}




#pragma mark - Actions

- (void)onBtnRefresh:(id)sender
{
    [self.activityIndicatorView startAnimating];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    __weak MEStaffTableViewController *weakSelf = self;
    
    // setup pull-to-refresh
    [self.tableView addPullToRefreshWithActionHandler:^{
        [weakSelf loadDataFromServer];
    }];
    
    [self.tableView triggerPullToRefresh];
}



#pragma mark - Helpers functions

- (void)loadDataFromServer
{
    __weak MEStaffTableViewController *weakSelf = self;
    __weak UIActivityIndicatorView *spinner = self.activityIndicatorView;

    [[MECompanyAPIClient sharedInstance] globalTimelineContactsWithBlock:^(NSMutableArray *results, NSError *error)
     {
         if (error)
         {
             [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil)
                                         message:[error localizedDescription]
                                        delegate:nil
                               cancelButtonTitle:nil
                               otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
         }
         else
         {
             weakSelf.results = results;
             weakSelf.tableView.scrollEnabled = YES;
             [weakSelf.tableView.pullToRefreshView stopAnimating];
         }
         
         [spinner stopAnimating];
         weakSelf.navigationItem.rightBarButtonItem.enabled = YES;
         
         [self reloadUI];
     }];
}

- (void)reloadUI
{
    NSData *personsData = [[NSUserDefaults standardUserDefaults] objectForKey:STAFFS_KEY];
    NSMutableArray *results = [NSKeyedUnarchiver unarchiveObjectWithData:personsData];
    
    if (results != nil)
        [[MECompanyAPIClient sharedInstance] updateHighestVisitedPerson]; // there is nothing returned?
    
    [self.tableView reloadData];
}






#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.results count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Person Item";
    MEStaffCustomViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                                  forIndexPath:indexPath];
    
    if (!cell)
    {
        cell = [[MEStaffCustomViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:CellIdentifier];
    }

    // Configure the cell...
    MEStaff *person = [self.results objectAtIndex:indexPath.row];
    [cell configureWithData:person atIndex:indexPath];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[MEStaffDetailsTableViewController class]])
    {
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        MEStaff *person = [self.results objectAtIndex:indexPath.row];
        //increasing visits time
        person.visitedCount = [[NSNumber alloc] initWithUnsignedInt:[person.visitedCount intValue] + 1];
        
        MEStaffDetailsTableViewController *destinationVC = (MEStaffDetailsTableViewController *)segue.destinationViewController;
        destinationVC.person = person;
    }
}
@end


//     //find highest visited person
//
//     NSMutableArray *results = [[NSMutableArray alloc] init]
//
//     for (int i = 0; i < self.results.count; i++)
//     {
//     MEStaff *person = [self.results objectAtIndex:i]; //
//     NSPredicate *pred = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"SELF.userId = '%@'", person.userId]];
//     NSArray *filtered = [results filteredArrayUsingPredicate:pred];
//     if (filtered.count > 0) {
//     MEStaff *tmp = [filtered objectAtIndex:0];
//     person.visitedCount = tmp.visitedCount;
//     }
//     }
//
//     [MEStaff findHighestVisitedPerson:self.results];

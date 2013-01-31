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

@interface MEStaffTableViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *results;
@property (strong, nonatomic) NSMutableArray *filteredArray;
//@property (nonatomic) NSUInteger highestVisitedCount;

- (void)reload:(id)sender;

@end

@implementation MEStaffTableViewController
{
    @private NSMutableArray *persons;
    __strong UIActivityIndicatorView *_activityIndicatorView;
}

- (void)reload:(id)sender
{
    [_activityIndicatorView startAnimating];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    __weak MEStaffTableViewController *weakSelf = self;
    __weak UIActivityIndicatorView *spinner = _activityIndicatorView;
    
    // setup pull-to-refresh
    [self.tableView addPullToRefreshWithActionHandler:^{
        int64_t delayInSeconds = 0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            [MEStaff globalTimelineContactsWithBlock:^(NSMutableArray *results, NSError *error)
            {
                if (error)
                {
                    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil)
                                                message:[error localizedDescription]
                                               delegate:nil
                                      cancelButtonTitle:nil
                                      otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
                } else
                {
                    weakSelf.results = results;
                    weakSelf.filteredArray = [NSMutableArray arrayWithCapacity:[weakSelf.results count]];
                    
                    [weakSelf reloadInformation];
                    
                    weakSelf.tableView.scrollEnabled = YES;
                    [weakSelf.tableView.pullToRefreshView stopAnimating];
                }
                
               [spinner stopAnimating];
                weakSelf.navigationItem.rightBarButtonItem.enabled = YES;
            }];
            
        });
    }];
    
    [self.tableView triggerPullToRefresh];
}

#pragma mark - UIViewController

- (void)loadView
{
    [super loadView];
    
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    _activityIndicatorView.hidesWhenStopped = YES;
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_activityIndicatorView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                           target:self
                                                                                           action:@selector(reload:)];
    
    self.tableView.rowHeight = 72.0f;
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorColor = [UIColor clearColor];
    
    [self reload:nil];
}


- (void)viewDidUnload
{
    _activityIndicatorView = nil;
    
    [super viewDidUnload];
}

- (void)reloadInformation
{
    
    [self.tableView reloadData];
    
     
    NSData *personsData = [[NSUserDefaults standardUserDefaults] objectForKey:STAFFS_KEY];
    NSMutableArray *results = [[NSMutableArray alloc] init];
    id obj = [NSKeyedUnarchiver unarchiveObjectWithData:personsData];
    NSLog(@"%@", obj);
    results = [NSKeyedUnarchiver unarchiveObjectWithData:personsData];
    
//    if (results != NULL)
//    {
//        for (int i = 0; i < self.results.count; i++)
//        {
//            MEStaff *person = [self.results objectAtIndex:i];
//            NSPredicate *pred = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"SELF.userId = '%@'", person.userId]];
//            NSArray *filtered = [results filteredArrayUsingPredicate:pred];
//            if (filtered.count > 0) {
//                MEStaff *tmp = [filtered objectAtIndex:0];
//                person.visitedCount = tmp.visitedCount;
//            }
//        }
//        
//        [MEStaff findHighestVisitedPerson:self.results];

//    }    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self reloadInformation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    int rows = 0;
    
    if (tableView == self.tableView)
    {
        rows = self.results.count;
    } else if(tableView == self.searchDisplayController.searchResultsTableView)
    {
        rows = self.filteredArray.count;
    }
    
    return rows;
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
    
    if(tableView == self.searchDisplayController.searchResultsTableView)
    {
        person = [self.filteredArray objectAtIndex:indexPath.row];
    }
    
    [cell configureWithData:person atIndex:indexPath];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[MEStaffDetailsTableViewController class]])
    {
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        MEStaff *person = [self.results objectAtIndex:indexPath.row];
        
        if ([sender isKindOfClass:[MEStaffCustomViewCell class]])
        {
            MEStaffCustomViewCell *currentCell = sender;
            
            if ([currentCell.superview isEqual:self.searchDisplayController.searchResultsTableView])
            {
                person = (MEStaff *)[self.filteredArray objectAtIndex:indexPath.row];
            }
        }
        
        MEStaffDetailsTableViewController *destinationVC = (MEStaffDetailsTableViewController *)segue.destinationViewController;
        destinationVC.person = person;
    }
    
    /* 
     NSMutableArray *results = [[NSMutableArray alloc] init]
     
     for (int i = 0; i < self.results.count; i++)
     {
     MEStaff *person = [self.results objectAtIndex:i]; //
     NSPredicate *pred = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"SELF.userId = '%@'", person.userId]];
     NSArray *filtered = [results filteredArrayUsingPredicate:pred];
     if (filtered.count > 0) {
     MEStaff *tmp = [filtered objectAtIndex:0];
     person.visitedCount = tmp.visitedCount;
     }
     }
     
     [MEStaff findHighestVisitedPerson:self.results];
 
    */
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2)
    {
        cell.backgroundColor = UIColorFromRGB(kLightOrganColor);
    }
}



@end

//
//  LSMasterViewController.m
//  LSFindYourAdventure
//
//  Created by Chris Anderson on 7/6/12.
//  Copyright (c) 2012 The Winston Group. All rights reserved.
//

#import "LSMasterViewController.h"
#import "LSMapPoint.h"
#import "LSDetailViewController.h"

@interface LSMasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation LSMasterViewController

@synthesize detailViewController = _detailViewController;
@synthesize adventures = _adventures;
@synthesize adventuresJSON = _adventuresJSON;

- (void)fetchAdventures
{
  {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
      NSData* data = [NSData dataWithContentsOfURL:
                      [NSURL URLWithString: @"http://findyouradventure.herokuapp.com/api/v1/adventures.json"]];
      NSError* error;
      _adventuresJSON = [NSJSONSerialization JSONObjectWithData:data
                                                        options:kNilOptions
                                                          error:&error];
      dispatch_async(dispatch_get_main_queue(), ^{
        [self storeAdventures];
        [self.tableView reloadData];
      });
    });
  }
}

- (void)storeAdventures
{
  for (id adventure in _adventuresJSON) {
    NSLog(@"lat %@ %@", [adventure objectForKey:@"latitude"], [[adventure objectForKey:@"soldout"] class]);
    NSLog(@"%@", adventure);
    CLLocationCoordinate2D loc;
    
    if (![[adventure objectForKey:@"latitude"] isKindOfClass:[NSNull class]]) {
      loc.latitude  = [[adventure objectForKey:@"latitude"] doubleValue];
      loc.longitude  = [[adventure objectForKey:@"longitude"] doubleValue];
      ////    
      ////    // create an instance of bnrmappoint
      NSString *subtitle = [NSString stringWithFormat:@"%@, %@   $%@ %@",
                            [adventure objectForKey:@"city"], [adventure objectForKey:@"state"], [adventure objectForKey:@"price"], [adventure objectForKey:@"sold_out"]];
      LSMapPoint *mp = [[LSMapPoint alloc] initWithCoordinate:loc title:[adventure objectForKey:@"title"] subtitle:subtitle];
      mp.soldout = [[adventure objectForKey:@"sold_out"] boolValue];
      
      [_adventures addObject:mp];
    }
    [self.detailViewController.worldView addAnnotations:_adventures];
    self.detailViewController.allAdventures = [NSArray arrayWithArray:_adventures];
  }
  
  [self.tableView reloadData];
  
}
- (void)awakeFromNib
{
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
      self.clearsSelectionOnViewWillAppear = NO;
      self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
  }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  self.navigationItem.leftBarButtonItem = self.editButtonItem;

  UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
  self.navigationItem.rightBarButtonItem = addButton;
  self.detailViewController = (LSDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
  
  // Intializes your adventures array
  _adventures = [[NSMutableArray alloc] init];
  [self fetchAdventures];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
      return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
  } else {
      return YES;
  }
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return _adventures.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"AdventureCell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
  }

  LSMapPoint *point = [_adventures objectAtIndex:indexPath.row];
  cell.textLabel.text = [point title];
  cell.detailTextLabel.text = [point subtitle];
  return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
    LSMapPoint *coord = [_adventures objectAtIndex:indexPath.row];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord.coordinate, 100000, 100000);
    [self.detailViewController.worldView setRegion:region animated:YES];
    
    NSLog(@"defailt view controller has %@", self.detailViewController.allAdventures);
    [self.detailViewController.worldView selectAnnotation:coord animated:YES];
  }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        LSMapPoint *point = [_adventures objectAtIndex:indexPath.row];
        [[segue destinationViewController] setDetailItem:point];
    }
}

@end

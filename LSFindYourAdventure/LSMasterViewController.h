//
//  LSMasterViewController.h
//  LSFindYourAdventure
//
//  Created by Chris Anderson on 7/6/12.
//  Copyright (c) 2012 The Winston Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LSDetailViewController;

@interface LSMasterViewController : UITableViewController 

- (void)fetchAdventures;
- (void)storeAdventures;

- (IBAction)setStatusFilter:(id)sender;

@property (strong, nonatomic) LSDetailViewController *detailViewController;
@property (nonatomic, readwrite) NSMutableArray *adventures;
@property (nonatomic, readwrite) NSMutableArray *cities;
@property (nonatomic, readwrite) NSArray *allAdventures;
@property (nonatomic, readwrite) NSMutableArray *adventuresJSON;
@property (strong, nonatomic) IBOutlet UISegmentedControl *statusSelector;

@end

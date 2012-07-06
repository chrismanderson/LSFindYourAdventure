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

@property (strong, nonatomic) LSDetailViewController *detailViewController;

@end

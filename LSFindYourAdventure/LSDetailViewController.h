//
//  LSDetailViewController.h
//  LSFindYourAdventure
//
//  Created by Chris Anderson on 7/6/12.
//  Copyright (c) 2012 The Winston Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface LSDetailViewController : UIViewController <UISplitViewControllerDelegate, MKMapViewDelegate>

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) IBOutlet MKMapView *worldView;
@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

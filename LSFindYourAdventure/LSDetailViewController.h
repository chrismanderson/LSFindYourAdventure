//
//  LSDetailViewController.h
//  LSFindYourAdventure
//
//  Created by Chris Anderson on 7/6/12.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface LSDetailViewController : UIViewController <UISplitViewControllerDelegate, MKMapViewDelegate, CLLocationManagerDelegate> {
  CLLocationManager *locationManager;
}


@property (strong, nonatomic) id detailItem;
@property (nonatomic, readwrite) NSArray *allAdventures;
@property (strong, nonatomic) IBOutlet MKMapView *worldView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *statusSelector;
@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
- (IBAction)setStatusFilter:(id)sender;

@end

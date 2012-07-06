//
//  LSDetailViewController.m
//  LSFindYourAdventure
//
//  Created by Chris Anderson on 7/6/12.
//  Copyright (c) 2012 The Winston Group. All rights reserved.
//

#import "LSDetailViewController.h"
#import "LSMasterViewController.h"
#import "LSMapPoint.h"

@interface LSDetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation LSDetailViewController

@synthesize allAdventures = _allAdventures;
@synthesize statusSelector = _statusSelector;
@synthesize detailItem = _detailItem;
@synthesize worldView = _worldView;
@synthesize detailDescriptionLabel = _detailDescriptionLabel;
@synthesize masterPopoverController = _masterPopoverController;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
  

  if (self.detailItem) {
      self.detailDescriptionLabel.text = [self.detailItem description];
  }
}

- (IBAction)setStatusFilter:(id)sender
{
  NSLog(@"%d", _statusSelector.selectedSegmentIndex);
   NSLog(@"all array %@", _allAdventures);
  if (_statusSelector.selectedSegmentIndex == 1) {
    [self setActive];
  } else if (_statusSelector.selectedSegmentIndex == 2) {
    [self setSoldout];
  } else {
    [_worldView removeAnnotations:_worldView.annotations];
    [_worldView addAnnotations:_allAdventures];

  }
}


- (void)setSoldout
{
  NSLog(@"dlf %@", _worldView.annotations);
  NSLog(@"all array %@", _allAdventures);
  
  NSMutableArray *activeAnnotations = [[NSMutableArray alloc] init];
  
  for (LSMapPoint *annotation in _allAdventures) {
    if (!annotation.soldout) {
      [activeAnnotations addObject:annotation];
    }
  }
  
  [_worldView removeAnnotations:_worldView.annotations];
  [_worldView addAnnotations:activeAnnotations];
}

- (void)setActive
{
  NSLog(@"dlf %@", _worldView.annotations);
  
  NSMutableArray *activeAnnotations = [[NSMutableArray alloc] init];
  
  for (LSMapPoint *annotation in _allAdventures) {
    if (annotation.soldout) {
      [activeAnnotations addObject:annotation];
    }
  }
  
  [_worldView removeAnnotations:_worldView.annotations];
  [_worldView addAnnotations:activeAnnotations];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  [self configureView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
  self.detailDescriptionLabel = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
      return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
  } else {
      return YES;
  }
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end

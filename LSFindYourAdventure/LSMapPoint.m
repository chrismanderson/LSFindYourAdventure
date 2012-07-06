//
//  LSMapPoint.m
//  LSFindYourAdventure
//
//  Created by Chris Anderson on 7/6/12.
//  Copyright (c) 2012 The Winston Group. All rights reserved.
//

#import "LSMapPoint.h"

@implementation LSMapPoint

@synthesize coordinate, title, subtitle, soldout;

- (id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t subtitle:(NSString *)s
{
  self = [super init];
  if (self) {
    coordinate = c;
    self.title = t;
    self.subtitle = s;
  }
  return self;
}

- (id)init
{
  return [self initWithCoordinate:CLLocationCoordinate2DMake(43.07, -89.32) title:@"Hometown" subtitle:@"My subtitle"];
}

@end

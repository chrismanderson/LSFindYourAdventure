//
//  LSMapPoint.h
//  LSFindYourAdventure
//
//  Created by Chris Anderson on 7/6/12.
//  Copyright (c) 2012 The Winston Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface LSMapPoint : NSObject <MKAnnotation>

- (id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t subtitle:(NSString *)s;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, assign, getter=isSoldOut) BOOL soldout;

@end

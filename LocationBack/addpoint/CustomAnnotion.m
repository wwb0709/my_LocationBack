//
//  CustomAnnotion.m
//  Notification
//
//  Created by wangwb on 13-4-9.
//
//

#import "CustomAnnotion.h"

@implementation CustomAnnotion

@synthesize coordinate=_coordinate;
@synthesize annotiontype=_annotiontype;

-(id)initWithCoordinate:(CLLocationCoordinate2D)coordinate{
	if (self = [super init]) {
		_coordinate=coordinate;
	}
	return self;
}

-(void)setCoordinate:(CLLocationCoordinate2D)newCoordinate{
	_coordinate=newCoordinate;
}



@end

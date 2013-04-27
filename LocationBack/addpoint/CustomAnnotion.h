//
//  CustomAnnotion.h
//  Notification
//
//  Created by wangwb on 13-4-9.
//
//

#import <MapKit/MapKit.h>

typedef enum
{
	AnnotionType_default = 0,
	AnnotionType_custom = 1,
    AnnotionType_normal = 2,
    AnnotionType_callout = 3
}CustomAnnotionType;
@interface CustomAnnotion : MKShape
{
    @package
    CLLocationCoordinate2D _coordinate;
    CustomAnnotionType annotiontype;
}
@property (nonatomic, assign) CustomAnnotionType annotiontype;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
-(id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;

@end

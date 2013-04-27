//
//  SetPointViewController.h
//  Notification
//
//  Created by kangqijun on 7/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "OneViewController.h"
#import "MKMapView+MyMapViewTouchEvent.h"
#import "CustomAnnotion.h"
#import <QuartzCore/QuartzCore.h>
@interface SetPointViewController : UIViewController <MKMapViewDelegate,MKReverseGeocoderDelegate> {
    MKMapView *m_mapview;
    int tagNum;
    NSString *currentPin;  //当前大头针详情内容
    CustomAnnotion *cpointAnnotation;
    CustomAnnotion *cCallOutAnnotation;

    MKReverseGeocoder *mygeocoder;
}
@property (nonatomic, retain) CustomAnnotion *cCallOutAnnotation;
@property (nonatomic, retain) CustomAnnotion *cpointAnnotation;
@property (nonatomic, retain) MKReverseGeocoder *mygeocoder;
@end

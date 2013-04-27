//
//  AppDelegate.h
//  LocationBack
//
//  Created by wangwb on 13-4-12.
//  Copyright (c) 2013年 wangwb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CLLocation.h>
#import <CoreLocation/CLLocationManager.h>
#import <CoreLocation/CLLocationManagerDelegate.h>
#import <CoreLocation/CoreLocation.h>
#import "mapViewController.h"
@class ViewController;
@class DDMenuController;
@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate,MapViewControllerDidSelectDelegate>
{
    double m_lat;
    double m_lon;
    NSString * m_name;
    NSMutableArray* g_laopai;
}
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) DDMenuController *menuController;


@property (nonatomic, retain) CLLocationManager *m_locationmanager;
@property (nonatomic, retain) NSMutableArray* g_laopai;
@property (nonatomic, assign)  BOOL inBackground;
- (void)addPoint:( NSMutableDictionary *)point;
@end

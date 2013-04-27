//
//  AppDelegate.m
//  LocationBack
//
//  Created by wangwb on 13-4-12.
//  Copyright (c) 2013年 wangwb. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import "mapViewController.h"

#import "DDMenuController.h"
#import "MeunViewController.h"
@implementation AppDelegate
@synthesize m_locationmanager,g_laopai,inBackground;
@synthesize menuController = _menuController;
- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIDevice* device = [UIDevice currentDevice];
    BOOL backgroundSupported = NO;
    if ([device respondsToSelector:@selector(isMultitaskingSupported)])
        backgroundSupported = device.multitaskingSupported;
    
    NSLog(@"backgroundSupported[%@]",backgroundSupported ? @"YES" : @"NO");
    
    self.g_laopai = [[NSMutableArray alloc]init];
    
    
    m_locationmanager = [[CLLocationManager alloc] init];
    m_locationmanager.delegate = self;
    
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];

    
    DDMenuController *rootController = [[DDMenuController alloc] initWithRootViewController:nil];
    _menuController = rootController;
    
    
    //添加左边的
    MeunViewController *leftController = [[MeunViewController alloc] init];
    rootController.leftViewController = leftController;
    
    [leftController setMainViewController];
    
    


    self.window.rootViewController = rootController;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    //点击通知进入程序的时候执行的操作  userinfo是通知的方法传的参数
    //    NSDictionary *dic = [notification userInfo];
}

#pragma mark CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    double lat = newLocation.coordinate.latitude;
    double lon = newLocation.coordinate.longitude;
    
    m_lat = lat;
    m_lon = lon;
    
    NSLog(@"lat = %f,lon = %f",lat,lon);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)err
{
    NSLog(@"location error : %@",err);
}

- (void)scheduleAlarmForDate:(NSDate *)theDate name:(NSString *)name distance:(float)distance{
    
    NSLog(@"alarm");
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *oldNotifications = [app scheduledLocalNotifications];
    
    // Clear out the old notification before scheduling a new one.
    if (0 < [oldNotifications count]) {
        
        [app cancelAllLocalNotifications];
    }
    
    // Create a new notification
    UILocalNotification *alarm = [[UILocalNotification alloc] init];
    if (alarm) {
        
        alarm.fireDate = theDate;
        alarm.timeZone = [NSTimeZone defaultTimeZone];
        alarm.repeatInterval = 0;
        alarm.soundName = @"ping.caf";
        
        alarm.alertBody = [NSString stringWithFormat:@"发现%@距离你还有%lf米",name,distance];
        
        alarm.userInfo = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObject:name] forKeys:[NSArray arrayWithObject:@"name"]];
        
        [app scheduleLocalNotification:alarm];
        [alarm release];
        
        m_name = [NSString stringWithString:name];
    }
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    NSLog(@"background");
    
    self.inBackground = YES;
    [self.m_locationmanager stopUpdatingLocation];
    
    UIBackgroundTaskIdentifier __block bgTask;
    bgTask = [application beginBackgroundTaskWithExpirationHandler:^{
        // Clean up any unfinished task business by marking where you.
        // stopped or ending the task outright.
        [application endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
    }];
    
    // Start the long-running task and return immediately.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (self.inBackground) {
            [self startLocationServices];
            [NSThread sleepForTimeInterval:(60)];
            
            [self culcate];
            
            [self stopLocationServices];
            [NSThread sleepForTimeInterval:(60)];
            
        }
        
        [application endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
    });
    
}





- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    self.inBackground = FALSE;
    [m_locationmanager stopUpdatingLocation];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"stop into");
    
    self.inBackground = FALSE;
    [m_locationmanager stopUpdatingLocation];
}




#pragma mark userself
- (void)startLocationServices{
    [self.m_locationmanager startUpdatingLocation];
    NSLog(@"timer start location service here");
    NSLog(@"%f",[UIApplication sharedApplication].backgroundTimeRemaining);
}

- (void)stopLocationServices{
    [self.m_locationmanager stopUpdatingLocation];
    NSLog(@"timer stop location service here");
    NSLog(@"%f",[UIApplication sharedApplication].backgroundTimeRemaining);
}

- (void)culcate
{
    NSLog(@"run background");
    NSLog(@"m_lat = %f,m_lon = %f",m_lat,m_lon);
    
    CLLocationDistance distance;
    CLLocation *locstart = [[CLLocation alloc]initWithLatitude:m_lat longitude:m_lon];
    //    CLLocation *locend = [[CLLocation alloc]init];
    
    //    NSDate *oneMinuteFromNow = [NSDate dateWithTimeIntervalSinceNow:10];
    //[self scheduleAlarmForDate:oneMinuteFromNow name:@"xiaochi"];
    
    //    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    //    NSLog(@"http://www.baidu.com %@",[data description]);
    distance = 100000;
    
    int i = 0;
    int j = 100;
    
    for(NSDictionary *data in g_laopai)
    {
        CLLocationDegrees latitude=[[data objectForKey:@"latitude"] doubleValue];
        CLLocationDegrees longitude=[[data objectForKey:@"longitude"] doubleValue];
        CLLocation *locend = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
        
        if(distance > [locstart distanceFromLocation:locend])
        {
            distance = [locstart distanceFromLocation:locend];
            j = i;
        }
        
        [locend release];
        
        i++;
    }
    
    if(distance < 1000)
    {
        NSLog(@"distance = %f",distance);
        
        NSString *name = @" ";
        if(j <= g_laopai.count - 1)
        {
            name = [[g_laopai objectAtIndex:j] objectForKey:@"name"];
        }
        
        if(![m_name isEqualToString:name])
        {
            NSDate *oneMinuteFromNow = [NSDate dateWithTimeIntervalSinceNow:10];
            [self scheduleAlarmForDate:oneMinuteFromNow name:name distance:distance];
        }
    }
    
    [locstart release];
}

- (void)customMKMapViewDidSelectedWithInfo:(id)info
{
    NSLog(@"%@",info);
}


- (void)addPoint:( NSMutableDictionary *)point
{
    [self.g_laopai addObject:point];
}

@end

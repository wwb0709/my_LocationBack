//
//  mapViewController.m
//  Example
//
//  Created by wangwb on 13-1-15.
//  Copyright (c) 2013年 szty. All rights reserved.
//

#import "mapViewController.h"
#import "grayView.h"
#import "CustomAnnotion.h"
#import "CustomAnnotionView.h"
#import "JingDianMapCell.h"
#import "AppDelegate.h"
#import "grayView.h"
#define span1 40000
@interface mapViewController ()
{
    CustomAnnotion *_calloutAnnotation;

    
}
@property (nonatomic, retain) CustomAnnotion *cpointAnnotation;
-(void)setAnnotionsWithList:(NSArray *)list;
@end

@implementation mapViewController
@synthesize delegate,onEnter,onCancel,cpointAnnotation;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
    _mapview.frame = self.view.frame;
    // Do any additional setup after loading the view from its nib.
    _mapview.showsUserLocation = YES;
    
//    grayView *  m_shadowView = [[grayView alloc] initWithFrame:self.navigationController.view.frame];
//     m_shadowView.backgroundColor = [UIColor blackColor];
//    
//    m_shadowView.userInteractionEnabled = NO;
//     m_shadowView.alpha = 0.4;
//    [self.view addSubview:m_shadowView];
//    [m_shadowView release];
  
//    CLLocationCoordinate2D theCoordinate = {39.91234846,116.454018};
// 
//    
//    //（3）设定显示范围
//    MKCoordinateSpan theSpan;
//    theSpan.latitudeDelta=0.02;
//    theSpan.longitudeDelta=0.02;
//    
//    //（4）设置地图显示的中心及范围
//    MKCoordinateRegion theRegion;
//    theRegion.center=theCoordinate;
//    theRegion.span=theSpan;
//    
//    //（5）设置地图显示的类型及根据范围进行显示
//    [_mapview setRegion:theRegion];
//    [_mapview setMapType:MKMapTypeStandard];
    
    
//    UILongPressGestureRecognizer *lpress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(tapPress:)];
//    lpress.minimumPressDuration = 0.5;//按0.5秒响应longPress方法
//    lpress.allowableMovement = 10.0;
//    [_mapview addGestureRecognizer:lpress];//m_mapView是MKMapView的实例
//    [lpress release];
    
//    UITapGestureRecognizer *mTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPress:)];
//    [_mapview addGestureRecognizer:mTap];
//    [mTap release];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     AppDelegate *de = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [self setAnnotionsWithList:de.g_laopai];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_mapview release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setMapview:nil];
    [super viewDidUnload];
}
-(void)setAnnotionsWithList:(NSArray *)list
{
    for (NSDictionary *dic in list) {
        
        CLLocationDegrees latitude=[[dic objectForKey:@"latitude"] doubleValue];
        CLLocationDegrees longitude=[[dic objectForKey:@"longitude"] doubleValue];
        
        CLLocationCoordinate2D theCoordinate;
        theCoordinate.latitude = latitude;
        theCoordinate.longitude = longitude;
        CustomAnnotion *pointAnnotation = [[CustomAnnotion alloc] init];
        //位置
        pointAnnotation.coordinate = theCoordinate;
        pointAnnotation.annotiontype = AnnotionType_callout;
        pointAnnotation.title = [dic objectForKey:@"name"];
         pointAnnotation.subtitle = [dic objectForKey:@"subname"];
        [_mapview   addAnnotation:pointAnnotation];
        [pointAnnotation release];
    }
}


- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {

//	if ([view.annotation isKindOfClass:[BasicMapAnnotation class]]) {
//        if (cpointAnnotation.coordinate.latitude == view.annotation.coordinate.latitude&&
//            cpointAnnotation.coordinate.longitude == view.annotation.coordinate.longitude) {
//            return;
//        }
//        return;
//        if (_calloutAnnotation) {
//            [mapView removeAnnotation:_calloutAnnotation];
//            _calloutAnnotation = nil;
//        }
//        BasicMapAnnotation *annotation = view.annotation;
////        _calloutAnnotation = [[[BasicMapAnnotation alloc]
////                               initWithLatitude:view.annotation.coordinate.latitude
////                               andLongitude:view.annotation.coordinate.longitude andName:annotation.title] autorelease];
//        
//        _calloutAnnotation=[[[BasicMapAnnotation alloc] initWithLatitude:view.annotation.coordinate.latitude andLongitude:view.annotation.coordinate.longitude]  autorelease];
//        _calloutAnnotation.title = annotation.title;
//        [mapView addAnnotation:_calloutAnnotation];
//        
//        [mapView setCenterCoordinate:_calloutAnnotation.coordinate animated:YES];
//	}
//    else{
//        if([delegate respondsToSelector:@selector(customMKMapViewDidSelectedWithInfo:)]){
//            [delegate customMKMapViewDidSelectedWithInfo:@"点击至之后你要在这干点啥"];
//        }
//    }
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view{

}

- (MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]])
    {
        return nil;
    }
    /*
     定义中用到的标注属性
     image 标注图片
     pinColor 颜色//MKPinAnnotationColorRed ,MKPinAnnotationColorGreen,MKPinAnnotationColorPurple
     canShowCallout／／是否弹出
     animatesDrop／／落下动画
     centerOffset／／大头针偏移量
     annotationView.calloutOffset／／标注偏移量
     rightCalloutAccessoryView／／右边点击按钮
     leftCalloutAccessoryView／／左边点击按钮
     */
    static NSString *AnnotationIdentifier = @"AnnotationIdentifier";
    
    //    MKPinAnnotationView *customPinView = (MKPinAnnotationView *)[mV
    //                                            dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifier];
    //        //初始化大头针对象
    //    if (!customPinView) {
    //        customPinView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier] autorelease];
    //
    //
    //    }else{
    //        customPinView.annotation = annotation;
    //    }
    
    
    
    CustomAnnotion *pointAnnotation =  annotation;
    if (pointAnnotation.annotiontype ==AnnotionType_normal) {
        MKPinAnnotationView *customPinView = (MKPinAnnotationView *)[mV
                                                                     dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifier];
        //初始化大头针对象
        if (!customPinView) {
            customPinView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier] autorelease];
            
            
        }else{
            customPinView.annotation = annotation;
        }
        customPinView.pinColor = MKPinAnnotationColorRed;//设置大头针的颜色
        customPinView.animatesDrop = YES;                //坠落动画
        ///        customPinView.image = [UIImage imageNamed:@"pin.png"];
        return customPinView;
    }
    else if (pointAnnotation.annotiontype ==AnnotionType_default) {
        MKAnnotationView *customPinView = (MKAnnotationView *)[mV
                                                               dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifier];
        //初始化大头针对象
        if (!customPinView) {
            customPinView = [[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier] autorelease];
            
            
        }else{
            customPinView.annotation = annotation;
        }
        //        customPinView.pinColor = MKPinAnnotationColorPurple;//设置大头针的颜色
        //        customPinView.animatesDrop = YES;                //坠落动画
        customPinView.image = [UIImage imageNamed:@"pin.png"];
        return customPinView;
    }
    else if (pointAnnotation.annotiontype ==AnnotionType_custom)
    {
        CustomAnnotionView *customPinView = (CustomAnnotionView *)[mV
                                                                   dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifier];
        //初始化大头针对象
        if (!customPinView) {
            customPinView = [[[CustomAnnotionView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier] autorelease];
            JingDianMapCell  *cell = [[[NSBundle mainBundle] loadNibNamed:@"JingDianMapCell" owner:self options:nil] objectAtIndex:0];
            cell.tag = 10000;
            [customPinView.contentView addSubview:cell];
            
        }else{
            customPinView.annotation = annotation;
        }
        //        customPinView.pinColor = MKPinAnnotationColorRed;//设置大头针的颜色
        //        customPinView.animatesDrop = YES;                //坠落动画
        //        customPinView.canShowCallout = YES;              //显示详情
        //
        //        //添加导航按钮
        //        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        //        [rightButton addTarget:self action:@selector(showDetails:) forControlEvents:UIControlEventTouchUpInside];
        //        customPinView.rightCalloutAccessoryView = rightButton;
        //       customPinView.image = [UIImage imageNamed:@"pin.png"];
        JingDianMapCell  *cell =  (JingDianMapCell*)[customPinView.contentView viewWithTag:10000];
        cell.title.text = pointAnnotation.title;
        cell.subtitle.text = pointAnnotation.subtitle;
        
        return customPinView;
    }
    else if(pointAnnotation.annotiontype == AnnotionType_callout)
    {
        MKPinAnnotationView *customPinView = (MKPinAnnotationView *)[mV
                                                                     dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifier];
        //初始化大头针对象
        if (!customPinView) {
            customPinView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier] autorelease];
            
            
        }else{
            customPinView.annotation = annotation;
        }
        customPinView.pinColor = MKPinAnnotationColorRed;//设置大头针的颜色
        customPinView.animatesDrop = YES;                //坠落动画
        customPinView.canShowCallout = YES;              //显示详情
        //
        //添加导航按钮
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [rightButton addTarget:self action:@selector(showDetails:) forControlEvents:UIControlEventTouchUpInside];
        customPinView.rightCalloutAccessoryView = rightButton;
        
        
        return customPinView;
    }
    return nil;
}

//更新用户自己的位置
-(void) mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{

    MKCoordinateSpan span;
    
    MKCoordinateRegion region;
    
    
    
    span.latitudeDelta=0.010;
    
    span.longitudeDelta=0.010;
    
    region.span=span;
    
    region.center=[userLocation coordinate];
    
    [_mapview setRegion:[_mapview regionThatFits:region] animated:YES];
    
//    _mapview.showsUserLocation = NO;
    
}
-(void)showDetails:(id)sender
{
    
    //通过坐标查位置描述
    MKReverseGeocoder* g = [[MKReverseGeocoder alloc] initWithCoordinate:self.cpointAnnotation.coordinate];
    g.delegate = self;
    [g start];
    
   

}
//- (void)resetAnnitations:(NSArray *)data
//{
//    [_annotationList removeAllObjects];
//    [_annotationList addObjectsFromArray:data];
//
//}


- (void)tapPress:(UIGestureRecognizer*)gestureRecognizer {
    


    CGPoint touchPoint = [gestureRecognizer locationInView:_mapview];//这里touchPoint是点击的某点在地图控件中的位置
    CLLocationCoordinate2D touchMapCoordinate =
    [_mapview convertPoint:touchPoint toCoordinateFromView:_mapview];//这里touchMapCoordinate就是该点的经纬度了
    
    float longtitude = touchMapCoordinate.longitude;
    
    float latitude = touchMapCoordinate.latitude;
    
    if (longtitude<0||latitude<0) {
        return;
    }
    NSLog(@"---current tap longtitude%@",[NSString stringWithFormat:@"%f",longtitude]);
    NSLog(@"---current tap latitude%@",[NSString stringWithFormat:@"%f",latitude]);
   
//     AppDelegate *delegate1 = (AppDelegate*)[UIApplication sharedApplication].delegate;
//    [self setAnnotionsWithList:delegate1.g_laopai];
    
//    if (self.cpointAnnotation) {
//        //[_mapview removeAnnotation:self.cpointAnnotation];
//        //[m_mapview deselectAnnotation:self.cpointAnnotation animated:YES];
//    }
//    else
    {
        if (self.cpointAnnotation) {
            [self.cpointAnnotation release];
        }
        CustomAnnotion *pointAnnotation = [[CustomAnnotion alloc] init];
        self.cpointAnnotation = pointAnnotation;
        [pointAnnotation release];
    }
//    self.cpointAnnotation.tag = YES;
    //位置
    self.cpointAnnotation.coordinate = touchMapCoordinate;
    //显示标题
    self.cpointAnnotation.title = [NSString stringWithFormat:@"%f %f",self.cpointAnnotation.coordinate.latitude,self.cpointAnnotation.coordinate.longitude];

    [_mapview addAnnotation:self.cpointAnnotation];
    //[_mapview selectAnnotation:self.cpointAnnotation animated:YES];
    

    
  
}




#pragma mark MKReverseGeocoderDelegate
- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error {
    NSLog(@"Error resolving coordinates: %@", [error localizedDescription]);
    geocoder.delegate = nil;
    [geocoder autorelease];
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark  {
    NSString *streetAddress = placemark.thoroughfare;
    NSString *city = placemark.locality;
    NSString *state = placemark.administrativeArea;
    NSString *zip = placemark.postalCode;
    // Do something with information
    NSLog(@"%@ %@ %@ %@",streetAddress,city,state,zip);
    
    UILabel* locationlable = (UILabel*)[self.view viewWithTag:10002];
    NSMutableString * str = [NSMutableString string];
    if (state) {
        [str appendString:state];
    }
    if (city) {
        [str appendString:@" "];
        [str appendString:city];
    }
    if (streetAddress) {
        [str appendString:@" "];
        [str appendString:streetAddress];
    }
    if (zip) {
        [str appendString:@" "];
        [str appendString:zip];
    }
    
//    OneViewController *oneController = [[OneViewController alloc] init];
//    //给Controller的标题赋值
//    oneController.title = @"地址";
//    [self.navigationController pushViewController:oneController animated:YES];
//    //给Controller的label赋值
//    [oneController setLabelText:str];
//    [oneController release];
//    
//    locationlable.text = str;
    
    
    
    
    float longtitude = self.cpointAnnotation.coordinate.longitude;
    
    float latitude = self.cpointAnnotation.coordinate.latitude;
    
    if (longtitude<0||latitude<0) {
        return;
    }
    NSLog(@"---current tap longtitude%@",[NSString stringWithFormat:@"%f",longtitude]);
    NSLog(@"---current tap latitude%@",[NSString stringWithFormat:@"%f",latitude]);
    
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%f",latitude],@"latitude",[NSString stringWithFormat:@"%f",longtitude],@"longitude",nil];
    
    
    self.onEnter =^(NSString *txt){
        if (txt.length>0) {
            NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] init];
            [mutableDic setDictionary:dic];
            [mutableDic setObject:txt forKey:@"name"];
            self.cpointAnnotation.title = [NSString stringWithFormat:@"你设置的位置:%@",txt];
  
            AppDelegate *tdelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
            [tdelegate addPoint:mutableDic];
            [mutableDic release];

        }
    };
    self.onCancel = ^(void){};
    ShakingAlertView *alert = [[ShakingAlertView alloc] initWithAlertTitle:@"输入名称" onEnter:self.onEnter onCancel:self.onCancel] ;
    alert.defalutcontent = str;
    
    [alert show];
    
    geocoder.delegate = nil;
    [geocoder autorelease];
}

@end

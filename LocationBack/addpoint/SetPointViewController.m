//
//  SetPointViewController.m
//  Notification
//
//  Created by kangqijun on 7/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SetPointViewController.h"
#import "grayView.h"
#import "CustomAnnotion.h"
#import "CustomAnnotionView.h"
#import "JingDianMapCell.h"
#import "AppDelegate.h"


@implementation SetPointViewController
@synthesize cpointAnnotation,cCallOutAnnotation,mygeocoder;

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
-(void)viewWillAppear:(BOOL)animated{
    //隐藏导航栏
//    [self.navigationController setNavigationBarHidden:YES];
}
/*********************
 使用谷歌地图需要导入MapKit.framework,同时在.h内 #import <MapKit/MapKit.h>
 ************************/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];

    int naviheight = self.navigationController.navigationBar.frame.size.height;
    //地图
    //创建地图视图，初始化参数
    m_mapview = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-naviheight)];
    //设置地图的代理
    m_mapview.delegate = self;
    [self.view addSubview:m_mapview];
    
    //地图覆层
    grayView *  m_shadowView = [[grayView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-naviheight)];
    m_shadowView.backgroundColor = [UIColor clearColor];
    
    m_shadowView.userInteractionEnabled = NO;
//    m_shadowView.alpha = 0.4;
    m_shadowView.tag = 10000;
    [self.view addSubview:m_shadowView];
    [m_shadowView release];
    
    
    //标题
    CGRect titleRect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-naviheight);
    CGSize size = titleRect.size;
    titleRect.size = CGSizeMake(size.width, 30);
    
    CGPoint point = titleRect.origin;
    point.y = size.height-30;
    titleRect.origin = point;
    UILabel * titleLable = [[UILabel alloc] initWithFrame:titleRect];
    titleLable.backgroundColor = [UIColor blackColor];
    titleLable.alpha = 0.6;
    titleLable.text = @"移动地图点击选择位置";
    //设置字体:粗体，正常的是 SystemFontOfSize
    titleLable.font = [UIFont boldSystemFontOfSize:15];
    //设置文字颜色
    titleLable.textColor = [UIColor redColor];
    //设置文字位置
    titleLable.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:titleLable];
    [titleLable release];
    
    //位置

    
//    point = titleRect.origin;
//    point.y = size.height-50;
//  
//    
//    CGRect locationRect = CGRectMake(point.x, point.y, size.width, 20);
//    UILabel * locationLable = [[UILabel alloc] initWithFrame:locationRect];
//    locationLable.backgroundColor = [UIColor blackColor];
//    locationLable.alpha = 0.8;
//    locationLable.text = @"";
//    //设置字体:粗体，正常的是 SystemFontOfSize
//    locationLable.font = [UIFont boldSystemFontOfSize:15];
//    //设置文字颜色
//    locationLable.textColor = [UIColor yellowColor];
//    //设置文字位置
//    locationLable.textAlignment = UITextAlignmentRight;
//    locationLable.tag = 10002;
//    [self.view addSubview:locationLable];
//    [locationLable release];
    
    
    
        //地图的类型：MKMapTypeStandard 显示街道和道路 MKMapTypeSatellite 显示卫星 MKMapTypeHybrid 显示混合地图
    [m_mapview setMapType:MKMapTypeStandard];
    
        //显示用户当前的坐标，打开地图有相应的提示
    m_mapview.showsUserLocation=YES;
//
        //定义经纬坐标
//    CLLocationCoordinate2D theCoordinate;
//    theCoordinate.latitude = 32.05000;
//    theCoordinate.longitude = 118.78333;
//    
//        //定义显示的范围
//    MKCoordinateSpan theSpan;
//    theSpan.latitudeDelta=0.1;
//    theSpan.longitudeDelta=0.1;
//        //定义一个区域（用定义的经纬度和范围来大小来定义）
//    MKCoordinateRegion theRegion;
//    theRegion.center=theCoordinate;
//    theRegion.span=theSpan;
//        //在地图上显示此区域
//    [m_mapview setRegion:theRegion animated:YES];
//    
//    
//    {
//        CustomAnnotion *pointAnnotation = [[CustomAnnotion alloc] init];
//        //位置
//        pointAnnotation.coordinate = theCoordinate;
//        //显示标题
//        pointAnnotation.title = nil;
//        pointAnnotation.annotiontype = AnnotionType_default;
//        
//        [m_mapview addAnnotation:pointAnnotation];
//        //[m_mapview selectAnnotation:pointAnnotation animated:YES];
//        [pointAnnotation release];
//
//    }



//    UILongPressGestureRecognizer *lpress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handlePress:)];
//    lpress.minimumPressDuration = 0.5;//按0.5秒响应longPress方法
//    lpress.allowableMovement = 10.0;
//    [m_mapview addGestureRecognizer:lpress];
//    [lpress release];
//  
    UITapGestureRecognizer *tpress = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handlePress:)];
    [m_mapview addGestureRecognizer:tpress];
    [tpress release];
    

//    UISwipeGestureRecognizer    *swip=[[[UISwipeGestureRecognizer    alloc]
//                                        initWithTarget:self action:@selector(handlePress:)]autorelease];   //BackFormswip这个是自己自定义的函数，可在此函数中做想做的事情
//    
//    swip.direction=UISwipeGestureRecognizerDirectionRight|UISwipeGestureRecognizerDirectionLeft;    
//    [self.view addGestureRecognizer:swip];  // （注意最后一句应该这么写的才行）
//    UIPinchGestureRecognizer *twoFingerPinch =[[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePress:)] autorelease];
//    [[self.view viewWithTag:10000] addGestureRecognizer:twoFingerPinch];
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_menu_icon.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(done:)];
    self.navigationItem.rightBarButtonItem = button;
}

-(void)done:(id)sender
{
    if (!self.cpointAnnotation) {
        return;
    }
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%f",self.cpointAnnotation.coordinate.latitude],@"latitude",[NSString stringWithFormat:@"%f",self.cpointAnnotation.coordinate.longitude],@"longitude",nil];
    
    

    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] init];
    [mutableDic setDictionary:dic];
    [mutableDic setObject:self.cpointAnnotation.title forKey:@"name"];
    [mutableDic setObject:self.cpointAnnotation.subtitle forKey:@"subname"];
    
    AppDelegate *tdelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [tdelegate addPoint:mutableDic];
    
    NSLog(@"done left");
}


- (void)handlePress:(UIGestureRecognizer*)gestureRecognizer{
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded){
        tagNum++;
            //取地图上的长按的点坐标
        CGPoint touchPoint = m_mapview.center;//[gestureRecognizer locationInView:m_mapview];
            //将点坐标转换为经纬度坐标
        CLLocationCoordinate2D touchMapCoordinate =
        [m_mapview convertPoint:touchPoint toCoordinateFromView:m_mapview];
        NSLog(@"%f   %f",touchMapCoordinate.latitude,touchMapCoordinate.longitude);
            //初始化详情弹出框对象
        if (self.cpointAnnotation) {
            [m_mapview removeAnnotation:self.cpointAnnotation];
             //[m_mapview deselectAnnotation:self.cpointAnnotation animated:YES];
        }
        else
        {
            CustomAnnotion *pointAnnotation = [[CustomAnnotion alloc] init];
            self.cpointAnnotation = pointAnnotation;
            [pointAnnotation release];
        }
        self.cpointAnnotation.annotiontype = AnnotionType_callout;
            //位置
        self.cpointAnnotation.coordinate = touchMapCoordinate;
            //显示标题
        self.cpointAnnotation.title = @"选中位置坐标：";
        self.cpointAnnotation.subtitle = [NSString stringWithFormat:@"%f %f",touchMapCoordinate.latitude,touchMapCoordinate.longitude];
        [m_mapview addAnnotation:self.cpointAnnotation];
        [m_mapview selectAnnotation:self.cpointAnnotation animated:YES];
        
        
//        if (self.mygeocoder) {
//            [self.mygeocoder cancel];
//            [self.mygeocoder release];
//        }

       
    }
}

/**********************************************
 函数名称 : viewForAnnotation
 函数描述 : 在地图上加入大头针，及其动画。
 输入参数 : mapView，theMapView，annotation。
 输出参数 : N/A 
 返回值	: N/A
 *********************************************/
- (MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation{
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

- (void)showDetails:(UIButton*)sender
{
    
    //通过坐标查位置描述
    MKReverseGeocoder* g = [[MKReverseGeocoder alloc] initWithCoordinate:self.cpointAnnotation.coordinate];
    g.delegate = self;
    [g start];
    
    
    
}

/**********************************************
 函数名称 : didSelectAnnotationView
 函数描述 : 点击大头针时调用此方法
 输入参数 : mapView，view。
 输出参数 : N/A 
 返回值	: N/A
 *********************************************/
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view 
{
        //点击大头针时，取出其详情信息
    MKPointAnnotation *currentAnnotation = (MKPointAnnotation *)view.annotation;
    currentPin = currentAnnotation.subtitle;
    

    if ([view.annotation isKindOfClass:[CustomAnnotion class]]) {
        CustomAnnotion* tmpannotion = view.annotation;
        if (tmpannotion.annotiontype ==AnnotionType_callout) {
            return;
        }
        
        if (cCallOutAnnotation.coordinate.latitude == view.annotation.coordinate.latitude&&
            cCallOutAnnotation.coordinate.longitude == view.annotation.coordinate.longitude) {
            return;
        }
       
        if (cCallOutAnnotation) {
            [mapView removeAnnotation:cCallOutAnnotation];
            cCallOutAnnotation = nil;
        }
//        if (cpointAnnotation) {
//            [mapView removeAnnotation:cpointAnnotation];
//            cpointAnnotation = nil;
//        }
        cCallOutAnnotation = [[[CustomAnnotion alloc]
                               initWithCoordinate:view.annotation.coordinate] autorelease];
        cCallOutAnnotation.title = view.annotation.title;
        cCallOutAnnotation.subtitle = view.annotation.subtitle;
        cCallOutAnnotation.annotiontype = AnnotionType_callout;
        [mapView addAnnotation:cCallOutAnnotation];
        
//        [mapView setCenterCoordinate:cCallOutAnnotation.coordinate animated:YES];
	}
    
}
- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    if (cCallOutAnnotation&& ![view isKindOfClass:[CustomAnnotionView class]]) {
        if (cCallOutAnnotation.coordinate.latitude == view.annotation.coordinate.latitude&&
            cCallOutAnnotation.coordinate.longitude == view.annotation.coordinate.longitude) {
//            [mapView removeAnnotation:cCallOutAnnotation];
//            cCallOutAnnotation = nil;
        }
    }
}
    //拖动地图，改变地图比例时调用此方法
/**********************************************
 函数名称 : regionWillChangeAnimated
 函数描述 : 拖动地图，改变地图比例时调用此方法
 输入参数 : mapView，animated。
 输出参数 : N/A 
 返回值	: N/A
 *********************************************/
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//更新用户自己的位置
-(void) mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
//    NSString *lat=[[NSString alloc] initWithFormat:@"%f",userLocation.coordinate.latitude];
//    
//    NSString *lng=[[NSString alloc] initWithFormat:@"%f",userLocation.coordinate.longitude];
    
    
    
//    userLatitude=lat;
//    
//    userlongitude=lng;
    
    
    
    MKCoordinateSpan span;
    
    MKCoordinateRegion region;
    
    
    
    span.latitudeDelta=0.010;
    
    span.longitudeDelta=0.010;
    
    region.span=span;
    
    region.center=[userLocation coordinate];

    [m_mapview setRegion:[m_mapview regionThatFits:region] animated:YES];

}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    for (MKAnnotationView *annotationView in views)
        
    {
        
        //判断annotation 是否是MKUserLocation
        
        if ([annotationView.annotation isKindOfClass:[MKUserLocation class]])
            
        {
            
            continue;
            
        }
        
        else if ([annotationView isKindOfClass:[CustomAnnotionView class]])
            
        {
            
            //因为是自定义的Annotation 所以动画要自己加
            
            
     
     
            
            NSLog(@"%f%f",annotationView.frame.origin.x,annotationView.frame.origin.y);
            
            
            CGSize size = annotationView.frame.size;
            //创建一个新的动画块
            
            [CATransaction begin];
            
            //设置动画时间
            
            [CATransaction setValue:[NSNumber numberWithFloat:0.3f] forKey :kCATransactionAnimationDuration];
            
            CABasicAnimation *shrinkAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            
            shrinkAnimation.delegate =self;
            
            shrinkAnimation.timingFunction =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            
            shrinkAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
            
            shrinkAnimation.toValue = [NSNumber numberWithFloat:1.0f];
            
            annotationView.frame = CGRectMake(annotationView.frame.origin.x, annotationView.frame.origin.y, size.width, size.height);
            
            [[annotationView layer] addAnimation:shrinkAnimation forKey:@"shrinkAnimation"];
            
            
//            
//            //创建连续弹跳动画
//            
//            CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//            
//            CGMutablePathRef positionPath = CGPathCreateMutable();
//            
//            CGPathMoveToPoint(positionPath, NULL, [annotationView layer].position.x, [annotationView layer].position.y);
//            
//            
//            
//            CGPathAddLineToPoint(positionPath, NULL, annotationView.frame.origin.x+8, annotationView.frame.origin.y+35);
//            
//            positionAnimation.path = positionPath;
//            
//            positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
//            
//            
//            
//            annotationView.frame = CGRectMake(annotationView.frame.origin.x, annotationView.frame.origin.y, size.width, size.height);
//            
//            [[annotationView layer]addAnimation:positionAnimation forKey:@"positionAnimation"];
//            
//            
//            
            [CATransaction commit];
//
//            [m_mapview selectAnnotation:annotationView.annotation animated:YES];
            
            
            
        }
    }
    

}

//-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
////    UITouch *touch =touches.anyObject;
//    [self performSelector:@selector(setNewPosition) withObject:nil afterDelay:0.5];
//}
//-(void)setNewPosition
//{
//    if (cpointAnnotation) {
//        [m_mapview removeAnnotation:cpointAnnotation];
//    }
//    CGPoint currentTouchPosition=m_mapview.center;//[touch locationInView:self.view];
//    NSLog(@"touchesMoved");
//    
//    CLLocationCoordinate2D touchMapCoordinate =
//    [m_mapview convertPoint:currentTouchPosition toCoordinateFromView:m_mapview];
//    NSLog(@"%f   %f",touchMapCoordinate.latitude,touchMapCoordinate.longitude);
//    //初始化详情弹出框对象
//    MKPointAnnotation *pointAnnotation = [[MKPointAnnotation alloc] init];
//    //位置
//    pointAnnotation.coordinate = touchMapCoordinate;
//    //显示标题
//    pointAnnotation.title = [NSString stringWithFormat:@"位置%d",tagNum];
//    cpointAnnotation = pointAnnotation;
//    [m_mapview addAnnotation:pointAnnotation];
//    [pointAnnotation release];
//}
//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//
//    NSLog(@"touchesEnded");
//}
//
//
//
//
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"touchesBegan");
//}
//
//- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"touchesCancelled");
//}

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
    
    OneViewController *oneController = [[OneViewController alloc] init];
    //给Controller的标题赋值
    oneController.title = @"地址";
    [self.navigationController pushViewController:oneController animated:YES];
    //给Controller的label赋值
    [oneController setLabelText:str];
    [oneController release];
    
    locationlable.text = str;
    geocoder.delegate = nil;
    [geocoder autorelease];
}
@end

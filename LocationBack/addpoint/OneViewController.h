//
//  OneViewController.h
//  Notification
//
//  Created by KangQiJun My on 12-8-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OneViewController : UIViewController{
    UILabel *m_label;
}
@property(retain,nonatomic) UILabel *m_label;
-(void)setLabelText:(NSString *)str;
@end

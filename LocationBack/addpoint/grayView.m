//
//  grayView.m
//  LocationBackgroud
//
//  Created by wangwb on 13-2-21.
//  Copyright (c) 2013年 wangwb. All rights reserved.
//

#import "grayView.h"


#define PI 3.14159265358979323846

#define radius 100



static inline float radians(double degrees) {
    
    return degrees * PI / 180;
    
}



static inline void drawArc(CGContextRef ctx, CGPoint point, float angle_start, float angle_end, UIColor* color) {
    
    CGContextMoveToPoint(ctx, point.x, point.y);
    
    CGContextSetFillColor(ctx, CGColorGetComponents( [color CGColor]));
    
    CGContextAddArc(ctx, point.x, point.y, radius,  angle_start, angle_end, 0);
    
    //CGContextClosePath(ctx);
    
    CGContextFillPath(ctx);
    
}
@implementation grayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
//    CGContextSetRGBFillColor(context, 0.0, 0.0, 1.0, 1.0);
    
    // Draw them with a 2.0 stroke width so they are a bit more visible.
    CGContextSetLineWidth(context, 1.0);
    
    int width = CGRectGetWidth(rect);
    int height = CGRectGetHeight(rect);
    int centerw = 20;
    
    CGContextMoveToPoint(context, 0, height/2);
    CGContextAddLineToPoint(context, width/2-centerw,height/2);
    
    CGContextMoveToPoint(context, width/2+centerw, height/2);
    CGContextAddLineToPoint(context, width,height/2);
    
    CGContextMoveToPoint(context, width/2,0);
    CGContextAddLineToPoint(context, width/2,height/2-centerw);
    
    
    CGContextMoveToPoint(context, width/2,height/2+centerw);
    CGContextAddLineToPoint(context, width/2,height);
    
    CGContextStrokePath(context);
    
    context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineWidth(context, 1.0);
    
//    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextMoveToPoint(context, width/2-centerw/2+7,height/2);
    CGContextAddLineToPoint(context, width/2+centerw/2-7, height/2);

    CGContextMoveToPoint(context, width/2,height/2-centerw/2+7);
    CGContextAddLineToPoint(context, width/2,height/2+centerw/2-7);
    
//    drawArc(context,CGPointMake(width/2, height/2), radians(0.0),  radians(360.0), [UIColor clearColor]);
    
    CGContextStrokePath(context);
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesBegan:touches withEvent:event];
    [super touchesBegan:touches withEvent:event];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesMoved:touches withEvent:event];
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesEnded:touches withEvent:event];
    [super touchesEnded:touches withEvent:event];
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[self nextResponder] touchesCancelled:touches withEvent:event];
    [super touchesCancelled:touches withEvent:event];
}
@end

//
//  SZH_BezierPathView.m
//  SZH_CoreGraphicsDemo1
//
//  Created by 智衡宋 on 2017/9/22.
//  Copyright © 2017年 智衡宋. All rights reserved.
//

#import "SZH_BezierPathView.h"

@implementation SZH_BezierPathView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self szh_test3];
}


#pragma mark -----------  贝塞尔曲线

- (void)szh_test1 {
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(20, 20, 100, 100)];
    path.lineWidth = 5.0;
    path.lineCapStyle = kCGLineCapRound;
    UIColor *color = [UIColor redColor];
    [color set];
    [path stroke];
}

#pragma mark -----------  CGContextRef 画板

- (void)szh_test2 {
    
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    
    //绘制矩形
    CGRect recttangle  =  CGRectMake(80, 400, 160, 60);
    CGContextAddRect(ctx, recttangle);
    CGContextSetFillColorWithColor(ctx, [UIColor lightGrayColor].CGColor);
    CGContextFillPath(ctx);
    
    
    //绘制圆形
    CGContextAddArc(ctx, 160, 200, 150, 0, 2 * M_PI, 1);
    CGContextSetFillColorWithColor(ctx, [UIColor yellowColor].CGColor);
    CGContextFillPath(ctx);
    
    //添加阴影
    [self drawCircleAtX:160 Y:200 CGContextRef:ctx];
    
    //绘制椭圆
    [self drawEllipseAtX:100 Y:140 CGContext:ctx];
    [self drawEllipseAtX:200 Y:140 CGContext:ctx];
    
    
    //绘制多边形
    [self drawTriangle:ctx];
    
    //绘制不规则形状
    [self drawCurve:ctx];
    [self drawCurve1:ctx];
    [self drawCurve2:ctx];
    
    
    
}


//绘制椭圆
- (void)drawEllipseAtX:(float)x Y:(float)y CGContext:(CGContextRef)ctx {
    
    CGRect rectangle = CGRectMake(x, y, 60, 30);
    CGContextAddEllipseInRect(ctx, rectangle);
    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextFillPath(ctx);
}

//绘制多边形
- (void)drawTriangle:(CGContextRef)ctx {
    
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, 160, 40);
    CGContextAddLineToPoint(ctx, 190, 80);
    CGContextAddLineToPoint(ctx, 130, 80);
    
    CGContextClosePath(ctx);
    CGContextSetFillColorWithColor(ctx, [UIColor blackColor].CGColor);
    CGContextFillPath(ctx);
}

//绘制不规则的形状1
- (void)drawCurve:(CGContextRef)ctx {
    
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, 50, 130);
    CGContextAddQuadCurveToPoint(ctx, 0, 100, 25, 170);
    
    CGContextSetLineWidth(ctx, 10);
    CGContextSetStrokeColorWithColor(ctx, [UIColor brownColor].CGColor);
    CGContextStrokePath(ctx);
    
    
}

- (void)drawCurve1:(CGContextRef)ctx {
    
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, 300, 130);
    CGContextAddQuadCurveToPoint(ctx, 350, 100, 300, 170);
    
    CGContextSetLineWidth(ctx, 10);
    CGContextSetStrokeColorWithColor(ctx, [UIColor brownColor].CGColor);
    CGContextStrokePath(ctx);
    
    
}


//绘制不规则的形状2
- (void)drawCurve2:(CGContextRef)ctx {
    
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, 170, 170);
    CGContextAddCurveToPoint(ctx,160, 250, 230, 250, 160, 290);
    CGContextSetLineWidth(ctx, 10);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextStrokePath(ctx);
}

//添加阴影效果

- (void)drawCircleAtX:(float)x Y:(float)y CGContextRef:(CGContextRef)ctx{
    
    CGContextAddArc(ctx, x, y, 150, 0, 2 * M_PI, 1);
    CGContextSetShadowWithColor(ctx, CGSizeMake(10, 10), 20.0f, [UIColor grayColor].CGColor);
    CGContextSetFillColorWithColor(ctx, [UIColor yellowColor].CGColor);
    CGContextFillPath(ctx);
    
}

#pragma mark -----------  CGContextRef 画板 渐变色



- (void)szh_test3 {

//    [self drawdrawRadialGradientWithRect:CGRectMake(120, 510, 60, 60)];
    
 //   [self drawingLinearGradientWithStartPoint:CGPointMake(0, 0) endPoint:CGPointMake(100, 100)];
    
//    [self drawCustomGradient];
    
    [self drawCGGradientCreateWithColorComponents];
    

}

//放射式渐变:放射式渐变以某种颜色从一点开始，以另一种颜色在其它点结束。它看起来会是一个圆。
- (void)drawdrawRadialGradientWithRect:(CGRect)rect {

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    NSArray *gradientColors = [NSArray arrayWithObjects:
                               (id)[UIColor whiteColor].CGColor,
                               (id)[UIColor blackColor].CGColor, nil];
    CGFloat gradientLocations[] = {0,1};
    CGGradientRef gradient  = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);
    
    CGPoint startCenter = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    CGFloat radius = MAX(CGRectGetHeight(rect), CGRectGetWidth(rect));
    
    
    CGContextRef ctx  = UIGraphicsGetCurrentContext();
    
    
    // CGContextDrawRadialGradient
    CGContextDrawRadialGradient(ctx, gradient, startCenter, 0, startCenter, radius, 0);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    
}


//线性渐变: 线性渐变以某种颜色从一点开始，以另一种颜色在其它点结束。
- (void)drawingLinearGradientWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    NSArray *gradientColors = [NSArray arrayWithObjects:(id)[UIColor whiteColor].CGColor,
                               (id)[UIColor blackColor].CGColor, nil];
    CGFloat gradientLocations[] = {0,1};
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(ctx);
    //CGContextDrawLinearGradient
    CGContextDrawLinearGradient(ctx, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(ctx);
   
    //释放
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    
    
}

//用一个自定义的形状来抱住你创建的渐变

- (void)drawCustomGradient {
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    NSArray* gradientColors = [NSArray arrayWithObjects:
                               (id)[UIColor whiteColor].CGColor,
                               (id)[UIColor purpleColor].CGColor, nil];
    CGFloat gradientLocations[] = {0, 1};
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace,
                                                        (__bridge CFArrayRef)gradientColors,
                                                        gradientLocations);
    
    CGContextRef ctx  = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    CGContextMoveToPoint(ctx, 100, 100);
    CGContextAddArc(ctx, 100, 100, 60, 1.04 , 2.09 , 0);
    CGContextClosePath(ctx);
    CGContextClip(ctx);
    
    CGPoint endshine;
    CGPoint startshine;
    startshine = CGPointMake(100 + 60 * cosf( 1.57 ),100+ 60 * sinf( 1.57 ));
    endshine = CGPointMake(100,100);
    
    //CGContextDrawLinearGradient
    CGContextDrawLinearGradient(ctx, gradient, startshine, endshine, kCGGradientDrawsAfterEndLocation);
    
    CGContextRestoreGState(ctx);
    
    //释放
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

//使用 CGGradientCreateWithColorComponents
- (void)drawCGGradientCreateWithColorComponents {
    
    
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGFloat gradientLocations[] = {0.0, 0.5, 1.0};
    
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, (CGFloat[]){
        0.8, 0.2, 0.2, 1.0,
        0.2, 0.8, 0.2, 1.0,
        0.2, 0.2, 0.8, 1.0
    }, gradientLocations, 3);
    
    CGContextRef ctx  = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    CGContextMoveToPoint(ctx, 100, 100);
    CGContextAddArc(ctx, 100, 100, 60, 1.04 , 2.09 , 0);
    CGContextClosePath(ctx);
    CGContextClip(ctx);
    
    CGPoint endshine;
    CGPoint startshine;
    startshine = CGPointMake(100 + 60 * cosf( 1.57 ),100+ 60 * sinf( 1.57 ));
    endshine = CGPointMake(100,100);
    
    //CGContextDrawLinearGradient
    CGContextDrawLinearGradient(ctx, gradient, startshine, endshine, kCGGradientDrawsAfterEndLocation);
    
    CGContextRestoreGState(ctx);
    
    //释放
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    
}

@end

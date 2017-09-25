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
    [self szh_test2];
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
    
    
    // ------------------- 实心圆
    
    //画图
    CGContextAddEllipseInRect(ctx, CGRectMake(10, 10, 50, 50));
    [[UIColor greenColor] set];
    
    //渲染
    CGContextFillPath(ctx);
    
    // ------------------- 空心圆
    CGContextAddEllipseInRect(ctx, CGRectMake(70, 10, 50, 50));
    [[UIColor redColor] set];
    CGContextStrokePath(ctx);
    
    
    
    // ------------------- 椭圆
    CGContextAddEllipseInRect(ctx, CGRectMake(130, 10, 100, 50));
    [[UIColor purpleColor] set];
    CGContextStrokePath(ctx);
    
    
    // ------------------- 直线
    CGContextMoveToPoint(ctx, 20, 80);
    CGContextAddLineToPoint(ctx, self.frame.size.width - 10, 80);
    [[UIColor redColor] set];
    CGContextSetLineWidth(ctx, 2.0f);//线宽
    CGContextSetLineCap(ctx, kCGLineCapRound);//起点和终点圆角
    CGContextSetLineJoin(ctx, kCGLineJoinRound);//转角圆角
    CGContextStrokePath(ctx);//渲染
    
    
    // ------------------- 三角形
    CGContextMoveToPoint(ctx, 10, 150);
    CGContextAddLineToPoint(ctx, 60, 100);
    CGContextAddLineToPoint(ctx, 100, 150);
    [[UIColor purpleColor] set];
    CGContextClosePath(ctx);
    CGContextStrokePath(ctx);
    
    
    // ------------------- 矩形
    CGContextAddRect(ctx, CGRectMake(20, 170, 100, 50));
    [[UIColor orangeColor] set];
//    CGContextStrokePath(ctx);//空心
    CGContextFillPath(ctx);//实心
    
    
    // ------------------- 圆弧
    CGContextAddArc(ctx, 200, 170, 50, M_PI, M_PI_4, 0);
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
    
    
    // ------------------- 文字
    NSString *str = @"你在红楼，我在西游";
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor redColor];//文字颜色
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:14];//字体
    [str drawInRect:CGRectMake(20, 250, 300, 30) withAttributes:dict];
    
    
    // ------------------- 图片
    UIImage *img = [UIImage imageNamed:@"123"];
    [img drawAsPatternInRect:CGRectMake(20, 280, 300, 300)];//多个平铺
    [img drawAtPoint:CGPointMake(20, 280)];//绘制到指定点，图片有多大就显示多大
    [img drawInRect:CGRectMake(20, 280, 80, 80)];//拉伸
    
    
}

@end

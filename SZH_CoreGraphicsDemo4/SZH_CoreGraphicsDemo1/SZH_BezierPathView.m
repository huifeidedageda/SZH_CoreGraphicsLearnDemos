//
//  SZH_BezierPathView.m
//  SZH_CoreGraphicsDemo1
//
//  Created by 智衡宋 on 2017/9/22.
//  Copyright © 2017年 智衡宋. All rights reserved.
//

#import "SZH_BezierPathView.h"


@interface SZH_BezierPathView ()

@end

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
//    [self szh_test1];
//    [self szh_test2];
//    [self szh_test5];
//    [self szh_test6];
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {

    [self szh_test4:ctx];

}


#pragma mark -----------  CGContextRef 六种绘图形式

//第一种绘图形式：在UIView的子类方法drawRect：中绘制一个蓝色圆，使用UIKit在Cocoa为我们提供的当前上下文中完成绘图任务。
- (void)szh_test1 {
    
    UIBezierPath *p = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0,0,100,100)];
    [[UIColor blueColor] setFill];
    [p fill];
   
}

//第二种绘图形式：使用Core Graphics实现绘制蓝色圆。
- (void)szh_test2 {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ctx, CGRectMake(0,0,100,100));
    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextFillPath(ctx);
    
    
}

//第三种绘图形式：我将在UIView子类的drawLayer:inContext：方法中实现绘图任务。？不确定
- (void)szh_test3 {
    
    
    
}


//第四种绘图形式： 使用Core Graphics在drawLayer:inContext：方法中实现同样操作
- (void)szh_test4:(CGContextRef)ctx {
    
    CGContextAddEllipseInRect(ctx, CGRectMake(0,0,100,100));
    CGContextSetFillColorWithColor(ctx, [UIColor blueColor].CGColor);
    CGContextFillPath(ctx);
    
}

//第五种绘图形式： 使用UIKit实现：
- (void)szh_test5 {
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(100,100), NO, 0);
    
    UIBezierPath* p = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0,0,100,100)];
    
    [[UIColor blueColor] setFill];
    
    [p fill];
    
    UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.frame];
    imageView.image = im;
    [self addSubview:imageView];
}


//第六种绘图形式： 使用Core Graphics实现：
- (void)szh_test6 {
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(100,100), NO, 0);
    
    CGContextRef con = UIGraphicsGetCurrentContext();
    
    CGContextAddEllipseInRect(con, CGRectMake(0,0,100,100));
    
    CGContextSetFillColorWithColor(con, [UIColor blueColor].CGColor);
    
    CGContextFillPath(con);
    
    UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.frame];
    imageView.image = im;
    [self addSubview:imageView];
}

@end

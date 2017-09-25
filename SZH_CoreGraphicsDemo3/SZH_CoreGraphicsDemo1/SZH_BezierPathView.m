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

/**
 
 CoreGraphics的使用过程中，经常会遇到绘图context切换的操作，一般使用用到
 
 1、CGContextSaveGState/CGContextRestoreGState，用于记录和恢复已存储的绘图context
 2、UIGraphicsPushContext/UIGraphicsPopContext，完全地切换绘图context
 3、UIGraphicsBeginImageContext/UIGraphicsEndImageContext， 如果想在切换绘图context后，继续使用CoreGraphics绘图（而非UIKit），则不需要使用UIGraphicsPushContext/UIGraphicsPopContext。
 
 这三对方法。
 
 */

- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self szh_test3];
}


#pragma mark -----------  CGContextRef 画板

/**
 用于记录和恢复已存储的绘图context
 */

- (void)szh_test1 {
    
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    [[UIColor redColor] setStroke]; //红色
    CGContextSaveGState(UIGraphicsGetCurrentContext());
    CGContextAddEllipseInRect(ctx, CGRectMake(100, 100, 50, 50));
    CGContextSetLineWidth(ctx, 10);
    [[UIColor yellowColor] setStroke]; //黄色
    CGContextStrokePath(ctx);
    CGContextRestoreGState(UIGraphicsGetCurrentContext());
    CGContextAddEllipseInRect(ctx, CGRectMake(200, 100, 50, 50)); //红色
    CGContextStrokePath(ctx);
    
   
}


#pragma mark --- 注意，绘图context切换的关键是：要看切换新的绘图context后，是要继续使用CoreGraphics绘制图形，还是要使用UIKit。

/**
 
 当前正在使用CoreGraphics绘制图形A，想要使用UIKit绘制完全不同的图形B，此时就希望保存当前绘图context及已绘制内容。
 使用UIGraphicsPushContext切换到一个全新的绘图context。
 使用UIKit绘制图形B。
 使用UIGraphicsPopContext恢复之前的绘图context，继续使用CoreGraphics绘制图形A。

 因为必须调用UIKit中的绘图方法，所以才需要用到UIGraphicsPushContext/UIGraphicsPopContext
 
 */


- (void)szh_test2 {
    
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    
    
}




/**
 
 当前正在绘制图形A。
 使用UIGraphicsBeginImageContext将旧的绘图context入栈，创建新的绘图context并使用。
 绘制图形B。
 结束绘制图形B之后，使用UIGraphicsEndImageContext恢复到之前的绘图context，继续绘制图形A。

 */

- (void)szh_test3 {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctx, 20, 100);
    
    
    UIGraphicsBeginImageContext(CGSizeMake(self.frame.size.width, self.frame.size.height));
    CGContextRef newCtx = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(newCtx, 20, 120);
    CGContextAddLineToPoint(newCtx, 300, 120);
    CGContextSetLineWidth(newCtx, 5.0f);
    CGContextSetStrokeColorWithColor(newCtx, [UIColor blueColor].CGColor);
    CGContextStrokePath(newCtx);
    UIGraphicsEndImageContext();
    
    CGContextAddLineToPoint(ctx, 300, 100);
    CGContextSetLineWidth(ctx, 5.0f);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextStrokePath(ctx);
    
    

}


@end

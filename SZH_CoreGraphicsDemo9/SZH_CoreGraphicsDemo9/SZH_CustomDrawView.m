//
//  SZH_CustomDrawView.m
//  SZH_CoreGraphicsDemo9
//
//  Created by 智衡宋 on 2017/9/28.
//  Copyright © 2017年 智衡宋. All rights reserved.
//

#import "SZH_CustomDrawView.h"

@implementation SZH_CustomDrawView


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
    [self draw6];
    
}


//画四边形
- (void)draw1 {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextAddRect(ctx, CGRectMake(20, 20, 100, 100));
    
    CGContextStrokePath(ctx);
}


#pragma mark -------- 旋转

/**
     旋转的时候，是整个layer都旋转了
 */


//画歪四边形
- (void)draw2 {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextRotateCTM(ctx, M_PI_4);
    CGContextAddRect(ctx, CGRectMake(100, 100, 100, 100));
    CGContextStrokePath(ctx);
    
}


- (void)draw3 {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGContextRotateCTM(ctx, M_PI_4);
    CGContextAddRect(ctx, CGRectMake(100, 100, 100, 100));
    CGContextAddEllipseInRect(ctx, CGRectMake(200, 200, 50, 50));
    CGContextStrokePath(ctx);
    
}

- (void)draw4 {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextRotateCTM(ctx, M_PI_4);
    CGContextAddRect(ctx, CGRectMake(100, 100, 100, 100));
    CGContextAddEllipseInRect(ctx, CGRectMake(200, 200, 50, 50));
    CGContextStrokePath(ctx);
    
}

#pragma mark -------- 缩放

- (void)draw5 {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(ctx, 0.5, 1.5);
    CGContextAddRect(ctx, CGRectMake(100, 100, 100, 100));
    CGContextAddEllipseInRect(ctx, CGRectMake(200, 200, 50, 50));
    CGContextStrokePath(ctx);
    
}

#pragma mark -------- 平移
- (void)draw6 {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(ctx, 0.5, 1.5);
    CGContextTranslateCTM(ctx, 200, 100);
    CGContextAddRect(ctx, CGRectMake(100, 100, 100, 100));
    CGContextAddEllipseInRect(ctx, CGRectMake(200, 200, 50, 50));
    CGContextStrokePath(ctx);
    
}

@end

//
//  SZH_CustomDrawView.m
//  SZH_CoreGraphicsDemo5
//
//  Created by 智衡宋 on 2017/9/25.
//  Copyright © 2017年 智衡宋. All rights reserved.
//

#import "SZH_CustomDrawView.h"


@implementation SZH_CustomDrawView {
    float _progress;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        //画进度条
//        [self szh_createProgressUI];
    }
    return self;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
//    //基本图形绘制
//    [self basicDraw1];
//    [self basicDraw2];
//    [self basicDraw3];
//    //进度条
//    [self szh_progressDraw];
//    //饼状图
//    [self szh_pieChartDraw];
//    //柱状图
//    [self szh_histogramDraw:rect];
//    //图形上下文线
//    [self szh_drawContext];
    //矩形操作
    [self szh_rectangleDraw];
}

#pragma mark ---------------- 基本图形绘制

- (void)szh_basicDraw1 {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint startP = CGPointMake(10, 125);
    CGPoint endP = CGPointMake(240, 125);
    CGPoint controlP = CGPointMake(125, 0);
    
    [path moveToPoint:startP];
    [path addQuadCurveToPoint:endP controlPoint:controlP];

    CGContextAddPath(ctx, path.CGPath);
    
    CGContextStrokePath(ctx);
    
}

- (void)szh_basicDraw2 {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPath];
    // 设置起点
    [path moveToPoint:CGPointMake(10, 10)];
    
    // 添加一条线到某个点
    [path addLineToPoint:CGPointMake(125, 125)];
    [path addLineToPoint:CGPointMake(240, 10)];
    CGContextAddPath(ctx, path.CGPath);
    CGContextStrokePath(ctx);
}

- (void)szh_basicDraw3 {
    
    // 1.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 2.拼接路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // 设置起点
    [path moveToPoint:CGPointMake(10, 125)];
    
    // 添加一条线到某个点
    [path addLineToPoint:CGPointMake(230, 125)];
    
    //    // 设置起点
    //    [path moveToPoint:CGPointMake(10, 10)];
    //
    //    // 添加一条线到某个点
    //    [path addLineToPoint:CGPointMake(125, 100)];
    
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    
    [path1 moveToPoint:CGPointMake(10, 10)];
    
    [path1 addLineToPoint:CGPointMake(125, 100)];
    
    
    // 3.把路径添加到上下文
    CGContextAddPath(ctx, path.CGPath);
    CGContextAddPath(ctx, path1.CGPath);
    
    // 设置绘图状态
    // 设置线宽
    CGContextSetLineWidth(ctx, 10);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    //    CGContextSetRGBStrokeColor(ctx, 1, 0, 0, 1);
    [[UIColor redColor] set];
    
    // 4.渲染上下文到视图
    CGContextStrokePath(ctx);
}



#pragma mark ---------------- 下载进度条

- (void)szh_createProgressUI {
    
    UISlider *slider = [[UISlider alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 40, [UIScreen mainScreen].bounds.size.width, 20)];
    [slider addTarget:self action:@selector(setProgress:) forControlEvents:UIControlEventValueChanged];
    slider.value = 0;
    [self addSubview:slider];
    
}

- (void)setProgress:(UISlider *)slider
{
    _progress = slider.value;
    [self setNeedsDisplay];
    
}

- (void)szh_progressDraw {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 2.拼接路径
    CGPoint center = CGPointMake(50, 50);
    CGFloat radius = 50 - 2;
    CGFloat startA = -M_PI_2;
    CGFloat endA = -M_PI_2 + _progress * M_PI * 2;
    
    NSLog(@"%lf",endA);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    
    // 3.把路径添加到上下文
    CGContextAddPath(ctx, path.CGPath);
    
    // 4.把上下文渲染到视图
    CGContextStrokePath(ctx);
    
}

#pragma mark ---------------- 饼图

- (void)szh_pieChartDraw {
    
    NSArray *data = @[@25,@25,@50];
    
    // 1.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 2.拼接路径
    CGPoint center = CGPointMake(125, 125);
    CGFloat radius = 120;
    CGFloat startA = 0;
    CGFloat angle = 0;
    CGFloat endA = 0;
    
    for (NSNumber *number in data) {
        // 2.拼接路径
        startA = endA;
        angle = number.intValue / 100.0 * M_PI * 2;
        endA = startA + angle;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
        [path addLineToPoint:center];
        
        CGFloat r = arc4random_uniform(255);
        CGFloat g = arc4random_uniform(255);
        CGFloat b = arc4random_uniform(255);
        [[UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1.0] set];
        // 把路径添加上下文
        CGContextAddPath(ctx, path.CGPath);
        
        // 渲染
        CGContextFillPath(ctx);
        
    }
    
}

- (void)drawPie
{
    // 1.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 2.拼接路径
    CGPoint center = CGPointMake(125, 125);
    CGFloat radius = 120;
    CGFloat startA = 0;
    CGFloat angle = 0;
    CGFloat endA = 0;
    
    // 第一个扇形
    angle = 25 / 100.0 * M_PI * 2;
    endA = startA + angle;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    [path addLineToPoint:center];
    // 添加到上下文
    CGContextAddPath(ctx, path.CGPath);
    [[UIColor redColor] set];
    
    
    // 渲染
    CGContextFillPath(ctx);
    
    
    
    // 第二个扇形
    startA = endA;
    angle = 25 / 100.0 * M_PI * 2;
    endA = startA + angle;
    UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    [path1 addLineToPoint:center];
    // 添加到上下文
    CGContextAddPath(ctx, path1.CGPath);
    [[UIColor greenColor] set];
    // 渲染
    CGContextFillPath(ctx);
    
    // 第三个扇形
    startA = endA;
    angle = 50 / 100.0 * M_PI * 2;
    endA = startA + angle;
    UIBezierPath *path2 = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    [path2 addLineToPoint:center];
    // 添加到上下文
    CGContextAddPath(ctx, path2.CGPath);
    [[UIColor blueColor] set];
    // 渲染
    CGContextFillPath(ctx);
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    CGFloat a = arc4random_uniform(6);
    //CGFloat a =  arc4random()%6;
    NSLog(@"随机数--%f",a);
    
    
    [self setNeedsDisplay];
    
}

#pragma mark ---------------- 柱形图

- (void)szh_histogramDraw:(CGRect)rect {
    
    NSArray *data = @[@25,@25,@50];
    NSInteger count = data.count;
    
    CGFloat w = rect.size.width / (2 * count - 1);
    CGFloat h = 0;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat viewH = rect.size.height;
    // 1.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    for (int i = 0; i < count; i++) {
        h = viewH * [data[i] intValue] / 100.0;
        x = 2 * w * i;
        y = viewH - h;
        // 2.拼接路径
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(x, y, w, h)];
        
        // 3.添加路径到上下文
        CGContextAddPath(ctx, path.CGPath);
        
        CGFloat r = arc4random_uniform(255);
        CGFloat g = arc4random_uniform(255);
        CGFloat b = arc4random_uniform(255);
        [[UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1.0] set];
        
        // 4.渲染
        CGContextFillPath(ctx);
    }
}

#pragma mark ---------------- 模仿UIImageView


#pragma mark ---------------- 图形上下文线
- (void)szh_drawContext {
    
    // 1.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 把ctx拷贝一份放在栈中
    CGContextSaveGState(ctx);
    
    // 2.拼接路径（绘图的信息）
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(10, 125)];
    [path addLineToPoint:CGPointMake(240, 125)];
    
    // 3.路径添加到上下文
    CGContextAddPath(ctx, path.CGPath);
    
    // 设置绘图的状态
    [[UIColor redColor] set];
    CGContextSetLineWidth(ctx, 10);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    
    // 4.渲染
    CGContextStrokePath(ctx);
    
    
    // 第二根线
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:CGPointMake(125, 10)];
    [path1 addLineToPoint:CGPointMake(125, 240)];
    CGContextAddPath(ctx, path1.CGPath);
    
    // 把栈顶上下文取出来，替换当前上下文
    CGContextRestoreGState(ctx);
    
    // 设置绘图的状态
    //    [[UIColor blackColor] set];
    //    CGContextSetLineWidth(ctx, 1);
    //    CGContextSetLineCap(ctx, kCGLineCapButt);
    
    
    // 4.渲染
    CGContextStrokePath(ctx);
    
}

#pragma mark ---------------- 矩形操作

- (void)szh_rectangleDraw {
    
    // 1.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 注意：你的路径一定放在上下文矩阵操作之后
    // 平移上下文
    CGContextTranslateCTM(ctx, 50, 100);
    
    // 旋转上下文
    CGContextRotateCTM(ctx, M_PI_4);
    
    // 缩放上下文
    CGContextScaleCTM(ctx, 0.5, 1.2);
    
    // 2.拼接路径
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(-50, -100, 150, 200)];
    
    // 3.把路径添加到上下文
    CGContextAddPath(ctx, path.CGPath);
    
    
    
    [[UIColor redColor] set];
    
    // 4.渲染
    CGContextFillPath(ctx);
    
}

@end

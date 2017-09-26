//
//  UIImage+EditImageMethod.m
//  SZH_CoreGraphicsDemo5
//
//  Created by 智衡宋 on 2017/9/25.
//  Copyright © 2017年 智衡宋. All rights reserved.
//

#import "UIImage+EditImageMethod.h"
#import "PQWipeView.h"
@implementation UIImage (EditImageMethod)

#pragma mark ------------- 1、绘制图片上下文

+ (UIImage *)szh_drawImageWithImageNamed:(NSString *)name {
    
    //获取图片
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:nil]];
    //开启图形上下文
    UIGraphicsBeginImageContext(image.size);
    //绘制到图形上下文中
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    //从上下文中获取图片
    UIImage *newIamge = UIGraphicsGetImageFromCurrentImageContext();
    //关闭图形上下文
    UIGraphicsEndImageContext();
    
    return newIamge;
}


#pragma mark ------------- 2、给图片添加文字水印

+ (UIImage *)szh_WaterImageWithImage:(UIImage *)image text:(NSString *)text textPoint:(CGPoint)point attributedString:(NSDictionary *)attribute {
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //绘制图片
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    //添加水印
    [text drawAtPoint:point withAttributes:attribute];
    //从上下文中获取新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭图形上下文
    return newImage;
}


#pragma mark ------------- 3、给图片添加图片水印

+ (UIImage *)szh_WaterImageWithImage:(UIImage *)image waterImage:(UIImage *)waterImage waterImageRect:(CGRect)rect{

    //开启图片上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //绘制背景图片
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    //绘制水印图片到当前上下文
    [waterImage drawInRect:rect];
    //从上下文中获取新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭图片上下文
    return newImage;
    
}


#pragma mark ------------- 4、裁剪图片

+ (nullable UIImage *)szh_ClipCircleImageWithImage:(nullable UIImage *)image circleRect:(CGRect)rect{
    
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //设置裁剪区域
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    [path addClip];
    //绘制图片
    [image drawAtPoint:CGPointZero];
    //获取新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark ------------- 5、裁剪带边框的圆形图片

+ (nullable UIImage *)szh_ClipCircleImageWithImage:(nullable UIImage *)image circleRect:(CGRect)rect borderWidth:(CGFloat)borderW borderColor:(nullable UIColor *)borderColor {
    
    //开启上下文
    UIGraphicsBeginImageContext(image.size);
    //设置边框
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    [borderColor setFill];
    [path fill];
    //设置裁剪区域
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(rect.origin.x + borderW , rect.origin.x + borderW , rect.size.width - borderW * 2, rect.size.height - borderW *2)];
    [clipPath addClip];
    //绘制图片
    [image drawAtPoint:CGPointZero];
    
    //获取新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    
    return newImage;
    
    
}

#pragma mark ------------- 6、截屏

+ (void)szh_cutScreenWithView:(nullable UIView *)view successBlock:(nullable void(^)(UIImage * _Nullable image,NSData * _Nullable imagedata))block{
    
    //开启上下文
    UIGraphicsBeginImageContext(view.bounds.size);
    //获取当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //截屏,渲染到当前上下文中，这里使用绘制无效，可自行测试
    [view.layer renderInContext:ctx];
    //获取新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //转化为Data
    NSData *data = UIImagePNGRepresentation(newImage);
    //关闭上下文
    UIGraphicsEndImageContext();
    //回调
    block(newImage,data);
    
}


#pragma mark ------------- 7、擦除图片

- (nullable UIImage *)szh_wipeImageWithView:(nullable UIView *)view currentPoint:(CGPoint)nowPoint size:(CGSize)size {
    //计算位置
    CGFloat offsetX = nowPoint.x - size.width * 0.5;
    CGFloat offsetY = nowPoint.y - size.height * 0.5;
    CGRect clipRect = CGRectMake(offsetX, offsetY, size.width, size.height);
    
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 1);
    //获取当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //把图片绘制上去
    [view.layer renderInContext:ctx];
    //把这一块设置为透明
    CGContextClearRect(ctx, clipRect);
    //获取新的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    
    //重新赋值图片
    return newImage;
    
    
    
}

#pragma mark ------------- 8、裁剪图片

+ (void)szh_cutScreenWithView:(nullable UIView *)view cutFrame:(CGRect)frame successBlock:(nullable void(^)(UIImage * _Nullable image,NSData * _Nullable imagedata))block{
    
    //先把裁剪区域上面显示的层隐藏掉
    for (PQWipeView * wipe in view.subviews) {
        [wipe setHidden:YES];
    }
    
    
    //第一次裁剪
    
    //开启上下文
    UIGraphicsBeginImageContext(view.frame.size);
    //获取当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //添加裁剪区域
    UIBezierPath *path  = [UIBezierPath bezierPathWithRect:frame];
    [path addClip];
    //渲染
    [view.layer renderInContext:ctx];
    //从上下文中获取
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    
    //进行完第一次裁剪之后，我们就已经拿到了没有半透明层的图片，这个时候可以恢复显示
    for (PQWipeView * wipe in view.subviews) {
        [wipe setHidden:NO];
    }
    
    //第二次裁剪
    
    //开启上下文，这个时候的大小就是我们最终要显示图片的大小
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, 0);
    //把x、y坐标向左、上移动
    [newImage drawAtPoint:CGPointMake(- frame.origin.x, - frame.origin.y)];
    
    //得到要显示区域的图片
    UIImage *fImage = UIGraphicsGetImageFromCurrentImageContext();
    //得到data类型，便于保存
    NSData *data2 = UIImagePNGRepresentation(fImage);
    //关闭上下文
    UIGraphicsEndImageContext();
    //回调
    block(fImage,data2);
    
}

#pragma mark -------------


@end

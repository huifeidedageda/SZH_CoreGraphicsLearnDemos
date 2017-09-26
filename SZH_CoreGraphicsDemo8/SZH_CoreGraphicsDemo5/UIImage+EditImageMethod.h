//
//  UIImage+EditImageMethod.h
//  SZH_CoreGraphicsDemo5
//
//  Created by 智衡宋 on 2017/9/25.
//  Copyright © 2017年 智衡宋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (EditImageMethod)

//1、绘制图片上下文
+ (UIImage *)szh_drawImageWithImageNamed:(NSString *)name;

//2、添加文字水印
+ (UIImage *)szh_WaterImageWithImage:(UIImage *)image text:(NSString *)text textPoint:(CGPoint)point attributedString:(NSDictionary *)attribute;

//3、给图片添加图片水印
+ (UIImage *)szh_WaterImageWithImage:(UIImage *)image waterImage:(UIImage *)waterImage waterImageRect:(CGRect)rect;

//4、裁剪图片
+ (nullable UIImage *)szh_ClipCircleImageWithImage:(nullable UIImage *)image circleRect:(CGRect)rect;

//5、裁剪带边框的图片
+ (nullable UIImage *)szh_ClipCircleImageWithImage:(nullable UIImage *)image circleRect:(CGRect)rect borderWidth:(CGFloat)borderW borderColor:(nullable UIColor *)borderColor;

//6、截屏
+ (void)szh_cutScreenWithView:(nullable UIView *)view successBlock:(nullable void(^)(UIImage * _Nullable image,NSData * _Nullable imagedata))block;

//7、擦除
- (nullable UIImage *)szh_wipeImageWithView:(nullable UIView *)view currentPoint:(CGPoint)nowPoint size:(CGSize)size ;
//8、剪切图片
+ (void)szh_cutScreenWithView:(nullable UIView *)view cutFrame:(CGRect)frame successBlock:(nullable void(^)(UIImage * _Nullable image,NSData * _Nullable imagedata))block;

@end

//
//  ViewController.m
//  SZH_CoreGraphicsDemo1
//
//  Created by 智衡宋 on 2017/9/22.
//  Copyright © 2017年 智衡宋. All rights reserved.
//

#import "ViewController.h"
#import "SZH_BezierPathView.h"
#include "SZH_GraphicsView.h"
@interface ViewController ()<CALayerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view = [[SZH_BezierPathView alloc]initWithFrame:self.view.bounds];
    
    
    //UIGraphicsPushContext/UIGraphicsPopContext，完全地切换绘图context
//    CALayer *layer=[CALayer layer];
//    layer.bounds = CGRectMake(0, 0, 300, 300);
//    layer.position = CGPointMake(100, 100);
//    layer.delegate = self;
//    [layer setNeedsDisplay];
//    [self.view.layer addSublayer:layer];
    
}

//UIGraphicsPushContext/UIGraphicsPopContext，完全地切换绘图context
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    
    UIImage *image = [UIImage imageNamed:@"123"];
    UIGraphicsPushContext(ctx);
    [image drawInRect:CGRectMake(0, 0, 300, 300)];
    UIGraphicsPopContext();
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

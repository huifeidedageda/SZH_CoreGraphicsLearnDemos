//
//  ViewController.m
//  SZH_CoreGraphicsDemo1
//
//  Created by 智衡宋 on 2017/9/22.
//  Copyright © 2017年 智衡宋. All rights reserved.
//

#import "ViewController.h"
#import "SZH_BezierPathView.h"
#import "myLayerDelegate.h"

@interface ViewController ()
//第三种绘图形式：
@property (nonatomic, strong) id myLayerDelegate;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    self.view = [[SZH_BezierPathView alloc]initWithFrame:self.view.bounds];
    
    
    //第三种绘图形式：
    // 设置layer的delegate为NSObject子类对象
    _myLayerDelegate = [[myLayerDelegate alloc] init];
    SZH_BezierPathView *myView = [[SZH_BezierPathView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:myView];
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor magentaColor].CGColor;
    layer.bounds = CGRectMake(0, 0, 300, 500);
    layer.anchorPoint = CGPointZero;
    layer.delegate = _myLayerDelegate;
    [layer setNeedsDisplay];
    [myView.layer addSublayer:layer];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

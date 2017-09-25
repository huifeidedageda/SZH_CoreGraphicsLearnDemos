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
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view = [[SZH_BezierPathView alloc]initWithFrame:self.view.bounds];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

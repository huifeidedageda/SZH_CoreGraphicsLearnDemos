//
//  ViewController.m
//  SZH_CoreGraphicsDemo5
//
//  Created by 智衡宋 on 2017/9/25.
//  Copyright © 2017年 智衡宋. All rights reserved.
//

#import "ViewController.h"
#import "SZH_CustomDrawView.h"
#import "UIImage+EditImageMethod.h"
#import "PQWipeView.h"
#import "UIView+pgqViewExtension.h"
@interface ViewController ()
//7、擦除图片
@property (nonatomic,weak) UIImageView * wipeImageV;
//8、剪切图片
@property (nonatomic,strong) PQWipeView * wipeView;
@property (nonatomic,strong) UIImageView * imgView;
@end

@implementation ViewController {
    UIImage *_image;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    self.view = [[SZH_CustomDrawView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    [self draw8];
   
}

//1、绘制图片上下文
- (void)draw1 {
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 50, 200, 200)];
    imageView.image = [UIImage szh_drawImageWithImageNamed:@"123.png"];
    [self.view addSubview:imageView];
    
}

//2、添加文字水印
- (void)draw2 {
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 50, 200, 200)];
    //可变字符串
    NSDictionary *attributeDict = @{NSFontAttributeName: [UIFont systemFontOfSize:23.0], NSForegroundColorAttributeName: [UIColor colorWithRed:0.130 green:0.854 blue:0.345 alpha:1.000],NSFontAttributeName: [UIFont systemFontOfSize:18.0], NSForegroundColorAttributeName: [UIColor redColor]};
    imageView.image = [UIImage szh_WaterImageWithImage:[UIImage szh_drawImageWithImageNamed:@"123.png"] text:@"美女啊" textPoint:CGPointMake(20, 20) attributedString:attributeDict];
    [self.view addSubview:imageView];
    
}

//3、添加图片水印
- (void)draw3 {
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 50, 200, 200)];
    imageView.image = [UIImage szh_WaterImageWithImage:[UIImage szh_drawImageWithImageNamed:@"123.png"] waterImage:[UIImage szh_drawImageWithImageNamed:@"123.png"] waterImageRect:CGRectMake(10, 10, 50, 50)];
    
    [self.view addSubview:imageView];
}


//4、裁剪图片
- (void)draw4 {
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 50, 200, 200)];
    imageView.image = [UIImage szh_ClipCircleImageWithImage:[UIImage szh_drawImageWithImageNamed:@"123.png"] circleRect:CGRectMake(50, 50, 200, 200)];
    
    [self.view addSubview:imageView];
}



//5、裁剪带边框的图片
- (void)draw5 {
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 50, 200, 200)];
    imageView.image = [UIImage szh_ClipCircleImageWithImage:[UIImage szh_drawImageWithImageNamed:@"123.png"] circleRect:CGRectMake(50, 50, 200, 200) borderWidth:5 borderColor:[UIColor greenColor]];
    
    [self.view addSubview:imageView];
}


//6、截屏
- (void)draw6 {
   
     [UIImage szh_cutScreenWithView:self.view successBlock:^(UIImage * _Nullable image, NSData * _Nullable imagedata) {
        
         NSLog(@"--------- %@",image);
        
    }];
    
    
}

//7、擦除
- (void)draw7 {

    UIImageView * imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"back.jpg" ofType:nil]];
    [self.view addSubview:imageView];
   
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(wipePanGestureEvent:)];
    self.wipeImageV.userInteractionEnabled = YES;
    [self.wipeImageV addGestureRecognizer:pan];
    
}

- (void)wipePanGestureEvent:(UIPanGestureRecognizer * )pan{
    
    self.wipeImageV.image = [self.wipeImageV.image szh_wipeImageWithView:self.wipeImageV currentPoint:[pan locationInView:self.wipeImageV] size:CGSizeMake(20, 20)];
    
}

- (UIImageView *)wipeImageV{
    if (!_wipeImageV) {
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
        UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"fore.jpg" ofType:nil]];
        imageView.image = image;
        [self.view addSubview:imageView];
        _wipeImageV = imageView;
    }
    return _wipeImageV;
}



//8、剪切图片
- (void)draw8 {

    //添加一个右按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"确定裁剪" style:UIBarButtonItemStylePlain target:self action:@selector(cutFinish)];
    
    _image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"back.jpg" ofType:nil]];
    //添加一个背景图片
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height)];
    imgView.image = _image;
    [self.view addSubview:imgView];
    self.imgView = imgView;
    self.imgView.userInteractionEnabled = YES;
    
    _wipeView = [[[NSBundle mainBundle]loadNibNamed:@"PQWipeView" owner:self options:nil] firstObject];
    [self.imgView addSubview:_wipeView];
    
    
}

- (void)cutFinish{
    
    [UIImage szh_cutScreenWithView:self.imgView cutFrame:self.wipeView.frame successBlock:^(UIImage * _Nullable image, NSData * _Nullable imagedata) {
        if (image) {
            NSLog(@"截取成功");
            NSString * path = [NSString stringWithFormat:@"%@/Documents/cutSome.jpg",NSHomeDirectory()];
            
            if( [imagedata writeToFile:path atomically:YES]){
                NSLog(@"保存成功%@",path);
            }
            
            self.imgView.hidden = YES;
            
            UIImageView * imagev = [[UIImageView alloc]initWithImage:image];
            imagev.x = 0;
            imagev.y = 64;
            [self.view addSubview:imagev];
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

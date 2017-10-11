//
//  CDContinueFrameAnimation.m
//  CDFunctionTestProject
//
//  Created by Cindy on 16/7/26.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "CDContinueFrameAnimation.h"

#define IMAGE_COUNT 12
@interface CDContinueFrameAnimation ()
{
    CALayer *_layer;
    int _index;
    NSMutableArray *_images;
}
@end

@implementation CDContinueFrameAnimation

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"逐帧动画";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    
    UIImage *image = [UIImage imageNamed:@"loadingState270-0001"];
    //创建图像显示图层
    _layer=[[CALayer alloc]init];
    _layer.bounds = CGRectMake(0, 0, image.size.width/2.0, image.size.height/2.0);
    _layer.position = self.view.center;
    [self.view.layer addSublayer:_layer];
    
    //由于鱼的图片在循环中会不断创建，而10张鱼的照片相对都很小
    //与其在循环中不断创建UIImage不如直接将10张图片缓存起来
    _images=[NSMutableArray array];
    for (int i=0; i < IMAGE_COUNT; ++i) {
        NSString *imageName=[NSString stringWithFormat:@"loadingState270-000%i.png",i+1];
        UIImage *image=[UIImage imageNamed:imageName];
        [_images addObject:image];
    }
    
    /*
     虽然在核心动画没有直接提供逐帧动画类型，但是却提供了用于完成逐帧动画的相关对象CADisplayLink。CADisplayLink是一个计时器，但是同NSTimer不同的是，CADisplayLink的刷新周期同屏幕完全一致。例如在iOS中屏幕刷新周期是60次/秒，CADisplayLink刷新周期同屏幕刷新一致也是60次/秒，这样一来使用它完成的逐帧动画（又称为“时钟动画”）完全感觉不到动画的停滞情况。
     */
    //定义时钟对象
    CADisplayLink *displayLink=[CADisplayLink displayLinkWithTarget:self selector:@selector(step)];
    //添加时钟对象到主运行循环
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

#pragma mark 每次屏幕刷新就会执行一次此方法(每秒接近60次)
-(void)step
{
    static int s=0; //定义一个变量记录执行次数
    if (++s%4==0) {  //每秒执行15次
        UIImage *image=_images[_index];
        _layer.contents=(id)image.CGImage;//更新图片
        _index=(_index+1)%IMAGE_COUNT;
    }
}

@end

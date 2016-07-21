//
//  CDNavigationController.m
//  MotouchCar_student
//
//  Created by Cindy on 15/8/7.
//  Copyright (c) 2015年 Cindy. All rights reserved.
//

#import "CDNavigationController.h"

// 3.导航栏标题的字体
#define MTNavigationTitleFont [UIFont systemFontOfSize:18.0]
#define  MTNavigationBarTintColorBlack  DefineColorRGB(50, 50, 50, 1.0)

@interface CDNavigationController () <UINavigationControllerDelegate>

@end

@implementation CDNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - setup method
//  设置UINavigationBarTheme的主题
+ (void)setupNavigationBarTheme
{
    UINavigationBar *appearanceNavBar = [UINavigationBar appearance];
    
    /**
     * 去掉导航栏原生的底部黑线
     */
    [appearanceNavBar setShadowImage:[[UIImage alloc] init]];
    UIImage *imageBg = [UIImage imageNamed:@"navigation_bg_color"];
    CGFloat top = 10; // 顶端盖高度
    CGFloat bottom = 10 ; // 底端盖高度
    CGFloat left = 10; // 左端盖宽度
    CGFloat right = 10; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right); //  背景拉伸
    [appearanceNavBar setBackgroundImage:[imageBg resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeTile] forBarMetrics:UIBarMetricsDefault];
    
    /**
     *  设置文字属性
     */
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = MTNavigationBarTintColorBlack;
    // UITextAttributeFont  --> NSFontAttributeName(iOS6)
    textAttrs[NSFontAttributeName] = MTNavigationTitleFont;
    // UIOffsetZero是结构体, 只要包装成NSValue对象, 才能放进字典\数组中
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = [[NSValue valueWithUIOffset:UIOffsetZero] CGSizeValue];
    textAttrs[NSShadowAttributeName] = shadow;
    [appearanceNavBar setTitleTextAttributes:textAttrs];
    [appearanceNavBar setTintColor:MTNavigationBarTintColorBlack];
    
    /**
     *  设置导航栏背景颜色
     */
    [appearanceNavBar setBarTintColor:MTNavigationBarTintColorBlack];
}

/**
 *  设置UIBarButtonItem的主题
 */
+ (void)setupBarButtonItemTheme
{
    // 通过appearance对象能修改整个项目中所有UIBarButtonItem的样式
    UIBarButtonItem *appearanceItem = [UIBarButtonItem appearance];
    
    /**设置文字属性**/
    // 设置普通状态的文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = MTNavigationBarTintColorBlack;
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = [[NSValue valueWithUIOffset:UIOffsetZero] CGSizeValue];
    textAttrs[NSShadowAttributeName] = shadow;
    [appearanceItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置高亮状态的文字属性
    NSMutableDictionary *highTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    highTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [appearanceItem setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
    
    // 设置不可用状态(disable)的文字属性
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [appearanceItem setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
    
    /**设置背景**/
    // 技巧: 为了让某个按钮的背景消失, 可以设置一张完全透明的背景图片
    //    [appearance setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

#pragma mark - view
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /**
     *  为导航栏添加底部阴影
     */
    [self navigationBar].layer.shadowColor = DefineColorRGB(180.0, 180.0, 180.0, 1.0).CGColor; //shadowColor阴影颜色
    [self navigationBar].layer.shadowOffset = CGSizeMake(0.0f , 1.0f); //shadowOffset阴影偏移x，y向(上/下)偏移(-/+)2
    [self navigationBar].layer.shadowOpacity = 0.8f;//阴影透明度，默认0
    [self navigationBar].layer.shadowRadius = 1.0f;//阴影半径
    
    
    /**
     *  设置导航代理
     */
    self.delegate = self;
    self.interactivePopGestureRecognizer.enabled = NO;  //  设置导航手势不可用
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - overwrite method
// 当第一次使用这个类的时候调用1次
+ (void)initialize
{
    // 设置UINavigationBarTheme的主
    [self setupNavigationBarTheme];
    
    // 设置UIBarButtonItem的主题
    [self setupBarButtonItemTheme];
}

/**
 *  能拦截所有push进来的子控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //        viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    if (self.viewControllers.count > 0) { // 如果现在push的不是栈底控制器(最先push进来的那个控制器)
        viewController.hidesBottomBarWhenPushed = YES;
        
        //        if (animated == YES) {
        //            CATransition *animation = [CATransition animation];
        //            [animation setDuration:0.3f];
        //            [animation setType: kCATransitionPush];
        //            [animation setSubtype: kCATransitionFromRight];
        //            [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
        //            [self.view.layer addAnimation:animation forKey:nil];
        //        }
        
    }
    [super pushViewController:viewController animated:YES];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    //    if (animated == YES) {
    //        CATransition *animation = [CATransition animation];
    //        [animation setDuration:0.3f];
    //        [animation setType: kCATransitionPush];
    //        [animation setSubtype: kCATransitionFromLeft];
    //        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    //        [self.view.layer addAnimation:animation forKey:nil];
    //    }
    return [super popViewControllerAnimated:YES];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    return [super popToRootViewControllerAnimated:NO];
}

#pragma mark - bottom tabBar
#pragma mark Delegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}

//- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
//                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController NS_AVAILABLE_IOS(7_0)
//{
//    return nil;
//}

//- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
//                                            animationControllerForOperation:(UINavigationControllerOperation)operation
//                                                         fromViewController:(UIViewController *)fromVC
//                                                           toViewController:(UIViewController *)toVC
//{
//    return [[CDAnimatedTransitioning alloc] init];
//}


@end

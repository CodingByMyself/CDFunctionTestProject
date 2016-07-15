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
#define  MTNavigationBarColorBlack  DefineColor(243, 243, 243, 1.0)
#define  MTNavigationBarTintColorBlack  DefineColor(50, 50, 50, 1.0)

@interface CDNavigationController () <UINavigationControllerDelegate>

@end

@implementation CDNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    self.navigationBar.barTintColor = MTNavigationBarColorBlack;
    return self;
}

#pragma mark - view
/**
 *  当导航控制器的view创建完毕就调用
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    /**
     * 去掉导航栏原生的底部黑线
     */
    [[self navigationBar] setShadowImage:[[UIImage alloc] init]];
    //  背景拉伸
    UIImage *imageBg = [UIImage imageNamed:@"navigation_bg_color"];
    CGFloat top = 10; // 顶端盖高度
    CGFloat bottom = 10 ; // 底端盖高度
    CGFloat left = 10; // 左端盖宽度
    CGFloat right = 10; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    [[self navigationBar] setBackgroundImage:[imageBg resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeTile] forBarMetrics:UIBarMetricsDefault];
    //    [[self navigationBar] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    
    /**
     *  为导航栏添加底部阴影
     */
    [self navigationBar].layer.shadowColor = DefineColor(180.0, 180.0, 180.0, 1.0).CGColor; //shadowColor阴影颜色
    [self navigationBar].layer.shadowOffset = CGSizeMake(0.0f , 1.0f); //shadowOffset阴影偏移x，y向(上/下)偏移(-/+)2
    [self navigationBar].layer.shadowOpacity = 0.8f;//阴影透明度，默认0
    [self navigationBar].layer.shadowRadius = 1.0f;//阴影半径
    
    
    self.delegate = self;
    //  设置导航手势不可用
    self.interactivePopGestureRecognizer.enabled = NO;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

/**
 *  当第一次使用这个类的时候调用1次
 */
+ (void)initialize
{
    // 设置UINavigationBarTheme的主
    [self setupNavigationBarTheme];
    
    // 设置UIBarButtonItem的主题
    [self setupBarButtonItemTheme];
}

/**
 *  设置UINavigationBarTheme的主题
 */
+ (void)setupNavigationBarTheme
{
    UINavigationBar *appearance = [UINavigationBar appearance];
    
    // 设置文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = MTNavigationBarTintColorBlack;
    // UITextAttributeFont  --> NSFontAttributeName(iOS6)
    textAttrs[NSFontAttributeName] = MTNavigationTitleFont;
    // UIOffsetZero是结构体, 只要包装成NSValue对象, 才能放进字典\数组中
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = [[NSValue valueWithUIOffset:UIOffsetZero] CGSizeValue];
    textAttrs[NSShadowAttributeName] = shadow;
    [appearance setTitleTextAttributes:textAttrs];
    [appearance setTintColor:DefineColor(100, 100, 100, 1.0)];
    // 设置导航栏背景颜色
    [appearance setBarTintColor:MTNavigationBarTintColorBlack];
}

/**
 *  设置UIBarButtonItem的主题
 */
+ (void)setupBarButtonItemTheme
{
    // 通过appearance对象能修改整个项目中所有UIBarButtonItem的样式
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    
    /**设置文字属性**/
    // 设置普通状态的文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = MTNavigationBarTintColorBlack;
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = [[NSValue valueWithUIOffset:UIOffsetZero] CGSizeValue];
    textAttrs[NSShadowAttributeName] = shadow;
    [appearance setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置高亮状态的文字属性
    NSMutableDictionary *highTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    highTextAttrs[NSForegroundColorAttributeName] = [UIColor redColor];
    [appearance setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
    
    // 设置不可用状态(disable)的文字属性
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [appearance setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
    
    /**设置背景**/
    // 技巧: 为了让某个按钮的背景消失, 可以设置一张完全透明的背景图片
//    [appearance setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
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

- (void)back
{
    //#warning 这里用的是self, 因为self就是当前正在使用的导航控制器
    [self popViewControllerAnimated:YES];
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

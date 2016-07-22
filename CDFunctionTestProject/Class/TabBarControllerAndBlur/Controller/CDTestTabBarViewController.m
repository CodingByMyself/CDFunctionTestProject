//
//  CDTestTabBarViewController.m
//  CDFunctionTestProject
//
//  Created by Cindy on 16/7/22.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import "CDTestTabBarViewController.h"
#import "ZGDTabBar.h"
#import "CDOneTabBarViewController.h"
#import "CDTwoTabBarViewController.h"
#import "CDThreeTabBarViewController.h"
#import "CDFourTabBarViewController.h"
#import "CDBaseNavigationController.h"


typedef NS_ENUM(NSInteger,LxTabBarControllerSwitchType)
{
    LxTabBarControllerSwitchTypeUnknown,
    LxTabBarControllerSwitchTypeLast,
    LxTabBarControllerSwitchTypeNext,
};


static CGFloat const TRANSITION_DURATION = 0.2;
static LxTabBarControllerSwitchType _switchType = LxTabBarControllerSwitchTypeUnknown;
@interface Transition : NSObject<UIViewControllerAnimatedTransitioning>

@end


@implementation Transition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return TRANSITION_DURATION;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    [containerView insertSubview:toViewController.view aboveSubview:fromViewController.view];
    CGRect fromViewControllerViewFrame = fromViewController.view.frame;
    CGRect toViewControllerViewFrame = toViewController.view.frame;
    switch (_switchType) {
        case LxTabBarControllerSwitchTypeLast:
        {
            fromViewControllerViewFrame.origin.x = containerView.frame.size.width;
            toViewControllerViewFrame.origin.x = -containerView.frame.size.width;
        }
            break;
        case LxTabBarControllerSwitchTypeNext:
        {
            fromViewControllerViewFrame.origin.x = -containerView.frame.size.width;
            toViewControllerViewFrame.origin.x = containerView.frame.size.width;
        }
            break;
        case LxTabBarControllerSwitchTypeUnknown:
        {
            return;
        }
            break;
        default:
            break;
    }
    toViewController.view.frame = toViewControllerViewFrame;
    [UIView animateWithDuration:TRANSITION_DURATION animations:^{
        fromViewController.view.frame = fromViewControllerViewFrame;
        toViewController.view.frame = transitionContext.containerView.bounds;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end


#pragma mark  - CDTestTabBarViewController -
@interface CDTestTabBarViewController ()<UITabBarControllerDelegate,UIGestureRecognizerDelegate,ZGDTabBarDelegate>
{
    UIPanGestureRecognizer * _panToSwitchGestureRecognizer;
    UIPercentDrivenInteractiveTransition * _interactiveTransition;
}
@property (strong, nonatomic) Transition *transitionAnimator;
@end

@implementation CDTestTabBarViewController

@synthesize isTranslating = _isTranslating;
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}


- (void)setup
{
    self.delegate = self;
    _panToSwitchGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizerTriggerd:)];
    _transitionAnimator = [Transition new];
    [self.view addGestureRecognizer:_panToSwitchGestureRecognizer];
}

- (void)panGestureRecognizerTriggerd:(UIPanGestureRecognizer *)pan
{
    self.tabBar.userInteractionEnabled = NO;
    CGFloat progress = [pan translationInView:pan.view].x / (self.view.frame.size.width);
    
    if (progress > 0) {
        _switchType = LxTabBarControllerSwitchTypeLast;
    }else if (progress < 0)
    {
        _switchType = LxTabBarControllerSwitchTypeNext;
    }else
    {
        _switchType = LxTabBarControllerSwitchTypeUnknown;
    }
    progress = MIN(1.0, MAX(0.0, ABS(progress)));
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            _isTranslating = YES;
            _interactiveTransition = [UIPercentDrivenInteractiveTransition new];
            switch (_switchType) {
                case LxTabBarControllerSwitchTypeLast:
                {
                    self.selectedIndex = MAX(0, self.selectedIndex - 1);
                    self.selectedViewController = self.viewControllers[self.selectedIndex];
                }
                    break;
                case LxTabBarControllerSwitchTypeNext:
                {
                    self.selectedIndex = MIN(self.viewControllers.count, self.selectedIndex + 1);
                    self.selectedViewController = self.viewControllers[self.selectedIndex];
                }
                    break;
                case LxTabBarControllerSwitchTypeUnknown:
                {
                    
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            [_interactiveTransition updateInteractiveTransition:progress];
        }
            break;
        case UIGestureRecognizerStateFailed:
        {
            _isTranslating = NO;
            self.tabBar.userInteractionEnabled = YES;
        }
            break;
        default:
        {
            if (ABS(progress) > 0.5) {
                [_interactiveTransition finishInteractiveTransition];
            }else
            {
                [_interactiveTransition cancelInteractiveTransition];
            }
            _interactiveTransition = nil;
            _isTranslating = NO;
            //enable tabbar when transition ended
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(TRANSITION_DURATION * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.tabBar.userInteractionEnabled = YES;
            });
        }
            break;
    }
}

#pragma mark - view
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    CDOneTabBarViewController *one = [[CDOneTabBarViewController alloc] init];
    [self addChildVC:one title:@"首页" imageName:@"tabbar_home" seletedImage:@"tabbar_home_selected"];
    
    CDTwoTabBarViewController *two = [[CDTwoTabBarViewController alloc] init];
    [self addChildVC:two title:@"消息" imageName:@"tabbar_message_center" seletedImage:@"tabbar_message_center_selected"];
    
    CDThreeTabBarViewController *three = [[CDThreeTabBarViewController alloc] init];
    [self addChildVC:three title:@"发现" imageName:@"tabbar_discover" seletedImage:@"tabbar_discover_selected"];
    
    CDFourTabBarViewController *four = [[CDFourTabBarViewController alloc] init];
    [self addChildVC:four title:@"我" imageName:@"tabbar_profile" seletedImage:@"tabbar_profile_selected"];
    
    ZGDTabBar *tabbar = [ZGDTabBar new];
    tabbar.delegate = self;
    [self setValue:tabbar forKeyPath:@"tabBar"];
    
}

- (void)addChildVC:(UIViewController *)childVC title:(NSString *)title imageName:(NSString *)imageName seletedImage:(NSString *)seletedImageName
{
    
    childVC.title = title;
    CDBaseNavigationController *nav = [[CDBaseNavigationController alloc] initWithRootViewController:childVC];
    
    
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:seletedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = DefineColorRGB(123, 123, 123,1.0);
    
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    [childVC.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVC.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    [self addChildViewController:nav];
}

#pragma mark - UITabBarControllerDelegate
- (id<UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    if (self.view.window) {
        return [animationController isKindOfClass:[Transition class]] ? _interactiveTransition : nil;
    }
    else {
        return nil;
    }
}
- (id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
           animationControllerForTransitionFromViewController:(UIViewController *)fromVC
                                             toViewController:(UIViewController *)toVC
{
    
    
    if (self.view.window) {
        return self.transitionAnimator;
    }
    else {
        return nil;
    }
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    NSInteger viewControllerIndex = [tabBarController.viewControllers indexOfObject:viewController];
    if (viewControllerIndex > self.selectedIndex) {
        _switchType = LxTabBarControllerSwitchTypeNext;
    }else if (viewControllerIndex < self.selectedIndex) {
        _switchType = LxTabBarControllerSwitchTypeLast;
    }
    else {
        _switchType = LxTabBarControllerSwitchTypeUnknown;
    }
    return YES;
}

#pragma mark - ZGDTabBarDelegate
- (void)ZGDTabBarClickPlusBtn:(ZGDTabBar *)tabbar
{
    //    ComposeViewController *vc = [[ComposeViewController alloc] init];
    //
    //    HWNavigationController *nav = [[HWNavigationController alloc] initWithRootViewController:vc];
    //    [self presentViewController:nav animated:YES completion:^{
    //
    //    }];
}
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    CATransition *transition = [CATransition animation];
    transition.duration = 1;
    transition.type = @"rippleEffect";
    [self.view.layer addAnimation:transition forKey:@"path"];
}


@end

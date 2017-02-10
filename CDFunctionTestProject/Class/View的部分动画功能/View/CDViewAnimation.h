//
//  CDViewAnimation.h
//  CDFunctionTestProject
//
//  Created by Cindy on 16/7/18.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDViewAnimation : UIView

- (void)startFlipAnimation:(CGFloat)animation onSubviewOne:(UIView *)subviewFirst subviewTwo:(UIView *)subviewSeconde;


- (void)stratWaveAnimationWithOriginSize:(CGSize)size;
- (void)stopWaveAnimation;

@end

//
//  CDHeaderDefine.h
//  CDCategoryAndDefine
//
//  Created by Cindy on 16/6/30.
//  Copyright © 2016年 Cindy. All rights reserved.
//

#ifndef CDHeaderDefine_h
#define CDHeaderDefine_h


/**
 *  导航栏标题的字体
 */
#define MTNavigationTitleFont [UIFont systemFontOfSize:20.0]
#define  MTNavigationBarItemTintColorBlack  DefineColorRGB(50, 50, 50, 1.0)
#define  MTNavigationBarBgTintColorBlack  [UIColor whiteColor]



/**
 *  关于日志输出的宏定义
 */
// Log 开关控制
#define DEBUG_MODE   //  如果发布线上则可以注释此宏，开发模式下再打开此宏

#ifdef DEBUG_MODE // 调试状态, 打开LOG功能
        // Log 颜色控制
        #define XCODE_COLORS_ESCAPE @"\033["
        #define XCODE_COLORS_RESET_FG  XCODE_COLORS_ESCAPE @"fg;" // Clear any foreground color
        #define XCODE_COLORS_RESET_BG  XCODE_COLORS_ESCAPE @"bg;" // Clear any background color
        #define XCODE_COLORS_RESET     XCODE_COLORS_ESCAPE @";"   // Clear any foreground or background color

        // 替换NSLog来使用，debug模式下可以打印日志输出的详细信息。如：日志所在的方法名、行信息等
        #define MTLog(...) NSLog(__VA_ARGS__)  // 不需要任何其他详细信息
        #define MTDetailLog(fmt, ...) NSLog((@"--------------------------> %@ [Line %d] \n"fmt "\n\n\n"), [[NSString stringWithFormat:@"%s",__FILE__] lastPathComponent], __LINE__, ##__VA_ARGS__); //  black正常黑色日志输出
        #define MTDetailLogBlue(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg0,0,255; --------------------------> %@ [Line %d] \n" frmt "\n\n"      XCODE_COLORS_RESET), [[NSString stringWithFormat:@"%s",__FILE__] lastPathComponent], __LINE__,##__VA_ARGS__); //  bule蓝色日志输出
        #define MTDetailLogRed(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg255,0,0; --------------------------> %@ [Line %d] \n" frmt "\n\n" XCODE_COLORS_RESET),[[NSString stringWithFormat:@"%s",__FILE__] lastPathComponent], __LINE__, ##__VA_ARGS__); //  red红色日志输出
    //DEBUG模式下打印日志,当前行以及弹出一个警告
        #define MTAlertLog(fmt, ...)  { UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert Log" message:[NSString stringWithFormat:@"%@\n\n%@",[NSString stringWithFormat:@"%@\n[Line %d] ", [[NSString stringWithFormat:@"%s",__FILE__] lastPathComponent], __LINE__],[NSString stringWithFormat:fmt, ##__VA_ARGS__]]  delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil]; [alert show];}
#else // 发布状态, 关闭LOG功能
        #define MTLog(...)
        #define MTDetailLog(...)
        #define MTDetailLogBlue(...)
        #define MTDetailLogRed(frmt, ...)
        #define MTAlertLog(...)
#endif


/**
 *  判断是真机还是模拟器
 */
#if TARGET_OS_IPHONE
        //iPhone Device
        #define  DefineTureDevice  1   //  真机
#else
        //iPhone Simulator
        #define  DefineTureDevice  0   //  模拟器
#endif


/**
 *  获得指定颜色值的实例
 *  @param r R值
 *  @param g G值
 *  @param b B值
 *  @param a 透明度
 *  @return UIColor的一个实例
 */
#define DefineColorRGB(r, g, b, a)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
/**
 *  获得指定颜色值的实例
 *  @param hexValue 十六进制颜色值
 *  @return UIColor的一个实例
 */
#define DefineColorHEX(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]  // rgb颜色转换（16进制->10进制）



/**
 *  获得指定的字体实例
 *  @param size 字体大小
 *  @return UIFont的一个实例
 */
#define FontBaseSize 15.0f   // 直接调整该值即可放大或缩小整App的字体
#define DefineFontSystem(textSize)  [UIFont systemFontOfSize:(textSize)]
#define DefineFont(fontName,textSize)  [UIFont fontWithName:(fontName) size:(textSize)]
#define DefineFontLaoSangamMN(textSize)  [UIFont fontWithName:@"LaoSangamMN" size:(textSize)]
#define DefineFontHelveticaNeue(textSize)  [UIFont fontWithName:@"HelveticaNeue" size:(textSize)]




/**
 *  获得当前设备的物理高和宽
 *  @return 设备的高和宽
 */
#define DefineScreenWidth  ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)
#define DefineScreenHeight  ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)
// 判断手机型号
#define  iPhone6P   (DefineScreenHeight == 736.0)
#define  iPhone6    (DefineScreenHeight == 667.0)
#define  iPhone5    (DefineScreenHeight == 568.0)
#define  iPhone4    (DefineScreenHeight == 480.0)


// 当前运行的SDK版本号
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]




















































































#endif /* CDHeaderDefine_h */

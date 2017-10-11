//
//  CDLibHeader.h
//  CTPUILibraryDemo
//
//  Created by Cindy on 2017/10/10.
//  Copyright © 2017年 xiongwenjie. All rights reserved.
//

#ifndef CDLibHeader_h
#define CDLibHeader_h


#import <Masonry/Masonry.h>



//获取设备的物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

//获取设备的物理宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width


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



#pragma mark - 关于日志输出
/**
 *  关于日志输出的宏定义
 */
// Log 开关控制
#ifndef __OPTIMIZE__ // 调试状态, 打开LOG功能
// 详细日志输出
#define EOADetailLog(fmt, ...) NSLog((@"--------------------------> %@ [Line %d] \n" fmt "\n\n"), [[NSString stringWithFormat:@"%s",__FILE__] lastPathComponent], __LINE__, ##__VA_ARGS__);
#else // 发布状态, 关闭LOG功能
#define EOADetailLog(...)
#endif








#endif /* CDLibHeader_h */

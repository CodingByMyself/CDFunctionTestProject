//
//  CDLinkLabel.h
//  EOA
//
//  Created by Cindy on 2017/8/7.
//
//  备注：实现方式取材自GitHub上的KZLinkLabel第三方库，并在源码的基础上做了个性化修改而得到CDLinkLabel


#import <UIKit/UIKit.h>
#import "NSAttributedString+Emotion.h"
@class CDLinkLabel;


/**
 点击回调时的链接类型
 */
typedef NS_ENUM(NSInteger, CDLinkType)
{
    CDLinkTypeUserHandle,     //用户昵称  eg: @kingzwt
    CDLinkTypeHashTag,        //内容标签  eg: #hello
    CDLinkTypeURL,            //链接地址  eg: http://www.baidu.com
    CDLinkTypePhoneNumber     //电话号码  eg: 1366666666
};


/**
 可以识别的链接类型
 */
typedef NS_OPTIONS(NSUInteger, CDLinkDetectionTypes)
{
    CDLinkDetectionTypeUserHandle  = (1 << 0),
    CDLinkDetectionTypeHashTag     = (1 << 1),
    CDLinkDetectionTypeURL         = (1 << 2),
    CDLinkDetectionTypePhoneNumber = (1 << 3),
    CDLinkDetectionTypeNone        = 0,
    CDLinkDetectionTypeAll         = NSUIntegerMax
};


typedef NS_OPTIONS(NSUInteger, CDLinkAlertMenuTypes)
{
    CDLinkAlertMenuTypeCopy = 0,  // 复制
    CDLinkAlertMenuTypeDelete, // 删除
    CDLinkAlertMenuTypeReply,  // 回复
    CDLinkAlertMenuTypeOther  // 其他
};


typedef void (^CDLinkHandler)(CDLinkType linkType, NSString *string, NSRange range);


UIKIT_EXTERN NSString *ALERT_MENU_TITLE_KEY;
UIKIT_EXTERN NSString *ALERT_MENU_TYPE_KEY;



@protocol CDLinkLabelAlertMenuDelegate <NSObject>

@optional
- (void)linkLabel:(CDLinkLabel *)linkLabel didSelectedAlertMenuType:(CDLinkAlertMenuTypes)menuType;

@required
- (NSArray <NSDictionary *> *)alertMenuListOnLongPressLinkLabel:(CDLinkLabel *)linkLabel;

@end

@interface CDLinkLabel : UILabel <NSLayoutManagerDelegate>


#pragma mark - 长安弹出菜单 功能
@property (nonatomic, weak) id <CDLinkLabelAlertMenuDelegate> alertMenuDelegate;
// 初始字符内容(转码之前)
@property (nonatomic, copy) NSString *originalString;
@property (nonatomic,assign) BOOL enableAlertMenus;




#pragma mark
/**
 是否允许识别链接，默认是否
 */
@property (nonatomic, assign, getter = isAutomaticLinkDetectionEnabled) BOOL automaticLinkDetectionEnabled;


/**
 识别出来的链接设置的颜色
 */
@property (nonatomic, strong) UIColor *linkColor;

/**
 链接高亮时设置的颜色
 */
@property (nonatomic, strong) UIColor *linkHighlightColor;

/**
 链接的背景颜色
 */
@property (nonatomic, strong) UIColor *linkBackgroundColor;

/**
 需要识别的链接类型，多个识别类型则用逻辑或“|”来连接；
 如： CDLinkDetectionTypeURL | CDLinkDetectionTypePhoneNumber
 */
@property (nonatomic, assign) CDLinkDetectionTypes linkDetectionTypes;

/**
 连接点击后的处理回调
 */
@property (nonatomic, copy) CDLinkHandler linkTapHandler;

/**
 连接长按时的处理回调
 */
@property (nonatomic, copy) CDLinkHandler linkLongPressHandler;

@end

//
//  CDLinkLabel.m
//  EOA
//
//  Created by Cindy on 2017/8/7.
//
//

#import "CDLinkLabel.h"
#import <objc/runtime.h>
#import "CDLibHeader.h"



@implementation CDAlertMenuModel
- (NSString *)menuName
{
    if (_menuName.length > 0) {
        return _menuName;
    } else {
        return @"";
    }
}

- (instancetype)initWithMenuType:(CDLinkAlertMenuTypes)type andMenuName:(NSString *)name
{
    self = [super init];
    if (self) {
        self.menuName = name;
        self.menuType = type;
    }
    return self;
}
@end


#pragma mark -
@interface CDLinkLabel()

@property (nonatomic, retain) NSLayoutManager *layoutManager;

@property (nonatomic, retain) NSTextContainer *textContainer;

@property (nonatomic, retain) NSTextStorage *textStorage;

@property (nonatomic, copy) NSArray *linkRanges;

@property (nonatomic, assign) BOOL isTouchMoved;

@property (nonatomic, assign) NSRange selectedRange;

//@property (nonatomic,strong) NSArray <NSString *> *alertMenus;

@end

@implementation CDLinkLabel


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        [self setupTextSystem];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self){
        [self setupTextSystem];
    }
    return self;
}
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.textContainer.size = self.bounds.size;
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    self.textContainer.size = self.bounds.size;
}
- (void)setNumberOfLines:(NSInteger)numberOfLines
{
    [super setNumberOfLines:numberOfLines];
    self.textContainer.maximumNumberOfLines = numberOfLines;
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:text
                                                                         attributes:[self attributesFromProperties]];
    [self updateTextStoreWithAttributedString:attributedText];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self updateTextStoreWithAttributedString:attributedText];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textContainer.size = self.bounds.size;
}
- (void)setupTextSystem
{
    self.textContainer = [[NSTextContainer alloc] init];
    self.textContainer.lineFragmentPadding = 0;
    self.textContainer.maximumNumberOfLines = self.numberOfLines;
    self.textContainer.lineBreakMode = self.lineBreakMode;
    self.textContainer.size = self.frame.size;
    
    self.layoutManager = [[NSLayoutManager alloc] init];
    self.layoutManager.delegate = self;
    [self.layoutManager addTextContainer:self.textContainer];
    
    [self.textContainer setLayoutManager:self.layoutManager];
    
    self.userInteractionEnabled = YES;
    
    _automaticLinkDetectionEnabled = YES;
    
    _linkDetectionTypes = CDLinkDetectionTypeAll;
    
    self.linkBackgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    self.linkColor = [UIColor blueColor];
    self.linkHighlightColor = [UIColor redColor];
    
    [self updateTextStoreWithText];
    
#pragma mark 禁止了CDLinkLable的长按事件
    //    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressLabel:)];
    //    [self addGestureRecognizer:longPressGesture];
    
    //默认的回调
    self.linkTapHandler = ^(CDLinkType linkType, NSString *string, NSRange range) {
        NSLog(@"Link Tap Handler");
    };
    self.linkLongPressHandler = ^(CDLinkType linkType, NSString *string, NSRange range){
        NSLog(@"Link Long Press Handler");
    };
}
- (void)setAutomaticLinkDetectionEnabled:(BOOL)decorating
{
    _automaticLinkDetectionEnabled = decorating;
    [self updateTextStoreWithText];
}

- (void)setLinkDetectionTypes:(CDLinkDetectionTypes)linkDetectionTypes
{
    _linkDetectionTypes = linkDetectionTypes;
    [self updateTextStoreWithText];
}
- (void)setLinkColor:(UIColor *)linkColor
{
    _linkColor = linkColor;
    [self updateTextStoreWithText];
}
- (void)setLinkBackgroundColor:(UIColor *)linkBackgroundColor
{
    _linkBackgroundColor = linkBackgroundColor;
    [self updateTextStoreWithText];
}
- (void)setLinkHighlightColor:(UIColor *)linkHighlightColor
{
    _linkHighlightColor = linkHighlightColor;
    [self updateTextStoreWithText];
}
/*
 * linkType : 链接类型
 * range    : 链接区域
 * link     : 链接文本
 */
- (NSDictionary *)getLinkAtLocation:(CGPoint)location
{
    // Do nothing if we have no text
    if (self.textStorage.string.length == 0)
    {
        return nil;
    }
    
    // Work out the offset of the text in the view
    CGPoint textOffset;
    NSRange glyphRange = [self.layoutManager glyphRangeForTextContainer:self.textContainer];
    textOffset = [self calcTextOffsetForGlyphRange:glyphRange];
    
    // Get the touch location and use text offset to convert to text cotainer coords
    location.x -= textOffset.x;
    location.y -= textOffset.y;
    
    NSUInteger touchedChar = [self.layoutManager glyphIndexForPoint:location inTextContainer:self.textContainer];
    
    // If the touch is in white space after the last glyph on the line we don't
    // count it as a hit on the text
    NSRange lineRange;
    CGRect lineRect = [self.layoutManager lineFragmentUsedRectForGlyphAtIndex:touchedChar effectiveRange:&lineRange];
    if (CGRectContainsPoint(lineRect, location) == NO)
    {
        return nil;
    }
    
    // Find the word that was touched and call the detection block
    for (NSDictionary *dictionary in self.linkRanges)
    {
        NSRange range = [[dictionary objectForKey:@"range"] rangeValue];
        
        if ((touchedChar >= range.location) && touchedChar < (range.location + range.length))
        {
            return dictionary;
        }
    }
    
    return nil;
}

// Applies background colour to selected range. Used to hilight touched links
- (void)setSelectedRange:(NSRange)range
{
    //删除之前选中的链接属性
    if (self.selectedRange.length && !NSEqualRanges(self.selectedRange, range)) {
        [self.textStorage removeAttribute:NSBackgroundColorAttributeName
                                    range:self.selectedRange];
        [self.textStorage addAttribute:NSForegroundColorAttributeName
                                 value:self.linkColor
                                 range:self.selectedRange];
    }
    
    //选中链接绘制新颜色
    if (range.length) {
        [self.textStorage addAttribute:NSBackgroundColorAttributeName
                                 value:self.linkBackgroundColor
                                 range:range];
        [self.textStorage addAttribute:NSForegroundColorAttributeName
                                 value:self.linkHighlightColor
                                 range:range];
    }
    _selectedRange = range;
    [self setNeedsDisplay];
}
- (void)updateTextStoreWithText
{
    if (self.attributedText)
    {
        [self updateTextStoreWithAttributedString:self.attributedText];
    }
    else if (self.text)
    {
        [self updateTextStoreWithAttributedString:[[NSAttributedString alloc] initWithString:self.text attributes:[self attributesFromProperties]]];
    }
    else
    {
        [self updateTextStoreWithAttributedString:[[NSAttributedString alloc] initWithString:@"" attributes:[self attributesFromProperties]]];
    }
    [self setNeedsDisplay];
}
- (void)updateTextStoreWithAttributedString:(NSAttributedString *)attributedString
{
    if (attributedString.length != 0){
        attributedString = [CDLinkLabel sanitizeAttributedString:attributedString];
    }
    
    if (self.isAutomaticLinkDetectionEnabled && (attributedString.length != 0)) {
        //获取所有类型的链接
        self.linkRanges = [self getRangesForLinks:attributedString];
        //对所有连接添加链接属性
        attributedString = [self addLinkAttributesToAttributedString:attributedString linkRanges:self.linkRanges];
    } else {
        self.linkRanges = nil;
    }
    
    if (self.textStorage) {
        [self.textStorage setAttributedString:attributedString];
    } else {
        self.textStorage = [[NSTextStorage alloc] initWithAttributedString:attributedString];
        [self.textStorage addLayoutManager:self.layoutManager];
        [self.layoutManager setTextStorage:self.textStorage];
    }
}

#pragma mark  识别出来的文字属性设置
/*
 * 链接文本属性
 */
- (NSAttributedString *)addLinkAttributesToAttributedString:(NSAttributedString *)string linkRanges:(NSArray *)linkRanges
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:string];
    
    NSDictionary *attributes = @{ NSForegroundColorAttributeName : self.linkColor,
                                  NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle] };
    
    for (NSDictionary *dictionary in linkRanges)
    {
        NSRange range = [[dictionary objectForKey:@"range"] rangeValue];
        [attributedString addAttributes:attributes range:range];
        
        //链接地址
        //        if ((KZLinkType)[dictionary[@"linkType"] intValue] == KZLinkTypeURL)
        //        {
        //            [attributedString addAttribute:NSLinkAttributeName
        //                                     value:dictionary[@"link"]
        //                                     range:range];
        //        }
    }
    return attributedString;
}

/*
 * 普通文本属性
 */
- (NSDictionary *)attributesFromProperties
{
    //阴影属性
    NSShadow *shadow = shadow = [[NSShadow alloc] init];
    if (self.shadowColor){
        shadow.shadowColor = self.shadowColor;
        shadow.shadowOffset = self.shadowOffset;
    } else {
        shadow.shadowOffset = CGSizeMake(0, -1);
        shadow.shadowColor = nil;
    }
    
    //颜色属性
    UIColor *color = self.textColor;
    if (!self.isEnabled){
        color = [UIColor lightGrayColor];
    } else if (self.isHighlighted) {
        color = self.highlightedTextColor;
    }
    
    //段落属性
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = self.textAlignment;
    
    //属性字典
    NSDictionary *attributes = @{
                                 NSFontAttributeName : self.font,
                                 NSForegroundColorAttributeName : color,
                                 NSShadowAttributeName : shadow,
                                 NSParagraphStyleAttributeName : paragraph
                                 };
    return attributes;
}
/*
 * 修正换行模式
 */
+ (NSAttributedString *)sanitizeAttributedString:(NSAttributedString *)attributedString
{
    NSRange range;
    NSParagraphStyle *paragraphStyle = [attributedString attribute:NSParagraphStyleAttributeName atIndex:0 effectiveRange:&range];
    
    if (paragraphStyle == nil)
    {
        return attributedString;
    }
    
    // Remove the line breaks
    NSMutableParagraphStyle *mutableParagraphStyle = [paragraphStyle mutableCopy];
    mutableParagraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    
    // Apply new style
    NSMutableAttributedString *restyled = [[NSMutableAttributedString alloc] initWithAttributedString:attributedString];
    [restyled addAttribute:NSParagraphStyleAttributeName value:mutableParagraphStyle range:NSMakeRange(0, restyled.length)];
    
    return restyled;
}

/*
 * 可扩展部分,不同的Link类型
 */
- (NSArray *)getRangesForLinks:(NSAttributedString *)text
{
    NSMutableArray *rangesForLinks = [[NSMutableArray alloc] init];
    //用户昵称
    if (self.linkDetectionTypes & CDLinkDetectionTypeUserHandle)
    {
        [rangesForLinks addObjectsFromArray:[self getRangesForUserHandles:text.string]];
    }
    //内容标签
    if (self.linkDetectionTypes & CDLinkDetectionTypeHashTag)
    {
        [rangesForLinks addObjectsFromArray:[self getRangesForHashTags:text.string]];
    }
    //链接地址
    if (self.linkDetectionTypes & CDLinkDetectionTypeURL)
    {
        [rangesForLinks addObjectsFromArray:[self getRangesForURLs:self.attributedText]];
    }
    //电话号码
    if (self.linkDetectionTypes & CDLinkDetectionTypePhoneNumber)
    {
        [rangesForLinks addObjectsFromArray:[self getRangesForPhoneNumbers:text.string]];
    }
    //......
    
    return rangesForLinks;
}
/*
 * 所有用户昵称
 */
- (NSArray *)getRangesForUserHandles:(NSString *)text
{
    NSMutableArray *rangesForUserHandles = [[NSMutableArray alloc] init];
    NSError *error = nil;
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:@"(?<!\\w)@([\\w\\_]+)?"
                                                                      options:0
                                                                        error:&error];
    NSArray *matches = [regex matchesInString:text
                                      options:0
                                        range:NSMakeRange(0, text.length)];
    for (NSTextCheckingResult *match in matches)
    {
        NSRange matchRange = [match range];
        NSString *matchString = [text substringWithRange:matchRange];
        
        [rangesForUserHandles addObject:@{
                                          @"linkType" : @(CDLinkTypeUserHandle),
                                          @"range"    : [NSValue valueWithRange:matchRange],
                                          @"link"     : matchString
                                          }];
    }
    return rangesForUserHandles;
}
/*
 * 所有内容标签
 */
- (NSArray *)getRangesForHashTags:(NSString *)text
{
    NSMutableArray *rangesForHashTags = [[NSMutableArray alloc] init];
    NSError *error = nil;
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:@"(?<!\\w)#([\\w\\_]+)?"
                                                                      options:0
                                                                        error:&error];
    NSArray *matches = [regex matchesInString:text
                                      options:0
                                        range:NSMakeRange(0, text.length)];
    for (NSTextCheckingResult *match in matches)
    {
        NSRange matchRange = [match range];
        NSString *matchString = [text substringWithRange:matchRange];
        
        [rangesForHashTags addObject:@{
                                       @"linkType" : @(CDLinkTypeHashTag),
                                       @"range"    : [NSValue valueWithRange:matchRange],
                                       @"link"     : matchString
                                       }];
    }
    return rangesForHashTags;
}
/*
 * 所有链接地址
 */
- (NSArray *)getRangesForURLs:(NSAttributedString *)text
{
    NSMutableArray *rangesForURLs = [[NSMutableArray alloc] init];;
    NSError *error = nil;
    NSString *plainText = text.string;
    
    
    //    NSDataDetector *detector = [[NSDataDetector alloc] initWithTypes:NSTextCheckingTypeLink error:&error];
    //    NSArray *matches = [detector matchesInString:plainText
    //                                         options:0
    //                                           range:NSMakeRange(0, text.length)];
    //
    //    for (NSTextCheckingResult *match in matches)
    //    {
    //        NSRange matchRange = [match range];
    //
    //        NSString *realURL = [text attribute:NSLinkAttributeName
    //                                    atIndex:matchRange.location
    //                             effectiveRange:nil];
    //        if (realURL == nil){
    //            realURL = [plainText substringWithRange:matchRange];
    //        }
    //
    //        if ([match resultType] == NSTextCheckingTypeLink){
    //            [rangesForURLs addObject:@{
    //                                        @"linkType" : @(KZLinkTypeURL),
    //                                        @"range"    : [NSValue valueWithRange:matchRange],
    //                                        @"link"     : realURL
    //                                      }];
    //        }
    //    }
    
    // 修改了部分源码
    //可以识别url的正则表达式
    NSString *regulaStr = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z0-9]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *matches = [regex matchesInString:plainText options:0 range:NSMakeRange(0, [plainText length])];
    
    for (NSTextCheckingResult *match in matches) {
        NSRange matchRange = [match range];
        NSString *realURL = [plainText substringWithRange:match.range];
        if (realURL.length > 0) {
            [rangesForURLs addObject:@{@"linkType" : @(CDLinkTypeURL),
                                       @"range"    : [NSValue valueWithRange:matchRange],
                                       @"link"     : realURL}];
        }
    }
    
    
    return rangesForURLs;
}
/*
 * 所有电话号码
 */
- (NSArray *)getRangesForPhoneNumbers:(NSString *)text
{
    NSMutableArray *rangesForPhoneNumbers = [[NSMutableArray alloc] init];;
    NSError *error = nil;
    NSDataDetector *detector = [[NSDataDetector alloc] initWithTypes:NSTextCheckingTypePhoneNumber error:&error];
    
    NSArray *matches = [detector matchesInString:text
                                         options:0
                                           range:NSMakeRange(0, text.length)];
    
    for (NSTextCheckingResult *match in matches)
    {
        NSRange matchRange = [match range];
        NSString *matchString = [text substringWithRange:matchRange];
        
        if ([match resultType] == NSTextCheckingTypePhoneNumber){
            [rangesForPhoneNumbers addObject:@{
                                               @"linkType" : @(CDLinkTypePhoneNumber),
                                               @"range"    : [NSValue valueWithRange:matchRange],
                                               @"link"     : matchString
                                               }];
        }
    }
    return rangesForPhoneNumbers;
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Layout and Rendering
/*
 * 绘制文本相关方法
 */
- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{
    // Use our text container to calculate the bounds required. First save our
    // current text container setup
    CGSize savedTextContainerSize = self.textContainer.size;
    NSInteger savedTextContainerNumberOfLines = self.textContainer.maximumNumberOfLines;
    
    // Apply the new potential bounds and number of lines
    self.textContainer.size = bounds.size;
    self.textContainer.maximumNumberOfLines = numberOfLines;
    
    // Measure the text with the new state
    CGRect textBounds;
    @try
    {
        NSRange glyphRange = [self.layoutManager glyphRangeForTextContainer:self.textContainer];
        textBounds = [self.layoutManager boundingRectForGlyphRange:glyphRange inTextContainer:self.textContainer];
        
        // Position the bounds and round up the size for good measure
        textBounds.origin = bounds.origin;
        textBounds.size.width = ceilf(textBounds.size.width);
        textBounds.size.height = ceilf(textBounds.size.height);
    }
    @finally
    {
        // Restore the old container state before we exit under any circumstances
        self.textContainer.size = savedTextContainerSize;
        self.textContainer.maximumNumberOfLines = savedTextContainerNumberOfLines;
    }
    return textBounds;
}

- (void)drawTextInRect:(CGRect)rect
{
    // Don't call super implementation. Might want to uncomment this out when
    // debugging layout and rendering problems.
    //        [super drawTextInRect:rect];
    
    // Calculate the offset of the text in the view
    CGPoint textOffset;
    NSRange glyphRange = [self.layoutManager glyphRangeForTextContainer:self.textContainer];
    textOffset = [self calcTextOffsetForGlyphRange:glyphRange];
    
    // Drawing code
    [self.layoutManager drawBackgroundForGlyphRange:glyphRange atPoint:textOffset];
    [self.layoutManager drawGlyphsForGlyphRange:glyphRange atPoint:textOffset];
}

// Returns the XY offset of the range of glyphs from the view's origin
- (CGPoint)calcTextOffsetForGlyphRange:(NSRange)glyphRange
{
    CGPoint textOffset = CGPointZero;
    
    CGRect textBounds = [self.layoutManager boundingRectForGlyphRange:glyphRange inTextContainer:self.textContainer];
    CGFloat paddingHeight = (self.bounds.size.height - textBounds.size.height) / 2.0f;
    if (paddingHeight > 0)
    {
        textOffset.y = paddingHeight;
    }
    
    return textOffset;
}
#pragma mark - Layout manager delegate
/*
 * 链接是否换行
 */
-(BOOL)layoutManager:(NSLayoutManager *)layoutManager shouldBreakLineByWordBeforeCharacterAtIndex:(NSUInteger)charIndex
{
    for (NSDictionary *dictionary in self.linkRanges)
    {
        NSRange range = [[dictionary objectForKey:@"range"] rangeValue];
        CDLinkType linkType = [[dictionary objectForKey:@"linkType"] integerValue];
        if (linkType == CDLinkTypeURL) {
            if ((charIndex > range.location) && charIndex <= (range.location + range.length)) {
                return NO;
            }
        }
    }
    return YES;
    
    //在链接内的文本不换行
    //    NSRange range;
    //    NSURL *linkURL = [layoutManager.textStorage attribute:NSLinkAttributeName
    //                                                  atIndex:charIndex
    //                                           effectiveRange:&range];
    //
    //    return !(linkURL && (charIndex > range.location) && (charIndex <= NSMaxRange(range)));
}

#pragma mark - Interactions
- (IBAction)longPressLabel:(UILongPressGestureRecognizer *)recognizer
{
    if ((recognizer.view != self) || (recognizer.state != UIGestureRecognizerStateBegan)) {
        return;
    }
    CGPoint location = [recognizer locationInView:self];
    NSDictionary *link = [self getLinkAtLocation:location];
    if (link) {
        NSRange range = [[link objectForKey:@"range"] rangeValue];
        NSString *linkString = [link objectForKey:@"link"];
        CDLinkType linkType = (CDLinkType)[[link objectForKey:@"linkType"] intValue];
        self.linkLongPressHandler(linkType, linkString, range);
    } else {
        return;
    }
}

/*
 * 触摸事件
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.isTouchMoved = NO;
    
    CGPoint touchLocation = [[touches anyObject] locationInView:self];
    NSDictionary *touchedLink = [self getLinkAtLocation:touchLocation];
    
    if (touchedLink){
        self.selectedRange = [[touchedLink objectForKey:@"range"] rangeValue];
    } else {
        [super touchesBegan:touches withEvent:event];
    }
    
    // 隐藏复制菜单项
    if ([[UIMenuController sharedMenuController] isMenuVisible]) {
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:NO];
    }
    
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    self.isTouchMoved = YES;
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    //如果拖动手指的话就不识别
    if (self.isTouchMoved) {
        self.selectedRange = NSMakeRange(0, 0);
        return;
    }
    
    CGPoint touchLocation = [[touches anyObject] locationInView:self];
    NSDictionary *touchedLink = [self getLinkAtLocation:touchLocation];
    
    if (touchedLink){
        NSRange range = [[touchedLink objectForKey:@"range"] rangeValue];
        NSString *touchedSubstring = [touchedLink objectForKey:@"link"];
        CDLinkType linkType = (CDLinkType)[[touchedLink objectForKey:@"linkType"] intValue];
        
        self.linkTapHandler(linkType, touchedSubstring, range);
    } else {
//        [super touchesBegan:touches withEvent:event];
    }
    self.selectedRange = NSMakeRange(0, 0);
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    self.selectedRange = NSMakeRange(0, 0);
}




#pragma mark - 长安弹出菜单 功能

- (BOOL)canBecomeFirstResponder
{
    return self.enableAlertMenus;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    BOOL canPerform = NO;
    if (action == @selector(deleteEvent:)) {
        canPerform = YES;
    } else if (action == @selector(replyEvent:)) {
        canPerform = YES;
    } else if (action == @selector(otherEvent:)) {
        canPerform = YES;
    } else if (action == @selector(copyEvent:)) {
        canPerform = YES;
    }
    
    return canPerform;
}

- (void)attachTapHandler
{
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    longGesture.minimumPressDuration = 0.6;
    [self addGestureRecognizer:longGesture];
}

//  处理手势相应事件
- (void)handleTap:(UILongPressGestureRecognizer *)longGesture
{
    if (longGesture.state == UIGestureRecognizerStateBegan) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [self becomeFirstResponder];
        EOADetailLog(@"长按复制");
        
        NSMutableArray *tempMenus = [[NSMutableArray alloc] init];
        // 默认弹出复制菜单
        if ([self.alertMenuDelegate respondsToSelector:@selector(alertMenuListOnLongPressLinkLabel:)]) {
            NSArray *menus = [self.alertMenuDelegate alertMenuListOnLongPressLinkLabel:self];
            if (menus.count > 0) {
                for (CDAlertMenuModel *menuDict in menus) {
                    UIMenuItem *item;
                    NSString *title = menuDict.menuName;
                    switch (menuDict.menuType) {
                        case CDLinkAlertMenuTypeCopy:
                            item = [[UIMenuItem alloc] initWithTitle:title action:@selector(copyEvent:)];
                            break;
                        case CDLinkAlertMenuTypeDelete:
                            item = [[UIMenuItem alloc] initWithTitle:title action:@selector(deleteEvent:)];
                            break;
                        case CDLinkAlertMenuTypeReply:
                            item = [[UIMenuItem alloc] initWithTitle:title action:@selector(replyEvent:)];
                            break;
                        case CDLinkAlertMenuTypeOther:
                            item = [[UIMenuItem alloc] initWithTitle:title action:@selector(otherEvent:)];
                            break;
                        default:
                            break;
                    }
                    [tempMenus addObject:item];
                }
            } else {
                UIMenuItem *item = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyEvent:)];
                [tempMenus addObject:item];
            }
            
        } else {
            UIMenuItem *item = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyEvent:)];
            [tempMenus addObject:item];
        }
        
        
        UIMenuController *menuController = [UIMenuController sharedMenuController];
        [menuController setMenuItems:[NSArray arrayWithArray:tempMenus]];
        [menuController setTargetRect:self.frame inView:self.superview];
        [menuController setMenuVisible:YES animated:YES];
        
        self.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        // 菜单即将显示 通知
        __weak __typeof(self)weakSelf = self;
        [[NSNotificationCenter defaultCenter] addObserver:weakSelf selector:@selector(menuControllerWillHideMenu:) name:UIMenuControllerWillHideMenuNotification object:nil];
    }
}

//  复制时执行的方法
- (void)copyEvent:(id)sender
{
    //  通用的粘贴板
    UIPasteboard *pBoard = [UIPasteboard generalPasteboard];
    
    //  有些时候只想取UILabel的text中的一部分
    if (objc_getAssociatedObject(self, @"expectedText")) {
        pBoard.string = objc_getAssociatedObject(self, @"expectedText");
    } else {
        
        //  因为有时候 label 中设置的是attributedText
        //  而 UIPasteboard 的string只能接受 NSString 类型
        //  所以要做相应的判断
        if (self.originalString.length > 0) {
            pBoard.string = self.originalString;
        } else if (self.text) {
            pBoard.string = self.text;
        } else {
            pBoard.string = self.attributedText.string;
        }
    }
    EOADetailLog(@"复制内容：%@",pBoard.string);
    if ([self.alertMenuDelegate respondsToSelector:@selector(linkLabel:didSelectedAlertMenuType:)]) {
        [self.alertMenuDelegate linkLabel:self didSelectedAlertMenuType:CDLinkAlertMenuTypeCopy];
    }
}

- (void)deleteEvent:(id)sender
{
    EOADetailLog(@"删除");
    if ([self.alertMenuDelegate respondsToSelector:@selector(linkLabel:didSelectedAlertMenuType:)]) {
        [self.alertMenuDelegate linkLabel:self didSelectedAlertMenuType:CDLinkAlertMenuTypeDelete];
    }
}

- (void)replyEvent:(id)sender
{
    EOADetailLog(@"回复");
    if ([self.alertMenuDelegate respondsToSelector:@selector(linkLabel:didSelectedAlertMenuType:)]) {
        [self.alertMenuDelegate linkLabel:self didSelectedAlertMenuType:CDLinkAlertMenuTypeReply];
    }
}

- (void)otherEvent:(id)sender
{
    EOADetailLog(@"其他");
    if ([self.alertMenuDelegate respondsToSelector:@selector(linkLabel:didSelectedAlertMenuType:)]) {
        [self.alertMenuDelegate linkLabel:self didSelectedAlertMenuType:CDLinkAlertMenuTypeOther];
    }
}

#pragma mark 是否开启长按弹出框
- (void)setEnableAlertMenus:(BOOL)enableAlertMenus
{
    _enableAlertMenus = enableAlertMenus;
    if (enableAlertMenus) {
        [self attachTapHandler];
    } else {
        NSArray *gestList = [self gestureRecognizers];
        for (UIGestureRecognizer *gest in gestList) {
            [self removeGestureRecognizer:gest];
        }
    }
}

#pragma mark 复制菜单消失事件
- (void)menuControllerWillHideMenu:(NSNotification *)notify
{
    EOADetailLog(@"菜单要隐藏啦");
    self.backgroundColor = [UIColor clearColor];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self resignFirstResponder];
}




@end

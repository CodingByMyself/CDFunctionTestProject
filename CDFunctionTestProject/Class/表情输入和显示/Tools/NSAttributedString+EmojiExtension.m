//
//  Created by DavidWang on 15/4/7.
//  Copyright (c) 2015年 nef. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSAttributedString+EmojiExtension.h"
#import "EmojiTextAttachment.h"

@implementation NSAttributedString (EmojiExtension)

- (NSString *)getPlainString {
    NSMutableString *plainString = [NSMutableString stringWithString:self.string];
    __block NSUInteger base = 0;
    
    [self enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, self.length)
                     options:0
                  usingBlock:^(id value, NSRange range, BOOL *stop) {
                      if (value && [value isKindOfClass:[EmojiTextAttachment class]]) {
                          [plainString replaceCharactersInRange:NSMakeRange(range.location + base, range.length)
                                                     withString:((EmojiTextAttachment *) value).emojiTag];
                          base += ((EmojiTextAttachment *) value).emojiTag.length - 1;
                      }
                  }];
    
    return plainString;
}

@end
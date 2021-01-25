//
//  NSString+Extend.h
//  HSNews
//
//  Created by iaknus on 15/3/1.
//  Copyright (c) 2015年 iaknus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extend)

- (NSString *)MD5EncodedString;

- (NSMutableAttributedString *)attributedStringWithLineSpacing:(CGFloat)lineSpacing;
- (NSMutableAttributedString *)attributedStringWithHeadIndent:(CGFloat)headIndent;

- (BOOL)isMobilePhoneNumber;

@end

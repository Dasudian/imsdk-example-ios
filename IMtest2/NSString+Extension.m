//
//  NSString+Extension.m
//  QQ聊天布局
//
//  Created by TianGe-ios on 14-8-20.
//  Copyright (c) 2014年 TianGe-ios. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "NSString+Extension.h"
#import <UIKit/UIKit.h>

@implementation NSString (Extension)

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

+(NSString *)ret16bitString{
  
  char data[16];
  
  for (int x=0;x<16;data[x++] = (char)('A' + (arc4random_uniform(26))));
  
  return [[NSString alloc] initWithBytes:data length:16 encoding:NSUTF8StringEncoding];
  
}


@end

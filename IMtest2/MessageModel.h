//
//  MessageModel.h
//  IMtest2
//
//  Created by mac on 15/12/25.
//  Copyright © 2015年 dasudian.com. All rights reserved.
//

#import <Foundation/Foundation.h>

//定义消息结构体
typedef enum {
  
  kMessageModelTypeOther,
  kMessageModelTypeMe
  
} MessageModelType;


@interface MessageModel : NSObject

// 文本消息
@property(nonatomic,copy)NSString *text;
// 时间
@property(nonatomic,copy)NSString *time;
// 消息类型
@property(nonatomic,assign) MessageModelType type;
// 是否显示时间
@property(nonatomic,assign) BOOL showTime;

// 提供一个字典转换model的方法
+ (id)messageModelWithDict:(NSDictionary *)dict;



@end

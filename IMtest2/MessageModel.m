//
//  MessageModel.m
//  IMtest2
//
//  Created by mac on 15/12/25.
//  Copyright © 2015年 dasudian.com. All rights reserved.
//

#import "MessageModel.h"


@implementation MessageModel

+ (id)messageModelWithDict:(NSDictionary *)dict{
  
  MessageModel *message = [[self alloc] init];
  message.text = dict[@"text"];
  message.time = dict[@"time"];
  message.type = [dict[@"type" ]intValue];
  
  
  return message;
}


@end

//
//  GroupManager.m
//  testforlib
//
//  Created by mac on 15/12/14.
//  Copyright © 2015年 dasudian.com. All rights reserved.
//

#import "GroupManager.h"

static GroupManager* _instance = nil;

@implementation GroupManager

+(instancetype) shareInstance{

  static dispatch_once_t onceToken ;
  dispatch_once(&onceToken, ^{
    _instance = [[super allocWithZone:NULL] init] ;
  }) ;
  
  return _instance;
  
  return nil;
}


//复写allocWithZone这个方法来申请内存
+(id) allocWithZone:(struct _NSZone *)zone
{
  return [GroupManager shareInstance] ;
  
}



@end

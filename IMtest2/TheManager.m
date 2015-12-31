//
//  TheManager.m
//  testforlib
//
//  Created by mac on 15/12/12.
//  Copyright © 2015年 dasudian.com. All rights reserved.
//

#import "TheManager.h"


static TheManager* _instance = nil;

@implementation TheManager


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
  return [TheManager shareInstance] ;
  
}



#pragma mark -- 收到回调的函数

//发送所有的异步消息的回调
- (void)didSendMessage:(NSInteger)reason data:(NSString *)data lenth:(NSInteger)len{
  
//  NSLog(@"回调返回的数据是:%@",data);
  
//  if(_sendmessage.count == 0){
//  
//    _sendmessage = [[NSMutableArray alloc]init];
//    
//  }
//  
//  [_sendmessage addObject:data];
//  
//  NSLog(@"数组中的个数为:%ld",_sendmessage.count);
  
   _i++;
  
  NSLog(@"发送异步成功的回调个数:%ld",_i);
  
  
}



- (void)didReciveMessage:(NSInteger)reason data:(NSString *)data lenth:(NSInteger)len{
  
  if(_signlmessagary==nil){
  
    _signlmessagary = [[NSMutableArray alloc]init];
    
    
  }
  if(data!=nil){
  NSDictionary *dic = [[DSDIMClient shareInstance]dictionaryWithJsonString:data];
  
  [_signlmessagary addObject:dic];
  
  NSLog(@"你收到了一条单播消息");
  
  NSLog(@"%ld",_signlmessagary.count);
  
//增加一个通知
  [[NSNotificationCenter defaultCenter] postNotificationName:@"sendsignlmessage" object:dic];
  }
  
}


- (void)didReciveGroupMessage:(NSInteger)reason data:(NSString *)data lenth:(NSInteger)len{
  if(_groupmessageary==nil){
  
    _groupmessageary = [[NSMutableArray alloc]init];
  }


  if(data!=nil){
  
  NSDictionary *dic = [[DSDIMClient shareInstance]dictionaryWithJsonString:data];
    
  [_groupmessageary addObject:dic];
    
  [[NSNotificationCenter defaultCenter]postNotificationName:@"sendgrooupmessage" object:dic];
  
    
    
  
  }
  
  
}


- (void)didreciveBroadMessage:(NSInteger)reason data:(NSString *)data lenth:(NSInteger)len{
  
  if(_boardmessageary.count == 0){
    
    _boardmessageary = [[NSMutableArray alloc]init];
  }
  NSLog(@"你收到了一条广播播消息");
  
  NSDictionary *dic = [[DSDIMClient shareInstance]dictionaryWithJsonString:data];
  
  if(dic!=nil){
  
  [_boardmessageary addObject:dic];
  
  
  NSLog(@"广播消息的数量是%ld个",_boardmessageary.count);
  
// 增加一个通知
  
    [[NSNotificationCenter defaultCenter]postNotificationName:@"sendboardmessage" object:dic];
  }
}



- (void)didKickOutGroup:(NSInteger)reason data:(NSString *)data lenth:(NSInteger)len{
  
  if(_kickoutary.count ==0){
   
    _kickoutary = [[NSMutableArray alloc]init];
  }
  
  
  NSLog(@"你被踢出了群组");
  
//  增加一个通知来告知被踢出了群组
//  [[NSNotificationCenter defaultCenter]postNotificationName:@"kickoutmessage" object:nil];
  
  
  
}



- (void)didDisConnect:(NSInteger)reason data:(NSString *)data lenth:(NSInteger)len{
  
  NSDictionary *dic= [[DSDIMClient shareInstance]dictionaryWithJsonString:data];
  
  [_disconnectary addObject:dic];

  
  NSLog(@"你与服务器断开连接");
  
  
}

//登录的回调
- (void)callbackConnect:(NSInteger)reason
                   data:(NSString *)data
                  lenth:(NSInteger)len{
// 增加一个通知，

  if(reason==5){
  
  [[NSNotificationCenter defaultCenter] postNotificationName:@"connectsuccess"object:data];
  
  }else{
  
    NSLog(@"连接错误，reason=%ld",reason);
    
  
  }
  
  
}



@end

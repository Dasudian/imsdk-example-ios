//
//  TheManager.h
//  testforlib
//
//  Created by mac on 15/12/12.
//  Copyright © 2015年 dasudian.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSDIMClient.h"
#import <UIKit/UIKit.h>

@interface TheManager : NSObject<DSDClintdelegate,UIAlertViewDelegate>
{

  NSInteger _i;
  
}

//单例方法用来获取当前的实例

+(instancetype) shareInstance;

//存放单播消息的数组
@property(nonatomic,retain)NSMutableArray *signlmessagary;


//存放组播消息的数组
@property(nonatomic,retain)NSMutableArray *groupmessageary;

//存放广播消息的数组
@property(nonatomic,retain)NSMutableArray *boardmessageary;


//被踢出群组的消息
@property(nonatomic,retain)NSMutableArray *kickoutary;


//断开连接的消息
@property(nonatomic,retain)NSMutableArray *disconnectary;


//存放所有发送异步消息的回调
@property(nonatomic,retain)NSMutableArray *sendmessage;





@end

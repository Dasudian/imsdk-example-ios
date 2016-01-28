//
//  GroupManager.h
//  testforlib
//
//  Created by mac on 15/12/14.
//  Copyright © 2015年 dasudian.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GroupManager : NSObject


//单例方法用来获取当前的实例
+(instancetype) shareInstance;


//创建一个数组来存放自己创建的数组
@property(nonatomic,retain)NSMutableArray *mycreatgroups;


//创建一个数组来存放自己加入的数组
@property(nonatomic,retain)NSMutableArray *myjiongroups;





@end

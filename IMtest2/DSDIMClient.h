//
//  DSDIMClient.h
//  testforlib
//
//  Created by mac on 15/12/9.
//  Copyright © 2015年 dasudian.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol DSDClintdelegate <NSObject>

/**
 *
 *  重新连接/连接成功的回调
 *  @param reason  连接成功，reason=5
 *  @param data    服务器返回的数据，成功返回为nil
 *  @param len      返回的data的数据长度
 */


@optional

- (void)dsdCallbackConnect:(NSInteger)reason data:(NSString *)data lenth:(NSInteger)len;



/**
 *  发送所有的异步消息的回调
 *
 *  @param reason 发送异步消息成功，reason=1；
 *  @param data   发送成功 返回data为messageid
 *  @param len    返回的data的数据长度。
 */
@optional
- (void)dsdCallbackSend:(NSInteger)reason data:(NSString *)data lenth:(NSInteger)len;







/**
 *  收到单播消息的回调
 *
 *  @param reason  收到单播消息成功，reason=2
 *  @param data    发送成功 返回data数据结构为：
 {
 "msg":"消息内容",
 "from":"发送消息者",
 "time":"发送消息的时间"
 }
 
 *  @param len     返回的data的数据长度
 */
@optional
- (void)dsdCallbackReceive:(NSInteger)reason data:(NSString *)data lenth:(NSInteger)len;






/**
 *   收到组播消息的回调
 *
 *  @param reason 收到组播消息成功，reason=3
 *  @param data   发送成功 返回data数据结构为：
 {
 "msg":"消息内容",
 "from":"发送消息者",
 "time":"发送消息的时间"
 "groupid":"组id"
 
 }
 *  @param len    返回的data的数据长度
 */
@optional
- (void)dsdCallbackReceiveGroup:(NSInteger)reason data:(NSString *)data lenth:(NSInteger)len;




/**
 *  收到广播消息的回调
 *
 *  @param reason 收到广播消息成功，reason=4
 *  @param data   发送成功 返回data数据结构为：
 {
 
 "msg":"消息内容",
 "from":"发送消息者",
 "time":"发送消息的时间"
 
 }
 *  @param len    返回的data的数据长度
 */
@optional
- (void)dsdCallbackReceiveBroad:(NSInteger)reason data:(NSString *)data lenth:(NSInteger)len;






/**
 *  踢出组的回调
 *
 *  @param reason  踢出成功，reason=6
 *  @param data    成功，data为nil
 *  @param len     返回的data的数据长度
 */
@optional
- (void)dsdCallbackKickOutGroup:(NSInteger)reason data:(NSString *)data lenth:(NSInteger)len;





/**
 *  与服务期断开连接
 *
 *  @param reason  成功 ，reason=7
 *  @param data    成功 ，data为nil
 *  @param len     返回的data的数据长度
 */
@optional

- (void)dsdCallbackDisConnect:(NSInteger)reason data:(NSString *)data lenth:(NSInteger)len;


/**
 *  账号在其他设备登录的回调
 *
 *  @param reason  成功 ，reason=8
 *  @param data    成功 ，data为nil
 *  @param len     返回的data的数据长度
 */

@optional
- (void)dsdCallbackLoginOnAnotherclient:(NSInteger)reason data:(NSString *)data lenth:(NSInteger)len;



@end




@interface DSDIMClient : NSObject

@property(assign,nonatomic)id<DSDClintdelegate>DSDdelegate;

//单例方法
+(instancetype) shareInstance;

/**
 *  初始化sdk,退出时需要调用dsdDisConnect()来销毁分配得内存.
 *
 *  @param ocversion sdk的版本号
 *  @param ocappid   注册的appid
 *  @param ocappkey  注册app获取的appkey
 *  @param ocuserid  userid
 *  @param ocuserinfo 用户需要的统计信息
 *  @param ocdevicetoken 设备的device token
 *  @param ocserveraddress  用户填写的服务器地址(如果写nil，默认为大数点公有云服务器地址);
 *  @return 成功返回当前的一个实例
 */
- (id)initWith:(NSString *)ocversion
         appID:(NSString *)ocappid
        appKey:(NSString *)ockey
        userId:(NSString *)ocuserid
      userinfo:(NSString *)ocuserinfo
   devicetoken:(NSString *)ocdevicetoken
 serverAddress:(NSString *)ocserveraddress;






/**
 *  同步发送单播消息.该方法会阻塞主线程.
 *
 *  @param formuserid   用户的id
 *  @param userlist     消息接收者列表
 *  @param number       消息接收者数量
 *  @param message      消息内容，必须是字符串
 *
 *  @return   成功返回0，失败返回-1
 */
- (NSInteger)dsdSyncSend:(NSString *)fromuserid
                userlist:(NSArray *)userlist
                  number:(NSInteger)number
                 message:(NSString *)message;






/**
 *  异步发送单播消息,该方法不会阻塞主线程.
 *
 *  @param formuserid 用户id
 *  @param userlist   消息接收者列表
 *  @param number     消息接收者数量
 *  @param message    消息内容，必须是json字符串
 *  @param messageid  消息序列号，用户指定得msgid,如果发送成功,该msgid会在回调方法里返回给用户(字符串类型，最好不要重复)
 */
- (void)dsdAsynSend:(NSString *)fromuserid
           userlist:(NSArray *)userlist
             number:(NSInteger )number
            message:(NSString *)message
          messageid:(NSString *)messageid;





/**
 *  同步发送组播消息,该方法会阻塞主线程.
 *
 *  @param formuserid  用户id
 *  @param groupid     group id
 *  @param message     消息内容，必须是json字符串类型
 *
 *  @return 成功返回0，失败返回-1。
 */

- (NSInteger )dsdSyncMulticast:(NSString *)fromuserid
                       groupid:(NSString *)groupid
                       message:(NSString *)message;



/**
 *  异步发送组播消息,该方法不会阻塞主线程.
 *
 *  @param formuserid 用户id
 *  @param groupid    groupid
 *  @param message    消息内容,必须是json字符串格式
 *  @param messageid  消息序列号，用户指定得msgid,如果发送成功,该msgid会在回调方法里返回给用户(字符串类型，最好不要重复)
 
 */

- (void)dsdAsynMulticast:(NSString *)fromuserid
                            groupid:(NSString *)groupid
                            message:(NSString *)message
                          messageid:(NSString *)messageid;







/**
 *  同步得发送广播消息,该方法会阻塞主线程.
 *
 *  @param formuserid  发送者id
 *  @param message     消息内容，必须是json字符串格式
 *
 *  @return  成功返回0，失败返回-1；
 */

- (NSInteger)dsdSyncBroadcast:(NSString *)fromuserid message:(NSString *)message;





/**
 *  异步发送广播消息,该方法不会阻塞主线程
 *
 *  @param formuserid  发送者id
 *  @param message     消息内容，必须是json字符串格式
 *  @param messageid   消息序列号，用户指定得msgid,如果发送成功,该msgid会在回调方法里返回给用户(字符串类型，最好不要重复)
 
 */

- (void)dsdAsynBroadcast:(NSString *)fromuserid
                            message:(NSString *)message
                          messageid:(NSString *)messageid;





/**
 *  创建组,该方法会阻塞主线程.
 *
 *  @param creatuserid  创建者的userid
 *  @param groupName    组名，字符串类型
 *
 *  @return   成功返回组id，失败返回nil。
 */

- (NSString *)dsdCreateGroup:(NSString *)creatuserid groupName:(NSString *)groupName;






/**
 *  加入组,该方法会阻塞主线程
 *
 *  @param joinuserid  加入者的userid
 *  @param groupid     加入组的组id，必须是字符串类型
 *
 *  @return 成功返回0，失败返回-1.
 */

- (NSInteger) dsdJoinGroup:(NSString *)joinuserid groupid:(NSString *)groupid;






/**
 *  离开组,该方法会阻塞主线程.
 *
 *  @param leaveuserid  离开者的userid
 *  @param groupid      组的id
 *
 *  @return 成功返回0，失败返回-1.
 */
- (NSInteger) dsdLeaveGroup:(NSString *)leaveuserid groupid:(NSString *)groupid;




/**
 *  将某人踢出组
 *
 *  @param creatuserid  组的创建者id
 *  @param groupid      组的id
 *  @param groupmember  被踢出的人的id
 *
 *  @return 成功返回0，失败返回-1.
 */
- (NSInteger)dsdKickOutGroup:(NSString *)creatuserid
                     groupid:(NSString *)groupid
                 groupmember:(NSString *)groupmember;





/**
 *  与初始化方法配合使用,该方法用于清除sdk分配得内存
 */
- (void)dsdDisConnect;




/**
 *  增加的一种数据转化方法，可以自己去解析回调方法中传回来的data值。
 *
 *  @param jsonString 传入的字符串
 *
 *  @return 返回解析后的字典
 */
- (NSDictionary *)dsdJsontoDict:(NSString *)jsonString;





@end

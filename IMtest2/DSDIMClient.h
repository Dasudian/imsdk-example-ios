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
 *  @param data    服务器返回的数据，成功返回为null
 *  @param len      返回的data的数据长度
 */


@optional

- (void)callbackConnect:(NSInteger)reason data:(NSString *)data lenth:(NSInteger)len;



/**
 *  发送所有的异步消息的回调
 *
 *  @param reason 发送异步消息成功，reason=1；
 *  @param data   发送成功 返回data为messageid。
 *  @param len    返回的data的数据长度。
 */
@optional
- (void)didSendMessage:(NSInteger)reason data:(NSString *)data lenth:(NSInteger)len;







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
- (void)didReciveMessage:(NSInteger)reason data:(NSString *)data lenth:(NSInteger)len;






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
- (void)didReciveGroupMessage:(NSInteger)reason data:(NSString *)data lenth:(NSInteger)len;




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
- (void)didreciveBroadMessage:(NSInteger)reason data:(NSString *)data lenth:(NSInteger)len;






/**
 *  踢出组的回调
 *
 *  @param reason  踢出成功，reason=6
 *  @param data    成功，data为null
 *  @param len     返回的data的数据长度
 */
@optional
- (void)didKickOutGroup:(NSInteger)reason data:(NSString *)data lenth:(NSInteger)len;





/**
 *  与服务期断开连接
 *
 *  @param reason  成功 ，reason=7
 *  @param data    成功 ，data为unll
 *  @param len     返回的data的数据长度
 */
@optional

- (void)didDisConnect:(NSInteger)reason data:(NSString *)data lenth:(NSInteger)len;



@end




@interface DSDIMClient : NSObject

@property(assign,nonatomic)id<DSDClintdelegate>DSDdelegate;

//单例方法
+(instancetype) shareInstance;

/**
 *  初始化sdk,退出时需要调用dsdDisConnect()来销毁分配得内存.
 *
 *  @param ocversion app的版本号
 *  @param ocappid   注册的appid
 *  @param ocspec    app在大数点上注册生成的appkey。
 *  @param ocuserid  userid
 *  @param ocuserinfo 用户需要的统计信息格式json字符串。
 *  @param ocdebicetoken 设备的device token
 *  @param ocserveraddress  用户填写的服务器地址(如果写nil，默认为大数点公有云服务器地址);
 *  @return 成功返回当前的一个实例
 */
- (id)initWith:(NSString *)ocversion
         appID:(NSString *)ocappid
       appSpec:(NSString *)ocspec
        userId:(NSString *)ocuserid
      userinfo:(NSString *)ocuserinfo
   devicetoken:(NSString *)ocdevicetoken
 serverAddress:(NSString *)ocserveraddress;






/**
 *  同步发送单播消息.该方法会阻塞到收到服务器得ack或者超时后返回.
 *
 *  @param formuserid   用户的id
 *  @param userlist     消息接受者列表
 *  @param number       消息接受者数量
 *  @param message      消息内容，必须是字符串
 *
 *  @return   成功返回0，失败返回-1
 */
- (NSInteger)dsdSyncsendmessage:(NSString *)formuserid
                       userlist:(NSArray *)userlist
                         number:(NSInteger)number
                        message:(NSString *)message;






/**
 *  异步发送单播消息,该函数不会阻塞调用者.
 *
 *  @param formuserid 用户id
 *  @param userlist   消息接受者列表
 *  @param number     消息接受者数量
 *  @param message    消息内容，必须是字符串
 *  @param messageid  消息序列号，用户指定得msgid,如果发送成功,该msgid会在回调方法里返回给用户(字符串类型，最好不要重复)
 */
- (void)dsdAsynsendmessage:(NSString *)formuserid
                  userlist:(NSArray *)userlist
                    number:(NSInteger )number
                   message:(NSString *)message
                 messageid:(NSString *)messageid;





/**
 *  同步发送组播消息,该方法会阻塞到收到服务器的ack或者超时后返回.
 *
 *  @param formuserid  用户id
 *  @param groupid     group id
 *  @param message     消息内容，必须是字符串类型
 *
 *  @return 成功返回0，失败返回-1。
 */

- (NSInteger )dsdSyncMulticastsendmessage:(NSString *)formuserid
                                  groupid:(NSString *)groupid
                                  message:(NSString *)message;



/**
 *  异步发送组播消息,该方法不会阻塞调用者.
 *
 *  @param formuserid 用户id
 *  @param groupid    groupid
 *  @param message    消息内容,必须是字符串格式
 *  @param messageid  消息序列号，用户指定得msgid,如果发送成功,该msgid会在回调方法里返回给用户(字符串类型，最好不要重复)
 
 */

- (void)dsdAsynMulticastsendmessage:(NSString *)formuserid
                            groupid:(NSString *)groupid
                            message:(NSString *)message
                          messageid:(NSString *)messageid;







/**
 *  同步得发送广播消息,该函数会阻塞到收到服务器得ack或者超时后返回.
 *
 *  @param formuserid  发送者id
 *  @param message     消息内容，必须是字符串格式
 *
 *  @return  成功返回0，失败返回-1；
 */

- (NSInteger)dsdSyncBroadcastsendmessage:(NSString *)formuserid message:(NSString *)message;





/**
 *  异步发送广播消息,该方法不会阻塞调用者
 *
 *  @param formuserid  发送者id
 *  @param message     消息内容，必须是字符串格式
 *  @param messageid   消息序列号，用户指定得msgid,如果发送成功,该msgid会在回调方法里返回给用户(字符串类型，最好不要重复)
 
 */

- (void)dsdAsynBroadcastsendmessage:(NSString *)formuserid
                            message:(NSString *)message
                          messageid:(NSString *)messageid;





/**
 *  创建组播组,该方法会阻塞调用者.
 *
 *  @param creatuserid  创建者的userid
 *  @param groupName    组名，字符串类型
 *
 *  @return   成功返回组名，失败返回null。
 */

- (NSString *)dsdCreatGroup:(NSString *)creatuserid groupName:(NSString *)groupName;






/**
 *  加入组播组,该方法会阻塞调用者
 *
 *  @param joinuserid  加入者的userid
 *  @param groupid     加入组的组名，必须是字符串类型
 *
 *  @return 成功返回0，失败返回-1.
 */

- (NSInteger) dsdJoinGroup:(NSString *)joinuserid groupid:(NSString *)groupid;






/**
 *  离开组播组,该函数会阻塞调用者.
 *
 *  @param leaveuserid  离开者的userid
 *  @param groupid      组的id
 *
 *  @return 成功返回0，失败返回-1.
 */
- (NSInteger) dsdLeaveGroup:(NSString *)leaveuserid groupid:(NSString *)groupid;








/**
 *  将某人踢出组播组
 *
 *  @param creatuserid  组播组拥有者
 *  @param groupid      组的groupid
 *  @param groupmember  被踢出的人的id
 *
 *  @return 成功返回0，失败返回-1.
 */
- (NSInteger)dsdKickOutGroup:(NSString *)creatuserid
                     groupid:(NSString *)groupid
                 groupmember:(NSString *)groupmember;





/**
 *  退出登录，退出后将收不到远程推送的消息。
 */
- (void)dsdDisConnect;




/**
 *  增加的一种数据转化方法，可以自己去解析回调函数中传回来的data值。
 *
 *  @param jsonString 传入的字符串
 *
 *  @return 返回解析后的字典
 */
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

















@end

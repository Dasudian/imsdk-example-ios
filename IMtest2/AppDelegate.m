//
//  AppDelegate.m
//  IMtest2
//
//  Created by mac on 15/12/25.
//  Copyright © 2015年 dasudian.com. All rights reserved.
//

#import "AppDelegate.h"
#import "DSDIMClient.h"
#import "TheManager.h"
#import "GroupManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
  TheManager *manager = [[TheManager alloc]init];
  
  [DSDIMClient shareInstance].DSDdelegate = [TheManager shareInstance];
  
  GroupManager *groupmanager = [[GroupManager alloc]init];
  
  
  //  推送的初始化的相关操作在此处进行,比如注册推送类型。
  
//  UIUserNotificationSettings *s = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
//
//  [[UIApplication sharedApplication] registerUserNotificationSettings:s];
//
//  [application registerForRemoteNotifications];
  
  
  
  if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
    UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
    [application registerUserNotificationSettings:settings];
  } else {
    UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge |
    UIRemoteNotificationTypeSound |
    UIRemoteNotificationTypeAlert;
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:notificationTypes];
  }
  
  return YES;
  
  
}





//控制屏幕旋转。

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
  if (self.allowRotation) {
    return UIInterfaceOrientationMaskAll;
  }
  return UIInterfaceOrientationMaskPortrait;
}




- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
  
  [application registerForRemoteNotifications];
}



- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{

  NSLog(@"推送过来的信息是:%@",userInfo);
  NSLog(@"收到推送消息:%@",[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]);
  

}







- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
  
  
  NSString *decToken = [NSString stringWithFormat:@"%@", deviceToken];
  
       //获取到之后要去掉尖括号和中间的空格
  
      NSMutableString *st = [NSMutableString stringWithString:decToken];
  
    [st deleteCharactersInRange:NSMakeRange(0, 1)];
  
    [st deleteCharactersInRange:NSMakeRange(st.length-1, 1)];
  
      NSString *string1 = [st stringByReplacingOccurrencesOfString:@" " withString:@""];
      //保存到本地
  
      NSLog(@"拼接后的token是：%@",string1);
  
       NSUserDefaults *u = [NSUserDefaults standardUserDefaults];
  
      [u setObject:string1 forKey:@"deviceToken"];
  
  
  
  
  
}


- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
  
  
  NSLog(@"错误是:%@",error);
  
}





@end

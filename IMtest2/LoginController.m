//
//  LoginController.m
//  IMtest2
//
//  Created by mac on 15/12/25.
//  Copyright © 2015年 dasudian.com. All rights reserved.
//

#import "LoginController.h"
#import "DSDIMClient.h"
#import "NSString+Extension.h"

@implementation LoginController

- (void)viewDidLoad{

  _usernametext.textColor = [UIColor blackColor];
  _usernametext.textAlignment = NSTextAlignmentCenter;
  _usernametext.font = [UIFont systemFontOfSize:14];
  _usernametext.placeholder = @"用户名";
  
  
  _passwordtext.textAlignment = NSTextAlignmentCenter;
  _passwordtext.textColor = [UIColor blackColor];
  _passwordtext.placeholder = @"密码";
  _passwordtext.secureTextEntry = YES;
  
  
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginto:) name:@"connectsuccess"object:nil];
  

  
}



- (IBAction)loginaction:(UIButton *)sender {
  
  NSString *userid = _usernametext.text;
  NSString *password = _passwordtext.text;
  NSString *version = @"1.0";
  NSString *appid = @"139_A_92QZPza2Rn37mfzrU0";
  NSString *appspec = @"de1d880437ccc17a";
  NSString *userinfo = nil;
  NSString *devicetoken = [[NSUserDefaults standardUserDefaults]objectForKey:@"deviceToken"];
  NSLog(@"发送给后台的token是:%@",devicetoken);
  
  

  DSDIMClient *dsdclient = [[DSDIMClient shareInstance] initWith:version
                                                          appID:appid
                                                        appSpec:appspec
                                                         userId:userid
                                                       userinfo:userinfo
                                                     devicetoken:devicetoken];
  
   if(dsdclient!=nil){
  
    NSLog(@"初始化成功");
  
  }else{
  
    UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"提示"
                                                       message:@"登录出错，请检查网络和用户名密码"
                                                      delegate:nil
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"确定", nil];
    [alertview show];
  
  }
  
  
  
  
  
  
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

  id theSegue = segue.destinationViewController;
  
  [theSegue setValue:_usernametext.text forKey:@"username"];

}

- (void)loginto:(NSNotification *)notification{
  
  
  
  dispatch_async(dispatch_get_main_queue(), ^{
    
    
    [self performSegueWithIdentifier:@"login" sender:self];
    
  });
  
  
}

- (void)dealloc{
  
 
  [[NSNotificationCenter defaultCenter]removeObserver:self];
  
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  [self.view endEditing:YES];
}


@end























//
//  KickOutController.m
//  IMtest2
//
//  Created by mac on 15/12/25.
//  Copyright © 2015年 dasudian.com. All rights reserved.
//

#import "KickOutController.h"
#import "DSDIMClient.h"

@implementation KickOutController




- (IBAction)kickoutaction:(UIButton *)sender {
  
 
  NSString *groupid = _groupid.text;
  
  NSString *groupmemberid = _memberid.text;
  

  
  NSInteger number = [[DSDIMClient shareInstance]dsdKickOutGroup:_loginerid
                                                         groupid:groupid
                                                    groupmember:groupmemberid];
  
  
  if(number==0){
    UIAlertView *alertview1 = [[UIAlertView alloc]initWithTitle:@"群系统消息"
                                                        message:@"你把他成功踢出群组"
                                                       delegate:nil
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定", nil];
    [alertview1 show];
  }else{
    UIAlertView *alertview2 = [[UIAlertView alloc]initWithTitle:@"群系统消息"
                                                        message:@"踢人失败"
                                                       delegate:nil
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定", nil];
    [alertview2 show];
  }
  
  
  
  
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  [self.view endEditing:YES];
}


@end













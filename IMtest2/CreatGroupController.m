//
//  CreatGroupController.m
//  IMtest2
//
//  Created by mac on 15/12/25.
//  Copyright © 2015年 dasudian.com. All rights reserved.
//

#import "CreatGroupController.h"
#import "GroupManager.h"
#import "DSDIMClient.h"

@implementation CreatGroupController



- (IBAction)crreataction:(UIButton *)sender{
//  拿到文本框信息
  NSString *groupname = _groupid.text;
  
  NSString *name = [[DSDIMClient shareInstance] dsdCreatGroup:_loginerid groupName:groupname];
  
  if(name == NULL){
    
    UIAlertView *creatfailure = [[UIAlertView alloc]initWithTitle:@"提示"
                                                          message:@"创建失败"
                                                         delegate:self
                                                cancelButtonTitle:@"取消"
                                                otherButtonTitles:@"确定", nil];
    
    [creatfailure show];
    
      }else{
   
        if([GroupManager shareInstance].mycreatgroups.count == 0){
        
          [GroupManager shareInstance].mycreatgroups = [[NSMutableArray alloc]init];
        
        }
        
        [[GroupManager shareInstance].mycreatgroups addObject:name];
        
        
        UIAlertView *creatsuccess = [[UIAlertView alloc]initWithTitle:@"提示"
                                                              message:@"创建成功"
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                                    otherButtonTitles:@"确定", nil];
        
        [creatsuccess show];
        
  }
  
  
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  [self.view endEditing:YES];
}



@end











































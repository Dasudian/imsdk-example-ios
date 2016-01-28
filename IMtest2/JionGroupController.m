//
//  JionGroupController.m
//  IMtest2
//
//  Created by mac on 15/12/25.
//  Copyright © 2015年 dasudian.com. All rights reserved.
//

#import "JionGroupController.h"
#import "DSDIMClient.h"
#import "GroupManager.h"

@implementation JionGroupController




- (IBAction)joinaction:(UIButton *)sender
{
  
  NSString *groupname = _groupidtext.text;
  
  NSInteger number = [[DSDIMClient shareInstance] dsdJoinGroup:_loginerid
                                                        groupid:groupname];
  if(number == 0){
    if([GroupManager shareInstance].myjiongroups.count ==0){
    
      [GroupManager shareInstance].myjiongroups = [[NSMutableArray alloc]init];
    }
    
    if(_groupidtext.text!=nil){
    
      [[GroupManager shareInstance].myjiongroups addObject:_groupidtext.text];
    
    }
    
    UIAlertView *creatsuccess = [[UIAlertView alloc]initWithTitle:@"提示"
                                                          message:@"加入成功"
                                                         delegate:self
                                                cancelButtonTitle:@"取消"
                                                otherButtonTitles:@"确定", nil];
    
    [creatsuccess show];

    
    
    
  }else{
  
    
    UIAlertView *creatfailure = [[UIAlertView alloc]initWithTitle:@"提示"
                                                          message:@"加入失败"
                                                         delegate:self
                                                cancelButtonTitle:@"取消"
                                                otherButtonTitles:@"确定", nil];
    
    [creatfailure show];

    
  
  }
  
  
  
  
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  [self.view endEditing:YES];
}


@end























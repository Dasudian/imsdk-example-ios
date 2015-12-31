//
//  GroupSettingController.m
//  IMtest2
//
//  Created by mac on 15/12/25.
//  Copyright © 2015年 dasudian.com. All rights reserved.
//

#import "GroupSettingController.h"
#import "GroupNavigationController.h"
#import "DSDIMClient.h"
#import "GroupManager.h"

@implementation GroupSettingController

- (void)viewDidLoad{
  
  GroupNavigationController *navcontroller = self.navigationController;
  
   _userid = navcontroller.username;
}


- (IBAction)creataction:(UIButton *)sender {
  
  [self performSegueWithIdentifier:@"creatgroup" sender:self];
  

}




- (IBAction)joinaction:(UIButton *)sender {
  
  [self performSegueWithIdentifier:@"joingroup" sender:self];
  

}




- (IBAction)leaveaction:(UIButton *)sender {
  
  
  [self performSegueWithIdentifier:@"leavegroup" sender:self];
  

}



- (IBAction)sendgroupacton:(UIButton *)sender {
  
  [self performSegueWithIdentifier:@"sendgroupmessage" sender:self];
  

}



- (IBAction)kickoutaction:(UIButton *)sender {
  
  [self performSegueWithIdentifier:@"kickoutgroup" sender:self];
  

}

- (IBAction)listaction:(UIButton *)sender {
  [self performSegueWithIdentifier:@"grouplist" sender:self];
  

}


- (IBAction)sendboardaction:(UIButton *)sender {
  
  [self performSegueWithIdentifier:@"sendboardmessage" sender:self];
  

}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

  id theSegue = segue.destinationViewController;

  [theSegue setValue:_userid forKey:@"loginerid"];
  
}



- (IBAction)quitacton:(UIButton *)sender {
  
  
  [[DSDIMClient shareInstance] dsdDisConnect];
  
  [GroupManager shareInstance].mycreatgroups = nil;
  
  [GroupManager shareInstance].myjiongroups = nil;
  
  [self dismissViewControllerAnimated:YES completion:nil];
  

}


- (IBAction)sendsignaction:(UIButton *)sender {
  [self performSegueWithIdentifier:@"sendsignmessage" sender:self];
  
  
  
}
































@end

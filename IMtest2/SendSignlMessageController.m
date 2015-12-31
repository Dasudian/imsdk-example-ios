//
//  SendSignlMessageController.m
//  IMtest2
//
//  Created by mac on 15/12/28.
//  Copyright © 2015年 dasudian.com. All rights reserved.
//

#import "SendSignlMessageController.h"

@implementation SendSignlMessageController


- (void)viewDidLoad{
  [super viewDidLoad];

  NSLog(@"传过来的id是:%@",_loginerid);

}


- (IBAction)signacton:(UIButton *)sender {
  
  if(_friendidtext.text!=nil){
  
 [self performSegueWithIdentifier:@"signmessage" sender:self];
    
  }
  
}




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
  
  id theSegue = segue.destinationViewController;
  
  [theSegue setValue:_friendidtext.text forKey:@"friendid"];
  
  [theSegue setValue:_loginerid forKey:@"loginerid"];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  [self.view endEditing:YES];
}




@end

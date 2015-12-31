//
//  ChatView.m
//  IMtest2
//
//  Created by mac on 15/12/25.
//  Copyright © 2015年 dasudian.com. All rights reserved.
//

#import "ChatView.h"

#define kToolBarH  44
#define kTextFieldH 30

@implementation ChatView

- (id)initWithFrame:(CGRect)frame{
  self = [super initWithFrame:frame];
  if(self){
//  创建子视图
    [self _addtableview];
    
    [self _addtoolBar];
    
  }
  
  return self;
}

//创建表格
- (void)_addtableview{
  
  _tableView = [[UITableView alloc]init];
  
  _tableView.frame = CGRectMake(0, 0,self.frame.size.width, self.frame.size.height-kToolBarH);
  
  _tableView.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1.0];
 
  _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  _tableView.allowsSelection = NO;
  
  [self addSubview:_tableView];
  
}

//创建工具栏
- (void)_addtoolBar{

  UIImageView *bgView = [[UIImageView alloc] init];
  bgView.frame = CGRectMake(0, self.frame.size.height - kToolBarH, self.frame.size.width, kToolBarH);
  bgView.image = [UIImage imageNamed:@"chat_bottom_bg"];
  bgView.userInteractionEnabled = YES;
  _toolBar = bgView;
  [self addSubview:bgView];
  
  UIButton *sendSoundBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  sendSoundBtn.frame = CGRectMake(0, 0, kToolBarH, kToolBarH);
  [sendSoundBtn setImage:[UIImage imageNamed:@"chat_bottom_voice_nor"] forState:UIControlStateNormal];
  [bgView addSubview:sendSoundBtn];
  
  UIButton *addMoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  addMoreBtn.frame = CGRectMake(self.frame.size.width - kToolBarH, 0, kToolBarH, kToolBarH);
  [addMoreBtn setImage:[UIImage imageNamed:@"chat_bottom_up_nor"] forState:UIControlStateNormal];
  [bgView addSubview:addMoreBtn];
  
  UIButton *expressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  expressBtn.frame = CGRectMake(self.frame.size.width - kToolBarH * 2, 0, kToolBarH, kToolBarH);
  [expressBtn setImage:[UIImage imageNamed:@"chat_bottom_smile_nor"] forState:UIControlStateNormal];
  [bgView addSubview:expressBtn];
  
  UITextField *textField = [[UITextField alloc] init];
  textField.returnKeyType = UIReturnKeySend;
  textField.enablesReturnKeyAutomatically = YES;
  textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 1)];
  textField.leftViewMode = UITextFieldViewModeAlways;
  textField.frame = CGRectMake(kToolBarH, (kToolBarH - kTextFieldH) * 0.5, self.frame.size.width - 3 * kToolBarH, kTextFieldH);
  textField.background = [UIImage imageNamed:@"chat_bottom_textfield"];
  _textField = textField;
  [bgView addSubview:textField];
  

}





@end

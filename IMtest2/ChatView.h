//
//  ChatView.h
//  IMtest2
//
//  Created by mac on 15/12/25.
//  Copyright © 2015年 dasudian.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatView : UIView

//聊天表
@property(nonatomic,strong)UITableView *tableView;

//工具栏
@property(nonatomic,strong)UIImageView *toolBar;

//文本框
@property(nonatomic,strong)UITextField *textField;



@end

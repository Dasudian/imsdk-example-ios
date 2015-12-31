//
//  SendBoardController.h
//  IMtest2
//
//  Created by mac on 15/12/25.
//  Copyright © 2015年 dasudian.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatView.h"

@interface SendBoardController : UIViewController

@property(nonatomic,copy)NSString *loginerid;

@property(nonatomic,strong)ChatView *chatview;

//定义一个可变数组
@property(nonatomic,strong)NSMutableArray *cellframdatas;


@end

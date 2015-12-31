//
//  SinlMessageController.h
//  IMtest2
//
//  Created by mac on 15/12/28.
//  Copyright © 2015年 dasudian.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatView.h"


@interface SinlMessageController : UIViewController

@property(nonatomic,copy)NSString *loginerid;

@property(nonatomic,copy)NSString *friendid;

@property(nonatomic,strong)ChatView *chatview;


@property(nonatomic,strong)NSMutableArray *cellframdatas;



@end

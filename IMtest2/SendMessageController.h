//
//  SendMessageController.h
//  IMtest2
//
//  Created by mac on 15/12/25.
//  Copyright © 2015年 dasudian.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendMessageController : UIViewController

{
  // 用来存放列表的头组
  NSArray *_sectionArray;
  
  // 用来存放自己创建的组
  NSMutableArray *_mycreatmodelary;
  
  // 用来存放自己加入的组
  NSMutableArray *_myjoinmodelary;
  
  
  NSMutableDictionary *_showDic;

}
//存放单击单元格名字的字符串。
@property(nonatomic,copy)NSString *cellnamestring;

//存放消息类型
@property(nonatomic,assign)NSInteger number;

//创建的表
@property(nonatomic,strong)UITableView *tableview;

//传过来的登录用户的id
@property(nonatomic,copy)NSString *loginerid;





@end

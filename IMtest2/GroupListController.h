//
//  GroupListController.h
//  IMtest2
//
//  Created by mac on 15/12/25.
//  Copyright © 2015年 dasudian.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupListController : UIViewController<UITableViewDataSource,UITableViewDelegate>

{
  
// 用来存放列表的头组
  NSArray *_sectionArray;

// 用来存放自己创建的组
  NSMutableArray *_mycreatmodelary;
  
// 用来存放自己加入的组
  NSMutableArray *_myjoinmodelary;
  
  
  NSMutableDictionary *_showDic;
  

  
}

@property(nonatomic,strong)UITableView *tableview;


@property(nonatomic,copy)NSString *loginerid;

@end

//
//  GroupListController.m
//  IMtest2
//
//  Created by mac on 15/12/25.
//  Copyright © 2015年 dasudian.com. All rights reserved.
//

#import "GroupListController.h"
#import "GroupModel.h"
#import "GroupCell.h"
#import "GroupManager.h"


@implementation GroupListController

- (void)viewDidLoad{

  self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];

//  设置代理
  self.tableview.delegate = self;
  self.tableview.dataSource = self;
  
// 加载数据
  [self loadData];
  
  [self.view addSubview:self.tableview];

}

#pragma mark -- 加载数据
- (void)loadData{

  _sectionArray = [NSArray arrayWithObjects:@"我创建的组群",@"我加入的群组", nil];

  _mycreatmodelary = [[NSMutableArray alloc]init];
  
  for(NSString *namestring in [GroupManager shareInstance].mycreatgroups){
  
    GroupModel *model = [[GroupModel alloc]init];
  
    model.groupname = namestring;
    
    [_mycreatmodelary addObject:model];
    
  }
  _myjoinmodelary  = [[NSMutableArray alloc]init];
  
  for(NSString *namestring in [GroupManager shareInstance].myjiongroups){
   
    GroupModel *model = [[GroupModel alloc]init];
    
    model.groupname  = namestring;
    
    [_myjoinmodelary addObject:model];
  
  }

}


#pragma mark ---tableview的代理方法


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

  return _sectionArray.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

  if(section == 0){
   
    return [GroupManager shareInstance].mycreatgroups.count;
  }else{
  
    return [GroupManager shareInstance].myjiongroups.count;
    
  }
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentifier = @"groupcell";
  
  GroupCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  
  if(cell == NULL){
  
    cell = [[GroupCell alloc]initWithStyle: UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
  
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.separatorInset = UIEdgeInsetsZero;
    
  }
  
  if(indexPath.section == 0){
    cell.groupmodel = _mycreatmodelary[indexPath.row];
  
  }else{
    cell.groupmodel = _myjoinmodelary[indexPath.row];
  
  }
  return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

  if([_showDic objectForKey:[NSString stringWithFormat:@"%ld",indexPath.section]]){
  
    return 44;
  
  }
 
  return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

  return 30;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

  UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,30)];
  
  header.backgroundColor = [UIColor greenColor];
  
  UILabel *mylabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 300, 30)];
  
  mylabel.text = _sectionArray[section];
  
  mylabel.textColor = [UIColor blackColor];
  
  [header addSubview:mylabel];
  
  header.tag = section;
  
  
  UITapGestureRecognizer *singleRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SingleTap:)];
  
  singleRecognizer.numberOfTapsRequired = 1;
  
  [singleRecognizer setNumberOfTouchesRequired:1];
  
  [header addGestureRecognizer:singleRecognizer];
  
  return header;


}

- (void)SingleTap:(UITapGestureRecognizer *)recognizer{
  
  
  NSInteger didSection = recognizer.view.tag;
  
  
  
  if(!_showDic){
    
    _showDic = [[NSMutableDictionary alloc]init];
    
  }
  NSString *key = [NSString stringWithFormat:@"%ld",didSection];
  
  if(![_showDic objectForKey:key]){
    
    [_showDic setObject:@"1" forKey:key];
    
  } else{
    
    [_showDic removeObjectForKey:key];
    
  }
  
  [self.tableview reloadSections:[NSIndexSet indexSetWithIndex:didSection] withRowAnimation:UITableViewRowAnimationFade];
  
  
}


@end




















































//
//  SendMessageController.m
//  IMtest2
//
//  Created by mac on 15/12/25.
//  Copyright © 2015年 dasudian.com. All rights reserved.
//

#import "SendMessageController.h"
#import "GroupManager.h"
#import "GroupCell.h"

@interface SendMessageController()<UITableViewDataSource,UITableViewDelegate>
{


}

@end

@implementation SendMessageController

- (void)viewDidLoad{
  
  self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width ,self.view.frame.size.height*0.6 ) style:UITableViewStylePlain];

  self.tableview.delegate = self;
  self.tableview.dataSource = self;
  
  [self loadData];
  
  [self.view addSubview:_tableview];
  
}

- (void)loadData{
  
  _sectionArray = [NSArray arrayWithObjects:@"我创建的组群",@"我加入的群组", nil];
  // 在此处设置model
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


#pragma mark---tableview的代理方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  
  return _sectionArray.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  if(section==0){
    return [GroupManager shareInstance].mycreatgroups.count;
  }else{
    
    return [GroupManager shareInstance].myjiongroups.count;
  }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  static NSString *cellIdentifier = @"groupcell";
  
  
  GroupCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  
  if(cell==NULL){
    
    cell = [[GroupCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.clipsToBounds = YES;
    cell.separatorInset = UIEdgeInsetsZero;
    
  }
  
  if(indexPath.section ==0){
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

#pragma mark--单击单元格的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
  if(self.cellnamestring ==nil){
    self.cellnamestring = [[NSString alloc]init];
  }
  
  if(indexPath.section ==0){
    //  我创建的组
    GroupCell *cell = [[GroupCell alloc]init];
    cell.groupmodel = _mycreatmodelary[indexPath.row];
    
    self.cellnamestring = cell.groupmodel.groupname;
    self.number = 0;
    
  }else{
    //  我加入的组
    GroupCell *cell = [[GroupCell alloc]init];
    cell.groupmodel = _myjoinmodelary[indexPath.row];
    
    self.cellnamestring = cell.groupmodel.groupname;
    self.number = 1;
  }
  
  //   实现跳转
  [self performSegueWithIdentifier:@"groupmessage" sender:self];
  
  
}


//实现跳转的时候传值
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
  
  id theSegue = segue.destinationViewController;
  
  [theSegue setValue:_cellnamestring forKey:@"groupid"];
  [theSegue setValue:_loginerid forKey:@"loginerid"];
  
}




@end

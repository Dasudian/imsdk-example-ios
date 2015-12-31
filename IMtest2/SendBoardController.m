//
//  SendBoardController.m
//  IMtest2
//
//  Created by mac on 15/12/25.
//  Copyright © 2015年 dasudian.com. All rights reserved.
//

#import "SendBoardController.h"
#import "MessageModel.h"
#import "CellFrameModel.h"
#import "DSDIMClient.h"
#import "TheManager.h"
#import "MessageCell.h"
#import "NSString+Extension.h"

@interface SendBoardController()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{

 NSMutableArray *dataArray;

}

@end

@implementation SendBoardController
- (void)viewDidLoad{
  [super viewDidLoad];
  
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
  
  
  [self _loadDada];
  
  _chatview = [[ChatView alloc]initWithFrame:self.view.frame];
  
  _chatview.tableView.delegate = self;
  _chatview.tableView.dataSource = self;
  _chatview.textField.delegate = self;
  
  [self.view addSubview:_chatview];
  
//  为导航栏增加一个返回按钮
  [self _addbackbutton];
  
  
//  增加一个
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadtheboarddata:)name:@"sendboardmessage"object:nil];
  


}

#pragma mark--加载数据
- (void)_loadDada{
  
  NSMutableArray *boardarry = [TheManager shareInstance].boardmessageary;

  NSURL *dataUrl = [[NSBundle mainBundle] URLForResource:@"messages.plist" withExtension:nil];
   dataArray = [NSMutableArray arrayWithContentsOfURL:dataUrl];
  
//  for(NSDictionary *diction in boardarry){
//    
//    //    {
//    //      "msg":"消息内容",
//    //      "from":"发送消息者",
//    //      "time":"发送消息的时间"
//    //    }
//    NSDictionary *msgdic = [diction objectForKey:@"msg"];
//    
//    NSString *text=[msgdic objectForKey:@"b"];
//    
//    NSString *timefrom= [diction objectForKey:@"time"];
//    int i =1;
//    NSNumber *type = [NSNumber numberWithInt:i];
//    
//    NSDictionary *dic = @{@"text":text,
//                          @"time":timefrom,
//                          @"type":type};
//    
//    
//    [dataArray addObject:dic];
//    
//    
//  }
//
  _cellframdatas = [[NSMutableArray alloc]init];
  
  for (NSDictionary *dic in dataArray) {
    
    MessageModel *message = [MessageModel messageModelWithDict:dic];
    CellFrameModel *lastFrame  = [_cellframdatas lastObject];
    CellFrameModel *cellFrame = [[CellFrameModel alloc]init];
    message.showTime = ![message.time isEqualToString:lastFrame.messagemodel.time];
    cellFrame.messagemodel = message;
    [_cellframdatas addObject:cellFrame];
    
  }

}
#pragma mark--文本框的代理方法
-(BOOL)textFieldShouldReturn:(UITextField *)textField{

  //1.获得时间
  NSDate *senddate=[NSDate date];
  NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
  [dateformatter setDateFormat:@"HH:mm"];
  NSString *locationString=[dateformatter stringFromDate:senddate];
  
  //2.创建一个MessageModel类
  MessageModel *message = [[MessageModel alloc] init];
  message.text = textField.text;
  message.time = locationString;
  message.type = 0;
  
  //3.创建一个CellFrameModel类
  CellFrameModel *cellFrame = [[CellFrameModel alloc] init];
  CellFrameModel *lastCellFrame = [_cellframdatas lastObject];
  message.showTime = ![lastCellFrame.messagemodel.time isEqualToString:message.time];
  cellFrame.messagemodel = message;
  
// 组装发送的消息
  NSString *messagetext = textField.text;
  
 NSDictionary *messagedic = @{@"t":@"0",@"b":messagetext};
  
NSData *jsonData = [NSJSONSerialization dataWithJSONObject:messagedic options:NSJSONWritingPrettyPrinted error:nil];
  NSMutableString *string = [[NSMutableString alloc]initWithData:jsonData encoding: NSUTF8StringEncoding];
  
//异步发送消息
  [[DSDIMClient shareInstance]dsdAsynBroadcastsendmessage:_loginerid
                                                  message:string
                                                messageid:[NSString ret16bitString]];
  NSLog(@"发送的广播消息是:%@",string);
  
  [_cellframdatas addObject:cellFrame];
  [_chatview.tableView reloadData];
  
  //5.自动滚到最后一行
  NSIndexPath *lastPath = [NSIndexPath indexPathForRow:_cellframdatas.count - 1 inSection:0];
  [_chatview.tableView scrollToRowAtIndexPath:lastPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
  
  textField.text = @"";

  
  return YES;
}


#pragma mark --增加返回按钮
- (void)_addbackbutton{
  // 创建一个按钮
  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  
  [button setTitle:@"back" forState: UIControlStateNormal];
  
  [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
  
  button.frame = CGRectMake(0, 0, 50, 35);
  
  UIBarButtonItem *leftbtnitem = [[UIBarButtonItem alloc]initWithCustomView:button];
  
  [button addTarget:self action:@selector(backon:) forControlEvents:UIControlEventTouchUpInside];
  
  [self.navigationItem setLeftBarButtonItem:leftbtnitem];
  

}

#pragma mark--tableview的代理实现方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
  
  return _cellframdatas.count;
}

- (MessageCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

  static NSString *cellIdentifier = @"cell";
  
  MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  
  if(cell==nil){
    cell = [[MessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
  }
  cell.cellframemodel = _cellframdatas[indexPath.row];
  
  return cell;
}

//代理方法，返回每一行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  CellFrameModel *cellFrame = _cellframdatas[indexPath.row];
  
  return cellFrame.cellHeight;
}

// 单击按钮的方法
- (void)backon:(UIButton *)button{
  
  [self.navigationController popToRootViewControllerAnimated:YES];
  

}


- (void)keyboardWillChange:(NSNotification *)note
{
 
  NSDictionary *userInfo = note.userInfo;
  CGFloat duration = [userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
  
  CGRect keyFrame = [userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
  CGFloat moveY = keyFrame.origin.y - self.view.frame.size.height;
  
  [UIView animateWithDuration:duration animations:^{
    self.view.transform = CGAffineTransformMakeTranslation(0, moveY);
  }];
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
  [self.view endEditing:YES];
}

- (BOOL)prefersStatusBarHidden
{
  return YES;
}

- (void)endEdit
{
  [self.view endEditing:YES];
}

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (void)loadtheboarddata:(NSNotification *)note{
  NSLog(@"通知传过来的信息是:%@",note);
 

  
  NSDictionary *dic = note.object;
  
  
  MessageModel *message = [[MessageModel alloc] init];
  NSDictionary *messagedic = [dic valueForKey:@"msg"];

  
  
  message.text = [messagedic objectForKey:@"b"];
  
  message.time = [dic valueForKey:@"time"];
  message.type = 1;
  
 
  CellFrameModel *cellFrame = [[CellFrameModel alloc] init];
  CellFrameModel *lastCellFrame = [_cellframdatas lastObject];
  message.showTime = ![lastCellFrame.messagemodel.time isEqualToString:message.time];
  cellFrame.messagemodel = message;
  
 
  
  [_cellframdatas addObject:cellFrame];
    
  
  
  
  //  回到主线程去刷新页面
  
  dispatch_async(dispatch_get_main_queue(), ^{
    
    
    [_chatview.tableView reloadData];
    //5.自动滚到最后一行
    NSIndexPath *lastPath = [NSIndexPath indexPathForRow:_cellframdatas.count - 1 inSection:0];
    [_chatview.tableView scrollToRowAtIndexPath:lastPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
  });
  
}


@end
















































//
//  GroupMessageController.m
//  IMtest2
//
//  Created by mac on 15/12/26.
//  Copyright © 2015年 dasudian.com. All rights reserved.
//

#import "GroupMessageController.h"
#import "MessageModel.h"
#import "CellFrameModel.h"
#import "DSDIMClient.h"
#import "TheManager.h"
#import "MessageCell.h"
#import "NSString+Extension.h"

@interface GroupMessageController()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{

  NSMutableArray *dataArray;

}

@end

@implementation GroupMessageController

- (void)viewDidLoad{
  
  [super viewDidLoad];
  NSLog(@"传过来的登录id是:%@",_loginerid);
  NSLog(@"传过来的组的id是:%@",_groupid);
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
  
  [self _loadDada];
  
  _chatview = [[ChatView alloc]initWithFrame:self.view.frame];
  
  _chatview.tableView.delegate = self;
  _chatview.tableView.dataSource = self;
  _chatview.textField.delegate = self;
  
  [self.view addSubview:_chatview];
  
  
//  增加一个观察者
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadthegroupdata:)name:@"sendgrooupmessage"object:nil];
  

  
  
}

#pragma mark--加载数据
- (void)_loadDada{
  
  NSMutableArray *grouparray = [TheManager shareInstance].groupmessageary;
  
  NSURL *dataUrl = [[NSBundle mainBundle] URLForResource:@"messages.plist" withExtension:nil];
  dataArray = [NSMutableArray arrayWithContentsOfURL:dataUrl];
  
  for(NSDictionary *diction in grouparray){
    
    //    {
    //      "msg":"消息内容",
    //      "from":"发送消息者",
    //      "time":"发送消息的时间"
    //    }
    
    NSDictionary *msgdic = [diction objectForKey:@"msg"];
    
    NSString *text=[msgdic objectForKey:@"b"];
    NSString *timefrom= [diction objectForKey:@"time"];
    int i =1;
    NSNumber *type = [NSNumber numberWithInt:i];
    
    NSDictionary *dic = @{@"text":text,
                          @"time":timefrom,
                          @"type":type};
    
    if([[diction objectForKey:@"groupid"]isEqualToString:_groupid]){
    
    [dataArray addObject:dic];
    
    }
  }
  
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
    [[DSDIMClient shareInstance] dsdAsynMulticast:_loginerid
                                                     groupid:_groupid
                                                     message:string
                                                   messageid:[NSString ret16bitString]];
  
    NSLog(@"发送的组播消息是:%@",string);
  
  
  [_cellframdatas addObject:cellFrame];
  [_chatview.tableView reloadData];
  
  //5.自动滚到最后一行
  NSIndexPath *lastPath = [NSIndexPath indexPathForRow:_cellframdatas.count - 1 inSection:0];
  [_chatview.tableView scrollToRowAtIndexPath:lastPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
  
  textField.text = @"";
  
  
  return YES;
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

//收到组播消息的回调
- (void)loadthegroupdata:(NSNotification *)note{

  NSDictionary *dic = note.object;
  
  NSLog(@"闯过来的字典是:%@",dic);
  
  
  NSDictionary *messagejsondic = [dic objectForKey:@"msg"];
  
  NSString *messagebody = [messagejsondic objectForKey:@"b"];
  
  
  NSLog(@"传过来的字符串是:%@",messagebody);
  
  NSString *messagetype = [messagejsondic objectForKey:@"t"];
  NSLog(@"传过来的消息体是:%@",messagebody);
  NSLog(@"传过来的消息类型是:%@",messagetype);
  
  MessageModel *message = [[MessageModel alloc] init];
  message.text = [messagejsondic objectForKey:@"b"];

  message.time = [dic valueForKey:@"time"];
  message.type = 1;


  //3.创建一个CellFrameModel类
  CellFrameModel *cellFrame = [[CellFrameModel alloc] init];
  CellFrameModel *lastCellFrame = [_cellframdatas lastObject];
  message.showTime = ![lastCellFrame.messagemodel.time isEqualToString:message.time];
  cellFrame.messagemodel = message;
  
  if([[dic objectForKey:@"groupid"]isEqualToString:_groupid]){
  
  [_cellframdatas addObject:cellFrame];
  
  }
  
  
    //  回到主线程去刷新页面
    
    dispatch_async(dispatch_get_main_queue(), ^{
      
      
      [_chatview.tableView reloadData];
      //5.自动滚到最后一行
      NSIndexPath *lastPath = [NSIndexPath indexPathForRow:_cellframdatas.count - 1 inSection:0];
      [_chatview.tableView scrollToRowAtIndexPath:lastPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
      
    });
  
  
}





@end

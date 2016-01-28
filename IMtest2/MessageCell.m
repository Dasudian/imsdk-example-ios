//
//  MessageCell.m
//  IMtest2
//
//  Created by mac on 15/12/25.
//  Copyright © 2015年 dasudian.com. All rights reserved.
//

#import "MessageCell.h"
#import "MessageModel.h"
#import "UIImage+ResizeImage.h"

@interface MessageCell()
{
  UILabel *_timeLabel;
  UIImageView *_iconView;
  UIButton *_textView;
}

@end

@implementation MessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if(self){
    self.backgroundView = nil;
    self.backgroundColor = [UIColor clearColor];
    //  创建子视图
    [self _creatviews];
  
 }

  return self;
}


#pragma mark--创建子视图
- (void)_creatviews{
  
  _timeLabel = [[UILabel alloc]init];
  
  _timeLabel.textAlignment = NSTextAlignmentCenter;
  
  _timeLabel.textColor = [UIColor grayColor];
  
  _timeLabel.font = [UIFont systemFontOfSize:14];
  [self.contentView addSubview:_timeLabel];
  
  
  _iconView = [[UIImageView alloc]init];
  [self.contentView addSubview:_iconView];
  
  
  _textView = [UIButton buttonWithType:UIButtonTypeCustom];
  _textView.titleLabel.numberOfLines = 0;
  _textView.titleLabel.font = [UIFont systemFontOfSize:13];
  _textView.contentEdgeInsets = UIEdgeInsetsMake(textPadding, textPadding, textPadding, textPadding);
  [self.contentView addSubview:_textView];
  
}


#pragma mark--复写set方法子视图展现数据
- (void)setCellframemodel:(CellFrameModel *)cellframemodel{
  _cellframemodel = cellframemodel;
  
  MessageModel *messagemodel = cellframemodel.messagemodel;
  
  _timeLabel.frame = cellframemodel.timeframe;
  _timeLabel.text = messagemodel.time;
  
  
  
  _iconView.frame = cellframemodel.iconframe;
 
  _iconView.layer.cornerRadius = _iconView.frame.size.height * 0.5;
  _iconView.layer.masksToBounds = YES;
  NSString *iconStr = messagemodel.type ?@"other":@"other";
  _iconView.image = [UIImage imageNamed:iconStr];
  
  _textView.frame = cellframemodel.textframe;
  NSString *textBG = messagemodel.type ?@"chat_recive_nor":@"chat_send_nor";
  UIColor *textColor = messagemodel.type ? [UIColor blackColor]:[UIColor whiteColor];
  [_textView setTitleColor:textColor forState:UIControlStateNormal];
  [_textView setBackgroundImage:[UIImage resizeImage:textBG] forState: UIControlStateNormal];
  
  [_textView setTitle:messagemodel.text forState:UIControlStateNormal];
  
}


@end



































































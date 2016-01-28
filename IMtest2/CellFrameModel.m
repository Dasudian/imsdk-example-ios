//
//  CellFrameModel.m
//  IMtest2
//
//  Created by mac on 15/12/25.
//  Copyright © 2015年 dasudian.com. All rights reserved.
//

#import "CellFrameModel.h"
#import "MessageModel.h"
#import "NSString+Extension.h"

#define timeH 40
#define padding 10
#define iconW 40
#define iconH 40
#define textW 200

@implementation CellFrameModel

- (void)setMessagemodel:(MessageModel *)messagemodel{
  
  _messagemodel = messagemodel;
  CGRect frame = [UIScreen mainScreen].bounds;
  
 
  if(messagemodel.showTime){
    CGFloat timeFrameX = 0;
    CGFloat timeFrameY = 0;
    CGFloat timeFrameW = frame.size.width;
    CGFloat timeFrameH = timeH;
    _timeframe = CGRectMake(timeFrameX, timeFrameY, timeFrameW, timeFrameH);
    
  }

  CGFloat iconFrameX = messagemodel.type ? padding:(frame.size.width-padding-iconW);
  CGFloat iconFrameY = CGRectGetMaxY(_timeframe);
  CGFloat iconFrameW = iconW;
  CGFloat iconFrameH = iconH;
  
  _iconframe = CGRectMake(iconFrameX, iconFrameY, iconFrameW, iconFrameH);
  

  CGSize textMaxSize = CGSizeMake(textW, MAXFLOAT);
  CGSize textSize = [messagemodel.text sizeWithFont:[UIFont systemFontOfSize:14.0] maxSize:textMaxSize];
  
  CGSize textRealSize = CGSizeMake(textSize.width+textPadding*2, textSize.height+textPadding*2);
  
  CGFloat textFrameY = iconFrameY;
  CGFloat textFrameX = messagemodel.type ? (2 * padding + iconFrameW):(frame.size.width-(padding *2 + iconFrameW + textRealSize.width));
  _textframe  = (CGRect){textFrameX,textFrameY,textRealSize};
  
  //  cell的高度
  
  _cellHeight = MAX(CGRectGetMaxY(_iconframe), CGRectGetMaxY(_textframe))+padding;
  
  
}



@end

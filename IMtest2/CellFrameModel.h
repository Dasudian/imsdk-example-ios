//
//  CellFrameModel.h
//  IMtest2
//
//  Created by mac on 15/12/25.
//  Copyright © 2015年 dasudian.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MessageModel;

#define textPadding 15

@interface CellFrameModel : NSObject

@property(nonatomic,strong)MessageModel *messagemodel;

//创建时间的frame
@property(nonatomic,assign) CGRect timeframe;
//创建文本的frame
@property(nonatomic,assign) CGRect textframe;
//创建用户头像图片的frame
@property(nonatomic,assign) CGRect iconframe;
//创建单元格的frame
@property(nonatomic,assign) CGFloat cellHeight;



@end

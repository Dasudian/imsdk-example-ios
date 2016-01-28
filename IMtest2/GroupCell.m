//
//  GroupCell.m
//  IMtest2
//
//  Created by mac on 15/12/25.
//  Copyright © 2015年 dasudian.com. All rights reserved.
//

#import "GroupCell.h"

@implementation GroupCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

  if(self){
  
    [self _creatlabel];
  
  }
  return self;

}

#pragma mark-- 创建子视图
- (void)_creatlabel{

  _namelabel = [[UILabel alloc]initWithFrame:self.contentView.frame];
  _namelabel.textAlignment = NSTextAlignmentCenter;
  _namelabel.textColor = [UIColor blackColor];
  [self.contentView addSubview:_namelabel];

}


- (void)setGroupmodel:(GroupModel *)groupmodel{

  _groupmodel = groupmodel;
  
  _namelabel.text = _groupmodel.groupname;

}

@end




















































//
//  GroupCell.h
//  IMtest2
//
//  Created by mac on 15/12/25.
//  Copyright © 2015年 dasudian.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupModel.h"

@interface GroupCell : UITableViewCell

@property(nonatomic,strong)UILabel *namelabel;

@property(nonatomic,strong)GroupModel *groupmodel;

@end

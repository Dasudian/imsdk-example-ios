//
//  CreatGroupController.h
//  IMtest2
//
//  Created by mac on 15/12/25.
//  Copyright © 2015年 dasudian.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface CreatGroupController : UIViewController


@property (weak, nonatomic) IBOutlet UITextField *groupid;

@property (weak, nonatomic) IBOutlet UITextField *groupsummary;

@property(nonatomic,copy)NSString *loginerid;


@end

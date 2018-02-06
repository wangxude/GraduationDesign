//
//  TLStudentTableViewCell.h
//  基于ios平台的图灵机器人
//
//  Created by 王旭 on 2018/1/9.
//  Copyright © 2018年 kys-5. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLStudentModel.h"

@interface TLStudentTableViewCell : UITableViewCell

@property (nonatomic,strong) TLStudentModel *model;

@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIImageView* sexImageView;
@property (nonatomic,strong) UILabel *timeLabel;

@end

//
//  TLHeaderView.h
//  StudentAttendProgram
//
//  Created by 王旭 on 2018/2/7.
//  Copyright © 2018年 王旭. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLFriendGroup;
@class TLHeaderView;

@protocol TLHeaderViewDelegate <NSObject>

- (void)clickHeadView:(TLHeaderView*)headView;

@end

@interface TLHeaderView : UITableViewHeaderFooterView

/**用户分组**/
@property (nonatomic,strong) TLFriendGroup *friendGroup;

/**
 按钮
 */
@property (nonatomic,weak) UIButton *contentButton;

/**
 标签
 */
@property (nonatomic,weak) UILabel *onlineLabel;

@property (nonatomic,weak)id <TLHeaderViewDelegate> delegate;

+ (instancetype)headViewWithTableView:(UITableView*)tableView;

@end

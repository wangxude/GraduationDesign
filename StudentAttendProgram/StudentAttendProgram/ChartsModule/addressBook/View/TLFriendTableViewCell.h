//
//  TLFriendTableViewCell.h
//  StudentAttendProgram
//
//  Created by 王旭 on 2018/2/7.
//  Copyright © 2018年 王旭. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLFriend;

@interface TLFriendTableViewCell : UITableViewCell

/**模型**/
@property (nonatomic,strong) TLFriend *friends;

+ (TLFriendTableViewCell*)cellWithTableView:(UITableView*)tableView;

@end

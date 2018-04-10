//
//  TLFriendTableViewCell.m
//  StudentAttendProgram
//
//  Created by 王旭 on 2018/2/7.
//  Copyright © 2018年 王旭. All rights reserved.
//

#import "TLFriendTableViewCell.h"
#import "TLFriend.h"
#import "TLFriendGroup.h"

@implementation TLFriendTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setFriends:(TLFriend *)friends {
    _friends = friends;
    //更新数据到控件
    self.textLabel.text = friends.name;
    self.detailTextLabel.text = friends.intro;
    UIImage *icon = [UIImage imageNamed:friends.icon];
    CGSize itemSize = CGSizeMake(40, 40);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO ,0.0);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    self.imageView.layer.cornerRadius = 20;
    self.imageView.layer.masksToBounds = YES;
    [icon drawInRect:imageRect];
    self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
   // self.imageView.image = [UIImage imageNamed:];
    self.textLabel.textColor = friends.vip ? [UIColor redColor] : [UIColor blackColor];
}

+ (TLFriendTableViewCell*)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"cell";
    TLFriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[TLFriendTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

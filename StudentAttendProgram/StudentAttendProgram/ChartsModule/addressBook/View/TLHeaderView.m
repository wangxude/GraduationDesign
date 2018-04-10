
//
//  TLHeaderView.m
//  StudentAttendProgram
//
//  Created by 王旭 on 2018/2/7.
//  Copyright © 2018年 王旭. All rights reserved.
//

#import "TLHeaderView.h"
#import "TLFriendGroup.h"

@implementation TLHeaderView


- (void)setFriendGroup:(TLFriendGroup *)friendGroup
{
    _friendGroup = friendGroup;
    // 加空格，让图片和文字产生一个间隔
    NSString *name = [NSString stringWithFormat:@" %@",friendGroup.name];
    [self.contentButton setTitle:name forState:UIControlStateNormal];
    [self.contentButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    self.onlineLabel.text = [NSString stringWithFormat:@"%zd/%zd",friendGroup.online,friendGroup.friends.count];
}

+ (instancetype)headViewWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"header";
    TLHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (headerView == nil) {
        headerView = [[TLHeaderView alloc]initWithReuseIdentifier:identifier];
    }
    return headerView;
}
/** 重写初始化方法, 给header加上图标、组名、在线人数等子控件 */
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        //self.contentView.frame =
        //1、添加按钮
        
        UIButton *contentButton = [[UIButton alloc]init];
        contentButton.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:contentButton];
        
        [contentButton setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
        [contentButton setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg"] forState:UIControlStateNormal];
        [contentButton setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg_highlighted"] forState:UIControlStateHighlighted];
        //设置对齐方式
        contentButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [contentButton addTarget:self action:@selector(contentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _contentButton = contentButton;
        
//        //设置最右边的标签
        UILabel *onlineLabel = [[UILabel alloc]init];
        [self.contentView addSubview:onlineLabel];
        [onlineLabel setTextAlignment:NSTextAlignmentRight];
        self.onlineLabel = onlineLabel;
    }
    return self;
}

- (void)contentButtonClick:(UIButton*)btn{
     // 隐藏\显示 好友
    NSLog(@"ffff");
    self.friendGroup.opened = !self.friendGroup.opened;
    //调用代理传递按钮的消息
    if ([self.delegate respondsToSelector:@selector(clickHeadView:)]) {
        [self.delegate clickHeadView:self];
    }
}

- (void)layoutSubviews {
    //布局添加子控件 (必须要添加的一句话)
    self.contentView.frame = self.bounds;
    
    NSLog(@"%@",NSStringFromCGRect(self.contentView.frame));
    self.contentButton.frame = self.bounds;
    self.contentButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    //标签 (在线人数)
    NSInteger countWidth = 60;
    NSInteger countHeight = self.bounds.size.height;
    NSInteger countX = self.bounds.size.width - 80;
    NSInteger countY = 0;
    self.onlineLabel.frame = CGRectMake(countX, countY, countWidth, countHeight);
    // 3、改变小箭头的方向
    // 由于tableView刷新数据后，所有header会被重新创建，所以要在这里对箭头朝向做出修改
    // 改变箭头朝向，顺时针旋转90度
    CGFloat rotation = self.friendGroup.opened? M_PI_2 : 0;
    self.contentButton.imageView.transform = CGAffineTransformMakeRotation(rotation);
}

// 允许多个手势并发
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    return YES;
//}

//- (BOOL)
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

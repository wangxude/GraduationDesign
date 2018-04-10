//
//  TLStudentTableViewCell.m
//  基于ios平台的图灵机器人
//
//  Created by 王旭 on 2018/1/9.
//  Copyright © 2018年 kys-5. All rights reserved.
//

#import "TLStudentTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface TLStudentTableViewCell()



@end

@implementation TLStudentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpSubView];
    }
    return self;
}

- (void)setUpSubView {
    self.iconImageView = [[UIImageView alloc]init];
    self.iconImageView.layer.cornerRadius = 30;
    self.iconImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.iconImageView];
    
    self.nameLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.nameLabel];
    
    self.timeLabel = [[UILabel alloc]init];
    self.timeLabel.textColor = [UIColor blackColor];
    self.timeLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.timeLabel];
    
   
}

- (void)layoutSubviews {
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(60);
        make.left.equalTo(self.contentView).offset(20);
        make.top.equalTo(self.contentView).offset(10);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
        make.left.equalTo(self.iconImageView.mas_right).offset(5);
        make.top.equalTo(self.contentView).offset(10);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(25);
        make.left.equalTo(self.iconImageView.mas_right).offset(5);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
    }];
    
}

- (void)setModel:(TLStudentModel *)model{
    
    _model = model;
    self.nameLabel.text = model.studentName;
    self.timeLabel.text = model.timeText;
    //[_sexImageView sd_setImageWithURL:model.imageUrl placeholderImage:nil];
//    [_iconImageView sd_setImageWithURL:model.imageUrl placeholderImage:nil];
    _iconImageView.image = [UIImage imageNamed:model.imageUrl];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end

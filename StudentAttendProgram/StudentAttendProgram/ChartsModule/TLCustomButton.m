//
//  TLCustomButton.m
//  StudentAttendProgram
//
//  Created by 王旭 on 2018/2/7.
//  Copyright © 2018年 王旭. All rights reserved.
//

#import "TLCustomButton.h"
#import "UIView+Extension.h"

@implementation TLCustomButton

- (instancetype)init {
    if (self = [super init]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}


//- (void)layoutSubviews {
//    [super layoutSubviews];
//
//    self.imageView.x = 0;
//    self.imageView.y = 0;
//    self.imageView.width = self.width;
//    self.imageView.height = self.imageView.width;
//
//    self.titleLabel.x = 0;
//    self.titleLabel.y = self.imageView.height + 10;
//    self.titleLabel.width = self.width;
//    self.titleLabel.height = self.height - self.imageView.height - 10;
//    self.titleLabel.textAlignment = NSTextAlignmentCenter;
//}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    CGFloat titleLabelWidth = CGRectGetWidth(contentRect);
    CGFloat titleLabelHeight = CGRectGetHeight(contentRect) * 0.2;
    CGFloat titleLabelY = CGRectGetHeight(contentRect) * 0.8;
    return CGRectMake(0,titleLabelY,titleLabelWidth,titleLabelHeight);
    
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageViewWidth = CGRectGetWidth(contentRect);
    CGFloat imageViewHeight = CGRectGetHeight(contentRect) * 0.8;
    return CGRectMake(0, 0, imageViewWidth, imageViewHeight);
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  TLFriend.m
//  StudentAttendProgram
//
//  Created by 王旭 on 2018/2/7.
//  Copyright © 2018年 王旭. All rights reserved.
//

#import "TLFriend.h"

@implementation TLFriend

- (instancetype)initFriendsWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        //kvc字典转模型
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)friendWithDict:(NSDictionary *)dict {
    return [[self alloc]initFriendsWithDict:dict];
}

@end

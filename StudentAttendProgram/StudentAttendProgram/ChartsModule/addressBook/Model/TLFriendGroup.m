//
//  TLFriendGroup.m
//  StudentAttendProgram
//
//  Created by 王旭 on 2018/2/7.
//  Copyright © 2018年 王旭. All rights reserved.
//

#import "TLFriendGroup.h"
#import "TLFriend.h"

@implementation TLFriendGroup

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        //1、kvc字典转模型
        [self setValuesForKeysWithDictionary:dict];
        // 2、然后再转换数组中信息
        NSMutableArray *groupFriends = [NSMutableArray array];
        for (NSDictionary *dictionary in self.friends) {
            TLFriend *friend = [TLFriend friendWithDict:dictionary];
            [groupFriends addObject:friend];
        }
        self.friends = groupFriends;
    }
    return self;
}

+ (instancetype)friendGroupWithDictionary:(NSDictionary *)dict {
    return [[self alloc]initWithDictionary:dict];
}

@end

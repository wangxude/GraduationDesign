//
//  TLFriendGroup.h
//  StudentAttendProgram
//
//  Created by 王旭 on 2018/2/7.
//  Copyright © 2018年 王旭. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TLFriend;

@interface TLFriendGroup : NSObject
/**分组名称**/
@property (nonatomic,copy) NSString *name;
/**在线人数**/
@property (nonatomic,assign) int online;
/**分组中用户数量**/
@property (nonatomic,copy) NSArray *friends;
/**分组是隐藏还是展开**/
@property (nonatomic,assign,getter=isOpen) BOOL opened;

- (instancetype)initWithDictionary:(NSDictionary*)dict;
+ (instancetype)friendGroupWithDictionary:(NSDictionary*)dict;
@end

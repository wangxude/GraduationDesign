//
//  TLFriend.h
//  StudentAttendProgram
//
//  Created by 王旭 on 2018/2/7.
//  Copyright © 2018年 王旭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLFriend : NSObject
/**头像**/
@property (nonatomic,copy) NSString *icon;
/**昵称**/
@property (nonatomic,copy) NSString *name;
/**好友签名**/
@property (nonatomic,copy) NSString *intro;
/**是否vip**/
@property (nonatomic,assign,getter=isVip) NSString *vip;
//联系方式
@property (nonatomic,copy) NSString *telephone;
//性别
@property (nonatomic,copy) NSString* sex;

- (instancetype)initFriendsWithDict:(NSDictionary*)dict;
+ (instancetype)friendWithDict:(NSDictionary*)dict;

@end

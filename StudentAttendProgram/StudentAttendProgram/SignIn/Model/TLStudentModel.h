//
//  TLStudentModel.h
//  基于ios平台的图灵机器人
//
//  Created by 王旭 on 2018/1/9.
//  Copyright © 2018年 kys-5. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLStudentModel : NSObject

@property (nonatomic,strong) NSString *imageUrl; //学生头像
@property (nonatomic,copy) NSString* studentName; //学生姓名
@property (nonatomic,copy) NSString* timeText; //签到时间
@property (nonatomic,assign) NSInteger sexIndex; //学生性别
@property (nonatomic,assign) int studentId; //学生id

- (instancetype)initWithStudentModel:(NSDictionary*)dic;

+ (instancetype)modelWithDictionary:(NSDictionary*)dic;


@end

//
//  TLStudentModel.m
//  基于ios平台的图灵机器人
//
//  Created by 王旭 on 2018/1/9.
//  Copyright © 2018年 kys-5. All rights reserved.
//

#import "TLStudentModel.h"

@implementation TLStudentModel

- (instancetype)initWithStudentModel:(NSDictionary *)dic {
    if (self = [super init]) {
        //self.imageUrl = dic[@"images"][@"medium"];
        self.imageUrl = dic[@"images"];
        self.studentName = dic[@"title"];
        self.sexIndex = 0;
        self.timeText = dic[@"year"];
        self.studentId = [dic[@"id"] intValue];
    }
    return self;
}

+ (instancetype)modelWithDictionary:(NSDictionary *)dic {
    TLStudentModel* model = [[TLStudentModel alloc]initWithStudentModel:dic];
    return model;
}

@end

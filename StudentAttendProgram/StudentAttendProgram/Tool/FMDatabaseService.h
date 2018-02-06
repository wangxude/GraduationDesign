//
//  FMDatabaseService.h
//  StudentAttendProgram
//
//  Created by 王旭 on 2018/2/2.
//  Copyright © 2018年 王旭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLStudentModel.h"

@interface FMDatabaseService : NSObject
//数据库对象
@property (nonatomic,strong) FMDatabaseQueue *queue;

+ (FMDatabaseService*)shareInstance;

- (instancetype)initWithDatabase;
- (void)insertDatabase:(TLStudentModel*)model;
- (void)deleteDatabase:(TLStudentModel*)model;
- (NSMutableArray*)queryDatabase;

@end

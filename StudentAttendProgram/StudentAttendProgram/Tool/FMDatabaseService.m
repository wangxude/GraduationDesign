//
//  FMDatabaseService.m
//  StudentAttendProgram
//
//  Created by 王旭 on 2018/2/2.
//  Copyright © 2018年 王旭. All rights reserved.
//

#import "FMDatabaseService.h"

#define databaseName @"t_student"

@interface FMDatabaseService ()

@property (nonatomic,strong) NSMutableArray *modelArray;

@end

@implementation FMDatabaseService

static FMDatabaseService * _instance = nil;

- (NSMutableArray*)modelArray {
    if (!_modelArray) {
        _modelArray = [[NSMutableArray alloc]init];
    }
    return _modelArray;
}

+ (FMDatabaseService*)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[FMDatabaseService alloc]initWithDatabase];
    });
    return _instance;
}
- (instancetype)initWithDatabase {
    if (self = [super init]) {
        // 0.拼接数据库存放的沙盒路径

        NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
        NSString *sqlFilePath = [path stringByAppendingPathComponent:@"student.sqlite"];
        //通过路径创建数据库
        self.queue = [FMDatabaseQueue databaseQueueWithPath:sqlFilePath];
        // 2.执行操作
        // 会通过block传递队列中创建好的数据库
        //id Integer PRIMARY KEY AUTOINCREMENT
        [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
            NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id Integer PRIMARY KEY AUTOINCREMENT,name Text,timeText Text,imageUrl Text,sexIndex Integer);",databaseName];
            BOOL success = [db executeUpdate:sql];
            if (success) {
                NSLog(@"创建表格成功");
            }
            else {
                NSLog(@"创建表格失败");
            }
        }];
    }
    return self;
}
- (void)insertDatabase:(TLStudentModel*)model {
    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {

        NSString *sql = @"INSERT INTO t_student (id,name,timeText,imageUrl,sexIndex) VALUES (?,?,?,?,?);";
        BOOL success = [db executeUpdate:sql withArgumentsInArray:[NSArray arrayWithObjects:[NSNumber numberWithInt:model.studentId],model.studentName,model.timeText,model.imageUrl,[NSNumber numberWithLong:model.sexIndex],nil]];
//        BOOL success = [db executeUpdate:@"INSERT INTO t_student (id,name,timeText,imageUrl,sexIndex) VALUES (?,?,?,?,?)",@(model.studentId),model.studentName,model.timeText,model.imageUrl,@((long)model.sexIndex)];
        
        if (success) {
            NSLog(@"插入成功");
        }
        else {
            NSLog(@"插入失败");
        }
    }];
}

- (void)deleteDatabase:(TLStudentModel*)model{
    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
//        NSString * string = [NSString stringWithFormat:@"ff"];
//        NSString *sql = [NSString stringWithFormat:@"DELETE FROM * t_student (name,text,age,timeText,timeText,);",];
        //NSString *sql = @"";
        BOOL success = [db executeUpdate:@"DELETE FROM * t_student name VALUES ?;",databaseName,model.studentName];
        if (success) {
            NSLog(@"删除成功");
        }
        else {
            NSLog(@"删除失败");
        }
    }];
}

- (NSMutableArray*)queryDatabase{
    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
        FMResultSet *result = [db executeQuery:@"SELECT * FROM t_student;"];
        //根据条件查询
        //        FMResultSet *resultSet = [self.db executeQuery:@“select * from t_student where id<?;”@(14)];
        [self.modelArray removeAllObjects];
        //遍历集合
        while ([result next]) {
            TLStudentModel * model = [[TLStudentModel alloc]init];
            model.studentId = [result intForColumn:@"id"];
            model.studentName = [result stringForColumn:@"name"];
            model.timeText = [result stringForColumn:@"timeText"];
            model.imageUrl = [result stringForColumn:@"imageUrl"];
            model.sexIndex = [result intForColumn:@"sexIndex"];
            [self.modelArray addObject:model];
        }
        
    }];
    return self.modelArray;
}

@end

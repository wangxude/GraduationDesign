//
//  TLStudentViewModel.m
//  基于ios平台的图灵机器人
//
//  Created by 王旭 on 2018/1/9.
//  Copyright © 2018年 kys-5. All rights reserved.
//

#import "TLStudentViewModel.h"
#import "TLNewWorkService.h"
#import "TLStudentModel.h"
#import "TLStudentViewModel.h"
#import "TLStudentInformationViewController.h"
#import "TLStudentSituationViewController.h"

@implementation TLStudentViewModel

- (void)getStudentData {
    
     NSMutableArray *modelArr = [[NSMutableArray alloc]initWithCapacity:10];
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2510412543.jpg",@"images",@"王旭",@"title",@"2018:01:31 20:00:00",@"year",nil];
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:@"点名",@"images",@"王旭",@"title",@"0",@"sexIndex",@"2018:01:31 20:00:00",@"year",@"144939392",@"id",nil];
    for (int i = 0; i < 10; i++) {
        TLStudentModel *model = [TLStudentModel modelWithDictionary:dic];
        [modelArr addObject:model];
    }
    __weak typeof(self) weakSelf = self;
     weakSelf.returnValueBlock(modelArr);
//    [TLNewWorkService POST:@"/v2/movie/coming_soon" parameters:nil success:^(id responseObject) {
//        NSLog(@"%@",responseObject);
//        NSArray *subjects = responseObject[@"subjects"];
//        NSMutableArray *modelArr = [[NSMutableArray alloc]initWithCapacity:subjects.count];
//        for (NSDictionary* subject in subjects) {
//            TLStudentModel *model = [TLStudentModel modelWithDictionary:subject];
//            [modelArr addObject:model];
//        }
//        self.returnValueBlock(modelArr);
//
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
//        self.errorCodeBlock(error);
//    }];
}

- (void)studentDetailWithPublicModel:(TLStudentModel *)model WithViewController:(UIViewController *)superController {
    TLStudentSituationViewController *studentSituationVC = [[TLStudentSituationViewController alloc]init];
//    studentInformationVC.detailUrl = model.imageUrl;
//    studentInformationVC.studentId = model.studentId;
    studentSituationVC.hidesBottomBarWhenPushed = YES;
    [superController.navigationController pushViewController:studentSituationVC animated:YES];
}

@end

//
//  TLSelectModuleViewController.m
//  StudentAttendProgram
//
//  Created by 王旭 on 2018/2/7.
//  Copyright © 2018年 王旭. All rights reserved.
//

#import "TLSelectModuleViewController.h"
#import "TLChartsViewController.h"
#import "TLAddressBookViewController.h"
#import "TLCustomButton.h"
//课程表
#import "TLCurriculumViewController.h"
//多选按钮
#import "TLMulchooseViewController.h"

@interface TLSelectModuleViewController ()

@end

@implementation TLSelectModuleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i <2; i++) {
        TLCustomButton *firstColumnButton = [[TLCustomButton alloc]init];;
//        firstColumnButton.frame = CGRectMake(30+(ScreenWidth-90)*i/2 + 30 *i,50,(ScreenWidth-90)/2, (ScreenWidth-90)*1.25/2);
        firstColumnButton.frame = CGRectMake(100,50+200*i,(ScreenWidth-90)/2, 150);
        if (i == 0) {
            [firstColumnButton setTitle:@"考勤分析" forState:UIControlStateNormal];
            [firstColumnButton setImage:[UIImage imageNamed:@"点名"] forState:UIControlStateNormal];
        }
        else {
            [firstColumnButton setTitle:@"通讯录" forState:UIControlStateNormal];
            [firstColumnButton setImage:[UIImage imageNamed:@"班级通知"] forState:UIControlStateNormal];
        }
        [firstColumnButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [firstColumnButton addTarget:self action:@selector(selectShowType:) forControlEvents:UIControlEventTouchUpInside];
        firstColumnButton.tag = 100 + i;
        [self.view addSubview:firstColumnButton];
    }
//    for (int i = 0; i < 2; i++) {
//        TLCustomButton *twoColumnButton = [[TLCustomButton alloc]init];
//        twoColumnButton.frame = CGRectMake(30+(ScreenWidth-90)*i/2 + 30 * i,200,(ScreenWidth-90)/2, 150);
//        [twoColumnButton setTitle:@"班级通知" forState:UIControlStateNormal];
//        [twoColumnButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//        [twoColumnButton setImage:[UIImage imageNamed:@"班级通知"] forState:UIControlStateNormal];
//        [twoColumnButton addTarget:self action:@selector(selectShowType:) forControlEvents:UIControlEventTouchUpInside];
//        twoColumnButton.tag = 102 + i;
//        [self.view addSubview:twoColumnButton];
//    }
    // Do any additional setup after loading the view.
}

- (void)selectShowType:(UIButton*)button {
    if (button.tag == 100) {
        TLChartsViewController *chartVC = [[TLChartsViewController alloc]init];
        chartVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:chartVC animated:YES];
    }
    else if (button.tag == 101){
        TLAddressBookViewController *addlistVC = [[TLAddressBookViewController alloc]init];
        addlistVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:addlistVC animated:YES];
    }
    else if (button.tag == 102){
//        TLCurriculumViewController *curriculumVC = [[TLCurriculumViewController alloc]init];
//        curriculumVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:curriculumVC animated:YES];
    }
    else {
//        TLMulchooseViewController *chooseVC = [[TLMulchooseViewController alloc]init];
//        chooseVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:chooseVC animated:YES];
        //测试东西
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

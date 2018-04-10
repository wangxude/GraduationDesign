//
//  SAPAttendListViewController.m
//  StudentAttendProgram
//
//  Created by 王旭 on 2018/1/22.
//  Copyright © 2018年 王旭. All rights reserved.
//

#import "SAPAttendListViewController.h"
#import "CalendarHomeViewController.h"
#import "Color.h"

@interface SAPAttendListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * myTableView;

@property (nonatomic,strong) UIView *headView;

@end

@implementation SAPAttendListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    
//    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0,0, ScreenWidth, 120)];
//    self.headView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:self.headView];
////    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.left.equalTo(self.view);
////        make.right.equalTo(self.view);
////        make.top.equalTo(self.view);
////        make.height.mas_equalTo(100);
////    }];
//    
//    //CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)
//    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,120, ScreenWidth, ScreenHeight-64) style:UITableViewStyleGrouped];
//    self.myTableView.delegate = self;
//    self.myTableView.dataSource = self;
//    [self.view addSubview:self.myTableView];
//    
////    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.left.equalTo(self.view);
////        make.right.equalTo(self.view);
////        make.top.equalTo(self.he);
////        make.height.mas_equalTo(ScreenHeight-64);
////    }];
    UIButton *but1 = [[UIButton alloc]initWithFrame:CGRectMake(10, 100, 300, 50)];
    but1.backgroundColor = COLOR_THEME;
    but1.tintColor = [UIColor whiteColor];
    but1.tag = 1;
    [but1 setTitle:@"签到时间" forState:UIControlStateNormal];
    [but1 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but1];
    // Do any additional setup after loading the view.
    
}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 2;
//}
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 2;
//}
//
//- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *identifier = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    if (!cell) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
//    }
//    else {
//        //删除cell中的子对象，防止覆盖的问题。
//        while ([cell.contentView.subviews lastObject]!=NULL) {
//            [(UIView*)[cell.contentView.subviews lastObject]removeFromSuperview];
//        }
//    }
//    for (UIView *subView in cell.contentView.subviews) {
//        [subView removeFromSuperview];
//    }
////    [self.myTableView setSeparatorInset:UIEdgeInsetsZero];
////    [self.myTableView setLayoutMargins:UIEdgeInsetsZero];
//    cell.imageView.image = [UIImage imageNamed:@"002"];
//    cell.textLabel.text = @"002";
//    return cell;
//}
//
////设置边线
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    [cell setSeparatorInset:UIEdgeInsetsZero];
//    [cell setLayoutMargins:UIEdgeInsetsZero];
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 60;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//
//}
//
////- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
////
////    if (section == 0) {
////        UIView *headView;
////        headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 150)];
////        headView.backgroundColor = [UIColor redColor];
////        return headView;
////    }
////    return nil;
////
////}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
////    if (section == 0) {
////        return 150;
////    }
//    return 5;
//}
-(void)click:(UIButton *)but
{
    CalendarHomeViewController *calendarVC = [[CalendarHomeViewController alloc]init];
    [calendarVC setAirPlaneToDay:365 ToDateforString:nil];//初始化方法
    calendarVC.calendarblock = ^(CalendarDayModel *model){

        NSLog(@"\n---------------------------");
        NSLog(@"1星期 %@",[model getWeek]);
        NSLog(@"2字符串 %@",[model toString]);
        NSLog(@"3节日  %@",model.holiday);

        if (model.holiday) {

            [but setTitle:[NSString stringWithFormat:@"%@ %@ %@",[model toString],[model getWeek],model.holiday] forState:UIControlStateNormal];

        }else{

            [but setTitle:[NSString stringWithFormat:@"%@ %@",[model toString],[model getWeek]] forState:UIControlStateNormal];

        }
    };
    calendarVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:calendarVC animated:YES];

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

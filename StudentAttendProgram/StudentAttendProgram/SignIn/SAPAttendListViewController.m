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

@interface SAPAttendListViewController ()

@end

@implementation SAPAttendListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *but1 = [[UIButton alloc]initWithFrame:CGRectMake(10, 100, 300, 50)];
    but1.backgroundColor = COLOR_THEME;
    but1.tintColor = [UIColor whiteColor];
    but1.tag = 1;
    [but1 setTitle:@"签到时间" forState:UIControlStateNormal];
    [but1 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but1];
    // Do any additional setup after loading the view.
}
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

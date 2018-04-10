//
//  TLCurriculumViewController.m
//  StudentAttendProgram
//
//  Created by 王旭 on 2018/2/12.
//  Copyright © 2018年 王旭. All rights reserved.
//

#import "TLCurriculumViewController.h"

#import "JHChartHeader.h"
//图标中用到
#define k_MainBoundsWidth [UIScreen mainScreen].bounds.size.width
#define k_MainBoundsHeight [UIScreen mainScreen].bounds.size.height

#define EachWidth (k_MainBoundsWidth-20)/4

@interface TLCurriculumViewController ()

@end

@implementation TLCurriculumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self showTableView];
    // Do any additional setup after loading the view.
}

/**
 *  创建表格视图
 */
- (void)showTableView{
    /*        创建对象         */
    JHTableChart *table = [[JHTableChart alloc] initWithFrame:CGRectMake(10, 10, k_MainBoundsWidth-20, k_MainBoundsHeight)];
    /*        表名称         */
    table.tableTitleString = @"电子信息工程课程表";
    /*        每一列的声明 其中第一个如果需要分别显示行和列的说明 可以用‘|’分割行和列         */
    table.colTitleArr = @[@"时间|星期",@"周一",@"周二",@"周三",@"周四",@"周五"];
    /*        列的宽度数组 从第一列开始
     */
    table.colWidthArr = @[@70.0,@70.0,@70,@70,@70,@70];
    /*        表格体的文字颜色         */
    table.bodyTextColor = [UIColor redColor];
    /*        最小的方格高度         */
    table.minHeightItems = 45;
    /*        表格的线条颜色         */
    table.lineColor = [UIColor orangeColor];
    /*        数据源数组 按照从上到下表示每行的数据 如果其中一行中某列存在多个单元格 可以再存入一个数组中表示         */
    table.dataArr = @[
                      @[@"上午",@[@"语文",@"",@"大学英语",@"大学英语"],@[@"高等数学",@"高等数学",@"",@""],@[@"大学英语",@"大学英语",@"语文",@"语文"],@[@"高等数学",@"英语",@"英语",@"自习"],@[@"高等数学",@"英语",@"英语",@"自习"]],
                      @[@"下午",@[@"高等数学",@"高等数学",@"自习"],@[@"语文",@"英语",@""],@[@"高等数学",@"语文",@"自习"],@[@"语文",@"英语",@""],@[@"高等数学",@"英语",@""]]
                      ];
    /*        显示 无动画效果         */
    [table showAnimation];
    [self.view addSubview:table];
    /*        设置表格的布局 其中 [table heightFromThisDataSource] 为自动按照当前数据源计算所需高度        */
    table.frame = CGRectMake(10, 10, k_MainBoundsWidth-20, [table heightFromThisDataSource]);
    
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

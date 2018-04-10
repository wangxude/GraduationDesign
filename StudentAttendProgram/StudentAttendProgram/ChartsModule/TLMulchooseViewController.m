//
//  TLMulchooseViewController.m
//  StudentAttendProgram
//
//  Created by 王旭 on 2018/3/1.
//  Copyright © 2018年 王旭. All rights reserved.
//

#import "TLMulchooseViewController.h"

#import "MulChooseCollectView.h"
#import "TLFriend.h"
#import "TLFriendGroup.h"

@interface TLMulchooseViewController (){
    MulChooseCollectView *MyCollectView;
    NSMutableArray *nameDataArr;
    NSMutableArray *iconDataArr;
}

@property (nonatomic,strong) NSArray * studentsDataSourceArray;

@end

@implementation TLMulchooseViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (NSArray*)studentsDataSourceArray {
    if (_studentsDataSourceArray == nil) {
        _studentsDataSourceArray = [NSArray array];
        
        NSString *path = [[NSBundle mainBundle]pathForResource:@"friends.plist" ofType:nil];
        NSArray *studentsArray = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *dataMutableArray = [[NSMutableArray alloc]initWithCapacity:10];
        for (NSDictionary *dic in studentsArray) {
            [dataMutableArray addObjectsFromArray:[dic objectForKey:@"friends"]];
        }
        _studentsDataSourceArray = [dataMutableArray copy];
    }
    return _studentsDataSourceArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"请假";
    
    self.view.backgroundColor = [UIColor whiteColor];
    nameDataArr = [[NSMutableArray alloc]initWithCapacity:0];
    iconDataArr = [[NSMutableArray alloc]initWithCapacity:0];
//    dataArr = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil];
    for (int i = 0; i < self.studentsDataSourceArray.count ; i++) {
        NSDictionary *dic = self.studentsDataSourceArray[i];
        [nameDataArr addObject:[dic objectForKey:@"name"]];
        [iconDataArr addObject:[dic objectForKey:@"icon"]];
    }
    MyCollectView = [MulChooseCollectView ShareCollectviewWithFrame:CGRectMake(0, 0, ScreenWidth, self.view.frame.size.height) HeaderTitle:@"全选"];
    MyCollectView.dataArr = nameDataArr;
    MyCollectView.iconDataArray = iconDataArr;
    NSArray * array = [[NSUserDefaults standardUserDefaults]objectForKey:@"leaveStudents"];
    MyCollectView.choosedArr = [[NSMutableArray alloc]initWithArray:array];
    MyCollectView.block = ^(NSString *chooseContent,NSMutableArray *chooseArr){
        NSLog(@"%@ %@",chooseContent,chooseArr);
        [[NSUserDefaults standardUserDefaults]setObject:chooseArr forKey:@"leaveStudents"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSInteger number = chooseArr.count;
        [[NSUserDefaults standardUserDefaults]setInteger:number forKey:@"goHomeNumber"];
    };
    [self.view addSubview:MyCollectView];
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

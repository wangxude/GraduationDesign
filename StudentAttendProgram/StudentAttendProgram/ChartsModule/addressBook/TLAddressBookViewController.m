//
//  TLAddressBookViewController.m
//  StudentAttendProgram
//
//  Created by 王旭 on 2018/2/7.
//  Copyright © 2018年 王旭. All rights reserved.
//

#import "TLAddressBookViewController.h"

#import "TLFriendGroup.h"
#import "TLFriend.h"

#import "TLHeaderView.h"
#import "TLFriendTableViewCell.h"
#import "TLStudentSituationViewController.h"

@interface TLAddressBookViewController ()<UITableViewDelegate,UITableViewDataSource,TLHeaderViewDelegate>

@property (nonatomic,copy) NSArray *friendList;

@property (nonatomic,strong) UITableView *friendListTableView;

@end

@implementation TLAddressBookViewController

- (NSArray*)friendList {
    if (!_friendList) {
        _friendList = [NSArray array];
        //从plist表格里面读取数据
        NSString *path = [[NSBundle mainBundle]pathForResource:@"friends.plist" ofType:nil];
        NSArray *friends = [NSArray arrayWithContentsOfFile:path];
        //字典转模型
        NSMutableArray *mutableArray = [[NSMutableArray alloc]init];
        for (NSDictionary *dic in friends) {
            TLFriendGroup *group = [TLFriendGroup friendGroupWithDictionary:dic];
            [mutableArray addObject:group];
        }
        _friendList = mutableArray;
    }
    return _friendList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.friendListTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, ScreenWidth, 500) style:UITableViewStylePlain];
    self.friendListTableView.delegate = self;
    self.friendListTableView.dataSource = self;
    [self.view addSubview:self.friendListTableView];
    self.friendListTableView.tableFooterView = [UIView new];
    
    if (@available(iOS 11.0,*)) {
        self.friendListTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.friendList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    TLFriendGroup *group = self.friendList[section];
    return group.opened ? group.friends.count : 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //1、生成cell
    TLFriendTableViewCell * cell = [TLFriendTableViewCell cellWithTableView:tableView];
    //2、传递模型
    TLFriendGroup * group = self.friendList[indexPath.section];
    cell.friends = group.friends[indexPath.row];
    return cell;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // 1、自定义header
    TLHeaderView *header = [TLHeaderView headViewWithTableView:tableView];
    // 2、传递模型
    TLFriendGroup *group = self.friendList[section];
    header.friendGroup = group;
    header.delegate = self;
    // 3、返回头部
    return header;
}


- (void)clickHeadView:(TLHeaderView *)headView {
    //刷新表格
    [self.friendListTableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TLStudentSituationViewController * studentVC = [[TLStudentSituationViewController alloc]init];
    TLFriendGroup * group = self.friendList[indexPath.section];
    studentVC.className = group.name;
    studentVC.modelFriendsDic = group.friends[indexPath.row];
    [self.navigationController pushViewController:studentVC animated:YES];
}

//设置边线
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    [cell setSeparatorInset:UIEdgeInsetsZero];
    [cell setLayoutMargins:UIEdgeInsetsZero];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 0.00000000000001;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

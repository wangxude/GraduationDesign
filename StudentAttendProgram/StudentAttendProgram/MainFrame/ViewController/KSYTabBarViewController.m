//
//  KSYTabBarViewController.m
//  KSYLiveUIDemo
//
//  Created by 王旭 on 2017/11/3.
//  Copyright © 2017年 王旭. All rights reserved.
//

#import "KSYTabBarViewController.h"

#import "UIImage+image.h"
#import "WXCustomTabBar.h"
#import "UIView+Extension.h"
#import "KSYNavigationViewController.h"

#import "TKHomeViewController.h"
#import "TLSelectModuleViewController.h"
#import "SAPAttendListViewController.h"
#import "TLStudentInformationViewController.h"
#import "TLCurriculumViewController.h"


@interface KSYTabBarViewController (){
       WXCustomTabBar* tabBar;
    
     BOOL __shouldAutorotate;
}
@property (nonatomic, strong) NSMutableArray *items;
@end

@implementation KSYTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置TabBar的属性
    [self setUpTabBarItemAttr];
    
    
    // Do any additional setup after loading the view.
    
    //self.view.backgroundColor=[UIColor redColor];
    
    
    [self setUpChildViewController];
    
    [self setUpTabBar];
    
    //注册旋转屏幕的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(autorotateInterface:) name:@"InterfaceOrientation" object:nil];
}
- (void)setUpTabBarItemAttr
{ //设置tabbar的颜色
    [[UITabBar appearance]setBackgroundColor:[UIColor whiteColor]];
    [UITabBar appearance].translucent = NO;
    
    UITabBarItem *item = [UITabBarItem appearance];
    
    // UIControlStateNormal状态下的属性
    NSMutableDictionary *normalAttr = [NSMutableDictionary dictionary];
    // 设置字体颜色
    normalAttr[NSForegroundColorAttributeName] = [UIColor grayColor];
    // 设置字体大小
    normalAttr[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    
    // UIControlStateSelected状态下的属性
    NSMutableDictionary *selectAttr = [NSMutableDictionary dictionary];
    selectAttr[NSForegroundColorAttributeName] = [UIColor colorWithRed:240/255.0 green:156/255.0 blue:30/255.0 alpha:1];
    
    [item setTitleTextAttributes:normalAttr forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectAttr forState:UIControlStateSelected];
}

//设置自控制器
-(void)setUpChildViewController{
    
    TKHomeViewController *demandVC = [[TKHomeViewController alloc]init];
    [self setUpOneChildViewController:demandVC image:[UIImage imageNamed:@"tabBar_icon_contrast_default"] selectedImage:[UIImage imageWithOriginalName:@"tabBar_icon_contrast"] title:@"签到"];
    
    TLSelectModuleViewController * listVC = [[TLSelectModuleViewController alloc]init];
    [self setUpOneChildViewController:listVC image:[UIImage imageNamed:@"tabBar_icon_schedule_default"] selectedImage:[UIImage imageWithOriginalName:@"tabBar_icon_schedule"] title:@"图表"];
    
    TLStudentInformationViewController *studentInformationVC = [[TLStudentInformationViewController alloc]init];
    [self setUpOneChildViewController:studentInformationVC image:[UIImage imageNamed:@"tabBar_icon_customer_default"] selectedImage:[UIImage imageWithOriginalName:@"tabBar_icon_customer"] title:@"学生信息"];
    
//    SAPAttendListViewController *attendListVC = [[SAPAttendListViewController alloc]init];
//    [self setUpOneChildViewController:attendListVC image:[UIImage imageNamed:@"tabBar_icon_contrast_default"] selectedImage:[UIImage imageWithOriginalName:@"tabBar_icon_contrast"] title:@"我的"];
     TLCurriculumViewController *attendListVC = [[ TLCurriculumViewController alloc]init];
    [self setUpOneChildViewController:attendListVC image:[UIImage imageNamed:@"tabBar_icon_contrast_default"] selectedImage:[UIImage imageWithOriginalName:@"tabBar_icon_contrast"] title:@"课程表"];

   
}
- (void)setUpTabBar
{
    [self setValue:[[WXCustomTabBar alloc] init] forKeyPath:@"tabBar"];
}


-(void)setUpOneChildViewController:(UIViewController *)VC image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title{
    
    VC.title = title;
    
    VC.tabBarItem.image = image;
    
    VC.tabBarItem.selectedImage = selectedImage;
    
    // 保存tabBarItem模型到数组
    [self.items addObject:VC.tabBarItem];
    KSYNavigationViewController  *nav = [[KSYNavigationViewController alloc] initWithRootViewController:VC];
    [self addChildViewController:nav];
    
    
}
#pragma mark - 当点击tabBar上的按钮调用

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tabBarDidClickPlusButton:(WXCustomTabBar *)tabBar{
    NSLog(@"点击");
    
}

-(void)autorotateInterface:(NSNotification *)notifition
{
    
    __shouldAutorotate = [notifition.object boolValue];
    NSLog(@"接收到的通知>> %d", __shouldAutorotate);
}

/**
 *
 *  @return 是否支持旋转
 */
-(BOOL)shouldAutorotate
{
    
    NSLog(@"======>> %d", __shouldAutorotate);
    return __shouldAutorotate;
}

/**
 *  适配旋转的类型
 *
 *  @return 类型
 */
-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    
    if (!__shouldAutorotate) {
        return UIInterfaceOrientationMaskPortrait;
    }
    return UIInterfaceOrientationMaskAllButUpsideDown;
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

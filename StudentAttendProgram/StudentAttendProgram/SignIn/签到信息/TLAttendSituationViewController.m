//
//  TLAttendSituationViewController.m
//  StudentAttendProgram
//
//  Created by 王旭 on 2018/2/12.
//  Copyright © 2018年 王旭. All rights reserved.
//

#import "TLAttendSituationViewController.h"

@interface TLAttendSituationViewController ()

//签到界面
@property (nonatomic,strong) UICollectionView * attendCollectionView;

@end

@implementation TLAttendSituationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    // Do any additional setup after loading the view.
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

//
//  TLStudentSituationViewController.m
//  StudentAttendProgram
//
//  Created by 王旭 on 2018/2/11.
//  Copyright © 2018年 王旭. All rights reserved.
//

#import "TLStudentSituationViewController.h"
#import "UIView+Extension.h"

@interface TLStudentSituationViewController ()

@end

@implementation TLStudentSituationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpSubView];
    // Do any additional setup after loading the view.
}

- (void)setUpSubView {
    UIView *topbackgroundView = [[UIView alloc]init];
    topbackgroundView.backgroundColor = [UIColor colorWithRed:121.0/255.0 green:218.0/255.0 blue:196.0/255.0 alpha:1];
    [self.view addSubview:topbackgroundView];
    
    [topbackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.top.equalTo(self.view);
        make.height.mas_equalTo(200);
    }];
    
    UIView *labelView = [[UIView alloc]init];
    labelView.backgroundColor = [UIColor colorWithRed:237/255.0 green:143/255.0 blue:121.0/255.0 alpha:1];;
    [self.view addSubview:labelView];
    [labelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(self.view).offset(40);
        make.bottom.equalTo(self.view).offset(-20);
    }];
    //头像
    UIImageView *iconImageView = [[UIImageView alloc]init];
    iconImageView.image = [UIImage imageNamed:@"image_8"];
    iconImageView.layer.cornerRadius = 50;
    iconImageView.layer.masksToBounds = YES;
    [labelView addSubview:iconImageView];
    
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(labelView);
        make.top.equalTo(labelView).offset(30);
        make.width.height.mas_equalTo(100);
    }];
    //姓名


//    (id Integer PRIMARY KEY AUTOINCREMENT,name Text,timeText Text,imageUrl Text,sexIndex Integer)
//    self.textLabel.text = friends.name;
//    self.detailTextLabel.text = friends.intro;
//    self.imageView.image = [UIImage imageNamed:friends.icon];
//    self.textLabel.textColor = friends.vip ? [UIColor redColor] : [UIColor blackColor];

    NSArray * titlerray = [NSArray arrayWithObjects:[NSString stringWithFormat:@"姓名:%@",self.modelFriendsDic.name],[NSString stringWithFormat:@"性别:%@",self.modelFriendsDic.sex],[NSString stringWithFormat:@"学号:%@",self.modelFriendsDic.intro],[NSString stringWithFormat:@"专业:%@",self.className],[NSString stringWithFormat:@"联系方式:%@",self.modelFriendsDic.telephone],nil];
    
    for (int i = 0; i < 5; i++) {
        UILabel * informationLabel = [[UILabel alloc]init];
        informationLabel.frame = CGRectMake((ScreenWidth-240)/2,140+40*i,200,30);
        informationLabel.textAlignment = NSTextAlignmentCenter;
        informationLabel.text = titlerray[i];
        [labelView addSubview:informationLabel];
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

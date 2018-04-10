//
//  TLStudentInformationViewController.m
//  基于ios平台的图灵机器人
//
//  Created by 王旭 on 2018/1/9.
//  Copyright © 2018年 kys-5. All rights reserved.
//

#import "TLStudentInformationViewController.h"

@interface TLStudentInformationViewController ()

@property (nonatomic,strong) NSArray * studentsDataSourceArray;

@property (nonatomic,strong) NSMutableArray * nameArray;

@property (nonatomic,strong) NSString* nameTitle;

@property (nonatomic,copy) NSString *telephone;

@end

@implementation TLStudentInformationViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(UpViewWith:) name:TLNameTitle object:nil];
    }
    return self;
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
    self.view.backgroundColor = [UIColor whiteColor];
    
   
     self.nameArray = [[NSMutableArray alloc]initWithCapacity:10];
    
    //    dataArr = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil];

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
        informationLabel.tag = 1000 + i;
        [labelView addSubview:informationLabel];
    }
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(30, 340, ScreenWidth-90,35)];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"联系Ta" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [labelView addSubview:button];
    
}

/**
 联系Ta
 */
- (void)click {
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt:%@",self.telephone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}

- (void)UpViewWith:(NSNotification*)notice{
    
     NSString *name = [notice object];
     self.nameTitle = name;
     NSDictionary *dic;
    
    for (int i = 0; i < self.studentsDataSourceArray.count ; i++) {
        dic = self.studentsDataSourceArray[i];
        if ([name isEqualToString:[dic objectForKey:@"name"]]) {
            NSArray * titlerray = [NSArray arrayWithObjects:[NSString stringWithFormat:@"姓名:%@",[dic objectForKey:@"name"]],[NSString stringWithFormat:@"性别:%@",[dic objectForKey:@"sex"]],[NSString stringWithFormat:@"学号:%@",[dic objectForKey:@"intro"]],[NSString stringWithFormat:@"专业:%@",@"电子信息工程1班"],[NSString stringWithFormat:@"联系方式:%@",[dic objectForKey:@"telephone"]],nil];
            self.telephone = [dic objectForKey:@"telephone"];
            for (int i = 1000; i<1005; i++) {
                UILabel *label =  [self.view viewWithTag:i];
                //        NSLog(@"%@",label);
                label.text = [NSString stringWithFormat:@"%@",titlerray[i-1000]];
            }
        }
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    NSNotification * notice = [NSNotification notificationWithName:TLNameTitle object:self.nameTitle];
    [self UpViewWith:notice];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


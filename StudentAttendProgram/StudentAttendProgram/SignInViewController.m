//
//  SignInViewController.m
//  AXHProject
//
//  Created by kys-5 on 16/9/4.
//  Copyright © 2016年 kys-5. All rights reserved.
//

#import "SignInViewController.h"
#import "LoginViewController.h"
#import "MBProgressHUD+MJ.h"
#import "KSYTabBarViewController.h"


@interface SignInViewController ()<UITextFieldDelegate>
{
    
    //登陆按钮
    UIButton* loginBtn;
    
    //注册按钮
    UIButton* registerBtn;
    //背景图片
    UIImageView* backGroundView;
    
    //授权登陆
    UIButton* qqButton;
    
    UIButton* sinaWeiBoButton;
    
    UIButton* weChatButton;
    
    //用户名密码输入框
    UITextField* userTextFiled,* passwordTextFiled;
    
    
}

@property(nonatomic,strong)FMDatabase* dateBase;

@property(nonatomic,strong)NSDictionary* WXYonghu;



@end

@implementation SignInViewController

-(void)viewWillAppear:(BOOL)animated{
    //隐藏导航栏
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    
    //往View上添加子控件
    [self addSubViewToView];
   
    
    // Do any additional setup after loading the view.
}
-(void)addSubViewToView{
    
    UIImage* image = [UIImage imageNamed:@"timg.jpg"];
    backGroundView = [[UIImageView alloc]initWithImage:image];
    //图片太小（图片有问题）
    backGroundView.frame = CGRectMake(0, 0, ScreenWidth+3, ScreenHeight+3);
    
    [self.view addSubview:backGroundView];
    
    //登陆按钮
    loginBtn= [[UIButton alloc]initWithFrame:CGRectMake(20, 305, ScreenWidth-40, 40)];
    //loginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //loginBtn.frame=CGRectMake(20, 355, ScreenWidth-40, 40);
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    //[loginBtn setBackgroundImage:[UIImage imageNamed:@"登录"] forState:UIControlStateNormal];
    loginBtn.layer.cornerRadius = 6.0;
    [loginBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    loginBtn.backgroundColor = [UIColor whiteColor];
    loginBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [loginBtn addTarget:self action:@selector(ChooseLoginBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    //注册按钮
    
    registerBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 353, ScreenWidth-40, 40)];
    //[registerBtn setBackgroundImage:[UIImage imageNamed:@"注册"] forState:UIControlStateNormal];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    registerBtn.layer.cornerRadius = 6.0;
    [registerBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(ChooseRegisterBtn) forControlEvents:UIControlEventTouchUpInside];
    registerBtn.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:registerBtn];
    
    NSArray* imageArr = @[[UIImage imageNamed:@"新浪"],[UIImage imageNamed:@"QQ"],[UIImage imageNamed:@"微信"]];
    for (int i = 0; i<3; i++) {
        UIButton* button = [[UIButton alloc]initWithFrame:CGRectMake((ScreenWidth - 180)*(i+1)/4 + 60*i, 480, 60, 60)];
        [button setBackgroundImage:imageArr[i] forState:UIControlStateNormal];
        //微信，qq，新浪
        button.tag = 500 + i;
//        [button addTarget:self action:@selector(theThreePartiesLogin:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
    //用户名密码输入框
    UIImageView* imageV = [[UIImageView alloc]initWithFrame:CGRectMake(20, 174, 20, 20)];
    imageV.image = [UIImage imageNamed:@"man_user_24px_11046_easyicon.net"];
    [self.view addSubview:imageV];
    
    UIImageView* imageVO = [[UIImageView alloc]initWithFrame:CGRectMake(20, 222, 20, 20)];
    imageVO.image = [UIImage imageNamed:@"lock_password_secure_24px_4831_easyicon.net"];
    [self.view addSubview:imageVO];
    
    userTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(45, 174, 335, 20)];
    [userTextFiled setBorderStyle:UITextBorderStyleNone];
    userTextFiled.placeholder = @"请输入用户名";
    userTextFiled.delegate = self;
    [self.view addSubview:userTextFiled];
    userTextFiled.text = @"zhangxuejiao";
    userTextFiled.textColor = [UIColor redColor];
    passwordTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(45, 222, 335, 20)];
    [passwordTextFiled setBorderStyle:UITextBorderStyleNone];
    passwordTextFiled.placeholder = @"请输入6到16位密码";
    passwordTextFiled.delegate = self;
    passwordTextFiled.secureTextEntry = YES; //每输入一个字符就变成点 用语密码输入
    //passwordTextFiled.borderStyle=UITextBorderStyleRoundedRect;
    passwordTextFiled.clearButtonMode=UITextFieldViewModeWhileEditing;//用户界面文本框编辑视图模式
    
    [self.view addSubview:passwordTextFiled];
    
    passwordTextFiled.text = @"123456";
    passwordTextFiled.textColor = [UIColor redColor];
    //用户名密码下划线
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(20, 250, ScreenWidth - 40, 2)];
    lineView1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:lineView1];
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(20, 197, ScreenWidth - 40, 2)];
    lineView2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:lineView2];
    
    UILabel *tishiyu = [[UILabel alloc]initWithFrame:CGRectMake(0, 437, ScreenWidth, 21)];
    tishiyu.text = @"------- 第三方合作账号 -------";
    tishiyu.textColor =[UIColor whiteColor];
    tishiyu.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:tishiyu];
    
//    //添加单选按钮
//    [self addRadioButton];
    //添加用户数据
    [self addUserData];
    
}

-(void)addUserData{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"123456",@"zhangxuejiao",nil];
    //存储数据
    [[NSUserDefaults standardUserDefaults]setObject:dic forKey:@"userData"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    _WXYonghu = [userDefaults objectForKey:@"userData"];
    NSLog(@"%@",_WXYonghu);
    //在存储数据的地方,别忘了这一句
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

/**
 *  点击登陆按钮响应事件
 */
-(void)ChooseLoginBtn{
    
    [MBProgressHUD showMessage:@"登录中" toView:self.view];
    
    
    if ([userTextFiled.text isEqualToString:@""]) {
        
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"请输入用户名"];
        
    }else if([passwordTextFiled.text isEqualToString:@""]){
        
       [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"请输入密码"];
        
        
    }else if ([[_WXYonghu valueForKey:userTextFiled.text]isEqualToString:passwordTextFiled.text]) {
        
       
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showSuccess:@"登录成功" toView:self.view];
        
          KSYTabBarViewController *tabVC = [[KSYTabBarViewController alloc]init];
            
            [UIApplication sharedApplication].keyWindow.rootViewController = tabVC;
            
            self.navigationController.navigationBarHidden = NO;
    }
    else{
       // [self.navigationController.view makeToast:@"密码错误！" duration:0.5 position:CSToastPositionCenter title:nil image:nil];
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"密码错误" toView:self.view];
        
    }

}



-(void)ChooseRegisterBtn{
    
    LoginViewController* login = [[LoginViewController alloc]init];
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:login animated:YES];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
    
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

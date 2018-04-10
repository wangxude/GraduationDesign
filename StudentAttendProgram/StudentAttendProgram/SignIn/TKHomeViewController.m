//
//  TKHomeViewController.m
//  基于ios平台的图灵机器人
//
//  Created by 王旭 on 2018/1/9.
//  Copyright © 2018年 kys-5. All rights reserved.
//

#import "TKHomeViewController.h"
#import "TLStudentViewModel.h"
#import "TLStudentTableViewCell.h"
#import "MBProgressHUD.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "FMDatabaseService.h"
#import "TLMulchooseViewController.h"

@interface TKHomeViewController ()<UITableViewDelegate,UITableViewDataSource,NSStreamDelegate>{
    NSInputStream *_inputStream; //对应输入流
    NSOutputStream *_outputStream; //对应输出流
}

@property (nonatomic,strong) NSMutableArray *studentDataArray;
@property (nonatomic,strong) NSArray *nameArray;

@property (nonatomic,strong) UITableView *studentTableView;

@property (nonatomic,strong) TLStudentViewModel *studentModel;

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) UIButton *leftButton;
@property (nonatomic,strong) UIButton *rightButton;

@property (nonatomic,strong) FMDatabaseService *service;

@property (nonatomic,assign) NSInteger numberOne;
@property (nonatomic,assign) NSInteger numberTwo;
@property (nonatomic,assign) NSInteger numberThree;

@end

@implementation TKHomeViewController

- (NSArray*)nameArray {
    if (!_nameArray) {
        _nameArray = @[@"BA21BAA4\r\n",@"CCB2305B\r\n",@"DAA3BAA4\r\n"];
    }
    return _nameArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.service = [[FMDatabaseService shareInstance]initWithDatabase];
 
    [self initWithTableView];
   // [self initWithData];
    self.studentDataArray = [[NSMutableArray alloc]init];
    
    self.dataArray  = [[NSMutableArray alloc]init];
    
    [self connectToHost];
    
    UIButton *leftButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    [leftButton setTitle:@"请假" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(qingjia) forControlEvents:UIControlEventTouchUpInside];
    self.leftButton = leftButton;
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem= leftItem;
    
    UIButton *rightButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    [rightButton setTitle:@"连接中" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(connectToHost) forControlEvents:UIControlEventTouchUpInside];
    self.rightButton = rightButton;
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem= rightItem;
    
    if (@available(iOS 11.0, *)) {
        self.studentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
   
    self.numberOne = 0;
    self.numberThree = 0;
    self.numberTwo = 0;
    // Do any additional setup after loading the view.
}

- (void)qingjia {
    TLMulchooseViewController *chooseVC = [[TLMulchooseViewController alloc]init];
    chooseVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chooseVC animated:YES];
}

#pragma mark - 连接服务器

-(void)connectToHost{
    //建立连接
    NSString* host = @"192.168.76.110";
    //端口号
    int port = 8086;
    
    // 建立连接
//    NSString* host = @"192.168.76.99";
//    //端口号
//    int port = 8086;
    
    //定义C语言输入输出流
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(NULL, (__bridge CFStringRef)host, port, &readStream, &writeStream);
    
    //把C语言的输入输出流转换成OC对象
    _inputStream = (__bridge NSInputStream*)(readStream);
    _outputStream = (__bridge NSOutputStream*)(writeStream);
    
    //设置代理
    _inputStream.delegate = self;
    _outputStream.delegate = self;
    
    // 把输入输入流添加到主运行循环
    // 不添加主运行循环 代理有可能不工作
    [_inputStream scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [_outputStream scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    //打开输入输出流
    [_inputStream open];
    [_outputStream open];

}

#pragma mark - 实现输入输出流的监听
-(void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode{

    NSLog(@"%@",[NSThread currentThread]);
    
    //        NSStreamEventOpenCompleted = 1UL << 0,//输入输出流打开完成
    //        NSStreamEventHasBytesAvailable = 1UL << 1,//有字节可读
    //        NSStreamEventHasSpaceAvailable = 1UL << 2,//可以发放字节
    //        NSStreamEventErrorOccurred = 1UL << 3,// 连接出现错误
    //        NSStreamEventEndEncountered = 1UL << 4// 连接结束
    
    switch (eventCode) {
        case NSStreamEventOpenCompleted:
            NSLog(@"输入输出流打开完成");
            [self.rightButton setTitle:@"连接中" forState:UIControlStateNormal];
            break;
        case NSStreamEventHasBytesAvailable:
            NSLog(@"有字节可读");
            [self readData];
            break;
        case NSStreamEventHasSpaceAvailable:
            NSLog(@"可以发送字节");
           // self.title = @"连接成功";
            [self.rightButton setTitle:@"连接成功" forState:UIControlStateNormal];
            break;
        case NSStreamEventErrorOccurred:
            NSLog(@"连接出现错误");
            [self.rightButton setTitle:@"连接失败" forState:UIControlStateNormal];
            break;
        case NSStreamEventEndEncountered:
            NSLog(@"连接结束");
            [self.rightButton setTitle:@"连接结束" forState:UIControlStateNormal];
            //关闭输入输出流
            [_inputStream close];
            [_outputStream close];
            
            //从主运行循环移除
            [_inputStream removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
            
            [_outputStream removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
            
            break;
            
        default:
            break;
    }
}

#pragma mark - 读取了服务器返回的数据
-(void)readData{
    
    //建立一个缓冲区,可以放1024个字节
    uint8_t buf[1024];
    
    //返回实际装的字节数
    NSInteger len = [_inputStream read:buf maxLength:sizeof(buf)];
    
    //把字节数组转换成字符串
    NSData* data = [NSData dataWithBytes:buf length:len];
    
    //从服务器中接收的数据
    NSString* readStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",readStr);
    
      NSString *nameStinrg ;
    
     [self.dataArray addObject:readStr];
       NSDictionary *dic;
        if ([readStr isEqualToString:self.nameArray[0]]) {
            dic = [NSDictionary dictionaryWithObjectsAndKeys:@"009.png",@"images",@"李赛",@"title",@"0",@"sexIndex",[self getNowTime],@"year",@"144939392",@"id",nil];
            nameStinrg = @"李赛";
            if (self.numberOne == 1) {
                
            }
            else {
                self.numberOne ++;
            }
        }
        else if ([readStr isEqual:self.nameArray[1]]){
            dic = [NSDictionary dictionaryWithObjectsAndKeys:@"006.png",@"images",@"张芳",@"title",@"0",@"sexIndex",[self getNowTime],@"year",@"144939393",@"id",nil];
            nameStinrg = @"张芳";
            if (self.numberTwo == 1) {
                
            }
            else {
                self.numberTwo ++;
            }
        }
        else {
            dic = [NSDictionary dictionaryWithObjectsAndKeys:@"004.png",@"images",@"王旭",@"title",@"0",@"sexIndex",[self getNowTime],@"year",@"144939394",@"id",nil];
            nameStinrg = @"王旭";
            if (self.numberThree == 1) {
                
            }
            else {
                self.numberThree ++;
            }
        }
       NSInteger number = self.numberThree + self.numberTwo + self.numberOne;
       [[NSUserDefaults standardUserDefaults]setInteger:number forKey:@"number"];
    
    
      [[NSNotificationCenter defaultCenter]postNotificationName:TLNameTitle object:nameStinrg];
    
        TLStudentModel *model = [[TLStudentModel alloc]initWithStudentModel:dic];
        [self.service insertDatabase:model];
        [self.studentDataArray addObject:model];
        [self.studentTableView reloadData];
}

- (void)writeData {
    //聊天信息
    NSString* msgStr = [NSString stringWithFormat:@"%@",@"222"];
    NSLog(@"%@",msgStr);
    //把str转换成NSData
    NSData* data = [msgStr dataUsingEncoding:NSUTF8StringEncoding];
    
    [_outputStream write:data.bytes maxLength:data.length];
}



- (void)initWithTableView {
    self.studentTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height-64) style:UITableViewStyleGrouped];
    self.studentTableView.delegate = self;
    self.studentTableView.dataSource = self;
    [self.view addSubview:self.studentTableView];
}

- (void)initWithData {
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
//
//    // Set the label text.
//    hud.label.text = NSLocalizedString(@"Loading...", @"HUD loading title");
    // You can also adjust other label properties if needed.
    // hud.label.font = [UIFont italicSystemFontOfSize:16.f];
    
//    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
//        //[self doSomeWork];
    self.studentModel = [[TLStudentViewModel alloc]init];

    __weak typeof(self) weakSelf = self;
    self.studentModel.returnValueBlock = ^(id returnValue) {
        weakSelf.studentDataArray = returnValue;
        [weakSelf.studentTableView reloadData];
        //[hud hideAnimated:YES];
    };
    self.studentModel.errorCodeBlock = ^(id errorCode) {
        NSLog(@"%@",errorCode);
    };
    [self.studentModel getStudentData];
    self.studentDataArray = [[NSMutableArray alloc]init];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.studentDataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    TLStudentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[TLStudentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSLog(@"%@",self.studentDataArray);
    cell.model = self.studentDataArray[indexPath.row];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //NSLog(@"%@",[self.service queryDatabase]);
   
//    [self.studentModel studentDetailWithPublicModel:self.studentDataArray[indexPath.row] WithViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//获取当前时间戳有两种方法(以秒为单位)
- (NSString*)getNowTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; //// ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone *zone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:zone];
    NSDate *dataNow = [NSDate date];
    NSString *timeString = [formatter stringFromDate:dataNow];
    return timeString;
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

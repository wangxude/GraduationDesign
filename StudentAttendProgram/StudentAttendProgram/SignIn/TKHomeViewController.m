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

@interface TKHomeViewController ()<UITableViewDelegate,UITableViewDataSource,NSStreamDelegate>{
    NSInputStream *_inputStream; //对应输入流
    NSOutputStream *_outputStream; //对应输出流
}

@property (nonatomic,strong) NSMutableArray* studentDataArray;

@property (nonatomic,strong) UITableView* studentTableView;

@property (nonatomic,strong) UIButton *rightButton;

@property (nonatomic,strong) FMDatabaseService *service;

@end

@implementation TKHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.service = [[FMDatabaseService shareInstance]initWithDatabase];
    [self initWithTableView];
    [self initWithData];
    [self connectToHost];
    
    UIButton *rightButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    [rightButton setTitle:@"连接中" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(connectToHost) forControlEvents:UIControlEventTouchUpInside];
    self.rightButton = rightButton;
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem= rightItem;
    // Do any additional setup after loading the view.
}

#pragma mark - 连接服务器

-(void)connectToHost{
    //建立连接
//    NSString* host = @"192.168.76.110";
//    //端口号
//    int port = 8086;
    
    // 建立连接
    NSString* host = @"192.168.76.158";
    //端口号
    int port = 8086;
    
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
    if (readStr != nil) {
        
        
        if ([readStr isEqual:@"a"]) {
           NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:@"点名",@"images",@"王旭",@"title",@"0",@"sexIndex",@"2018:01:31 20:00:00",@"year",@"144939392",@"id",nil];
            TLStudentModel * model = [[TLStudentModel alloc]initWithStudentModel:dic];
            
            [self.service insertDatabase:model];
            [self.studentDataArray addObject:model];
            [self.studentTableView reloadData];
        }
        else {
             NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:@"点名",@"images",@"王旭",@"title",@"0",@"sexIndex",@"2018:01:31 20:00:00",@"year",@"144939392",@"id",nil];
            TLStudentModel * model = [[TLStudentModel alloc]initWithStudentModel:dic];
            [self.studentDataArray addObject:model];
            [self.studentTableView reloadData];
        }
        
    }
  
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
    TLStudentViewModel *model = [[TLStudentViewModel alloc]init];

    model.returnValueBlock = ^(id returnValue) {
        self.studentDataArray = returnValue;
        [self.studentTableView reloadData];
        //[hud hideAnimated:YES];
    };
    model.errorCodeBlock = ^(id errorCode) {
        NSLog(@"%@",errorCode);
    };
    [model getStudentData];
    self.studentDataArray = [[NSMutableArray alloc]init];
    
//    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:@"images",@"点名",@"title",@"王旭",@"sexIndex",@"0",@"timeText",@"2018:01:31 20:00:00",@"id",@"144939392",nil];
//    TLStudentModel * model1 = [[TLStudentModel alloc]initWithStudentModel:dic];
//    [self.studentDataArray addObject:];
   // [self.studentTableView reloadData];
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
    NSLog(@"%@",[self.service queryDatabase]);
    [self writeData];
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

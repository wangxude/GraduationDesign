//
//  TLStudentInformationViewController.h
//  基于ios平台的图灵机器人
//
//  Created by 王旭 on 2018/1/9.
//  Copyright © 2018年 kys-5. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLFriend.h"


@interface TLStudentInformationViewController : UIViewController

//@property (nonatomic,copy) NSString* detailUrl;
//
//@property (nonatomic,assign) int studentId;
@property (nonatomic,strong) TLFriend *modelFriendsDic;

@property (nonatomic,copy) NSString *className;

@end

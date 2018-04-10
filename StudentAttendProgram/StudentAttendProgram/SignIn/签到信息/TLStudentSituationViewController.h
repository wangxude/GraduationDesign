//
//  TLStudentSituationViewController.h
//  StudentAttendProgram
//
//  Created by 王旭 on 2018/2/11.
//  Copyright © 2018年 王旭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLFriend.h"

@interface TLStudentSituationViewController : UIViewController

@property (nonatomic,strong) TLFriend *modelFriendsDic;

@property (nonatomic,copy) NSString *className;

@end

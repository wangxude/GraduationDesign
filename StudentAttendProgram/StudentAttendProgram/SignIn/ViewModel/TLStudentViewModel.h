//
//  TLStudentViewModel.h
//  基于ios平台的图灵机器人
//
//  Created by 王旭 on 2018/1/9.
//  Copyright © 2018年 kys-5. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLStudentModel.h"


typedef void(^ReturnValueBlock)(id returnValue);
typedef void(^ErrorCodeBlock)(id errorCode);

@interface TLStudentViewModel : NSObject

@property (nonatomic,copy) ReturnValueBlock returnValueBlock;
@property (nonatomic,copy) ErrorCodeBlock errorCodeBlock;

- (void)getStudentData;

- (void)studentDetailWithPublicModel:(TLStudentModel*)model WithViewController:(UIViewController*)controller;

@end

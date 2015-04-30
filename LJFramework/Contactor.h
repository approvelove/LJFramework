//
//  Contactor.h
//  AddressBook
//
//  Created by 李健 on 14-3-19.
//  Copyright (c) 2014年 李健. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contactor : NSObject<NSCopying,NSCoding>


@property(nonatomic, assign) int userID;  //该ID是服务器端的ID
@property(nonatomic, assign) int recordID; //联系人的唯一识别码（手机内的ID，系统分发）
@property(nonatomic, copy) NSString *fullName; //全名
@property(nonatomic, copy) NSString *firstName; //姓
@property(nonatomic, copy) NSString *lastName;  //名
@property(nonatomic, copy) NSString *homePhone;  //家庭电话
@property(nonatomic, copy) NSString *email;  //邮件
@property(nonatomic, copy) NSString *company;   //公司
@property(nonatomic, copy) NSString *nickName;   //昵称
@property(nonatomic, copy) NSString *department;  //部门
@property(nonatomic, copy) NSDate *birthday;  //生日
@property(nonatomic, copy) NSString *blogIndex;
@property(nonatomic, copy) NSData *imageData; //图像
@property(nonatomic, assign) NSInteger status;

- (void)archiveData;
+ (Contactor *)unArchiveData;
@end

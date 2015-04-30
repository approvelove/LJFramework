//
//  AddressBookHelper.h
//  AddressBookHelper
//
//  Created by 李健 on 14-3-19.
//  Copyright (c) 2014年 李健. All rights reserved.
//

//联系人操作使用手册
/*
 所有对联系人的操作都只有一个入口
 -(void)GetUserAddressBookWithOperation:(ADDRESSBOOKOPERATION)operation       parameter:(id)parameter
 但不同的操作，对应着不同的 ADDRESSBOOKOPERATION
 
 查找所有联系人时 parameter 该参数为nil
 当查询指定联系人时（按姓名查找） parameter 为联系人名 例如:@"张三"
 添加联系人时 paramater为联系人类 Contactor 的一个实例
 删除联系人时 paramater为联系人的ID 例如：[NSNumber numberWitnInt:3]
 */



#import <Foundation/Foundation.h>
#import "Contactor.h"

#define NOTIFICATION_ADDRESSBOOK_READALLCONTACTORS_OVER @"read all contactors over"
#define NOTIFICATION_ADDRESSBOOK_READONECONTACTOR_OVER @"read one contactor over"
#define NOTIFICATION_ADDRESSBOOK_ADDONEPERSON_OVER @"add one person to addresssbook"
#define NOTIFICATION_ADDRESSBOOK_DELETEPERSON_OVER @"delete person over"


typedef NS_ENUM(NSInteger, ADDRESSBOOKOPERATION){
    
    ADDRESSBOOKOPERATION_FINDPERSONONE,
    ADDRESSBOOKOPERATION_FINDPERSONALL,
    
//    ADDRESSBOOKOPERATION_FINDGROUPONE, //暂不开发
//    ADDRESSBOOKOPERATION_FINDGROUPALL, //暂不开发
    
    ADDRESSBOOKOPERATION_DELETEONE,
    
//    ADDRESSBOOKOPERATION_DELETEGROUPONE, //暂不开发
    
    ADDRESSBOOKOPERATION_ADDONE,
    
    
};


@interface AddressBookHelper : NSObject

/**
 *	@brief	读取通讯录所有内容
 *
 *	@param 	operation 	操作办法
 *	@param 	parameter 	需要传递的参数
 *
 *	@return	nil
 */
-(void)GetUserAddressBookWithOperation:(ADDRESSBOOKOPERATION)operation parameter:(id)parameter;
@end

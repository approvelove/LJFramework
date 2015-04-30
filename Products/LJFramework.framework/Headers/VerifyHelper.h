//
//  VerifyHelper.h
//  onestong
//
//  Created by 王亮 on 14-4-23.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+LJSeprator.h"

@interface VerifyHelper : NSObject
/**
 *	@brief	验证是否为空
 *
 *	@param 	field 	待验证字符串
 *
 *	@return	bool
 */
+(BOOL)isEmpty:(NSString *)field;

/**
 *	@brief	验证邮箱号
 *
 *	@param 	email 	输入的地址
 *
 *	@return	yes:是邮箱地址
 */
+ (BOOL)isValidateEmail:(NSString *)email;


/**
 *	@brief	判断是否手机号码
 *
 *	@param 	phoneStr 	输入字符串
 *
 *	@return	yes : 是
 */
+ (BOOL)isPhoneNumInputString:(NSString *)phoneStr;

+ (BOOL)checkHasNetWork;

/**
 *	@brief	判断一个对象是否为nil
 *
 *	@param 	obj 	传入的对象
 *
 *	@return	如果是nil返回yes,否则为No
 */
+ (BOOL)isNull:(id)obj;

@end

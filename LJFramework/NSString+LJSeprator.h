//
//  NSString+LJSeprator.h
//  FlowCircle
//
//  Created by lijian on 15/1/30.
//  Copyright (c) 2015年 lijian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (LjSeprator)

/**
 *	@brief	依据正则分割字符串
 *
 *	@param 	regex 	正则表达式
 *
 *	@return	分割好的数据
 */
- (NSArray *)componentsSeparatedByRegex:(NSString *)regex;

/**
 *	@brief	找出符合正则条件的字符串
 *
 *	@param 	regex 	正则表达式
 *
 *	@return	符合条件的字符串数组
 */
- (NSArray *)subStringComformToRegex:(NSString *)regex;

/**
 *	@brief	判断字符串是否匹配正则
 *
 *	@param 	regex 	正则
 *
 *	@return	bool值
 */
- (BOOL)isConfirmToRegex:(NSString *)regex;

@end

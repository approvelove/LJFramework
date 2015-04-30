//
//  NSDate+OST_DATE.h
//  onestong
//
//  Created by 李健 on 14-6-24.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (OST_DATE)

/**
 *	@brief	//返回day天后的日期(若day为负数,则为|day|天前的日期)
 *
 *	@param 	day 	天数
 *
 *	@return	day天后日期
 */
- (NSDate *)dateAfterDay:(int)day;


/**
 *	@brief	返回该月的第一天
 *
 *	@return	日期
 */
- (NSDate *)beginningOfMonth;



/**
 *	@brief	该月的最后一天
 *
 *	@return	日期
 */
- (NSDate *)endOfMonth;


/**
 *	@brief	返回周日的的开始时间
 *
 *	@return	日期
 */
- (NSDate *)beginningOfWeek;


/**
 *	@brief	返回当前周的周末
 *
 *	@return	日期
 */
- (NSDate *)endOfWeek;
@end

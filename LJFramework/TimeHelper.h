//
//  TimeHelper.h
//  Transaction
//
//  Created by 李健 on 13-12-25.
//  Copyright (c) 2013年 李健. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeHelper : NSObject

/**
 *	@brief	获取当前时间的日期详细
 *
 *	@return	返回当前日期的详细信息
 */
+ (NSDateComponents *)getDateComponents;


/*
      convert NSDate to NSDateComponents
*/
+ (NSDateComponents *)getDateComponentsWithDate:(NSDate *)date;

/*
      convert time in long long type to NSDateComponents
 */
+ (NSDateComponents *)convertTimeToDateComponents:(long long)time;


/*
      convert NSDate to long long type
*/
+ (long long)convertDateToSecondTime:(NSDate *)date;

/*
      convert long long to NSDate type
 */
+ (NSDate *)convertSecondsToDate:(long long)time;


/**
 *	@brief	自当前日期开始获取时间列表，1个页面对应10个日期
 *
 *	@param 	page  第xx页，从0开始
 *
 *	@return	返回一个日期的数组
 */
+ (NSMutableArray *)getNextPageDays:(int)page;


/**
 *	@brief	根据日期获取当日是星期几
 *
 *	@param 	date 	日期
 *
 *	@return	所在周的星期数
 */
+ (NSString *)getWeekDayInweekWithDate:(NSDate *)date;


/**
 *	@brief	获取当前日期所在周的周一
 *
 *	@param 	date 	要查询的日期
 *
 *	@return	该日期所在周的周一
 */
+ (NSDate *)getBeginDateInWeekWith:(NSDate *)date;

/**
 *	@brief	获取当前日期的前一天
 *
 *	@param 	date 	要查询的日期
 *
 *	@return	该日期的前一天
 */
+ (NSDate *)getYesterDay:(NSDate *)date;

/**
 *	@brief	获取当前日期所在周的周日
 *
 *	@param 	date 	要查询的日期
 *
 *	@return	该日期所在周的周日
 */
+ (NSDate *)getEndDateInWeekWithDate:(NSDate *)date;

/**
 *	@brief	获取当前日期所在周上周的周日
 *
 *	@param 	date 	要查询的日期
 *
 *	@return	该日期所在周上周的周日
 */
+ (NSDate *)getlastWeekDayDateWithDate:(NSDate *)date;

/**
 *	@brief	获取当前日期所在周上周的周一
 *
 *	@param 	date 	要查询的日期
 *
 *	@return	该日期所在周上周的周一
 */
+ (NSDate *)getlastFirstDayDateWithDate:(NSDate *)date;

/**
 *	@brief	返回当前日期所在月的第一天
 *
 *	@param 	date 	当前日期
 *
 *	@return	日期
 */
+ (NSDate *)getFirstDayDateInCurrentDateMonthWithDate:(NSDate *)date;

/**
 *	@brief	返回当前日期所在月的最后一天
 *
 *	@param 	date 	当前日期
 *
 *	@return	日期
 */
+ (NSDate *)getEndDayDateInCurrentDateMonthWithDate:(NSDate *)date;

/**
 *	@brief	返回当前日期所在月的上月的最后一天
 *
 *	@param 	date 	当前日期
 *
 *	@return	日期
 */
+ (NSDate *)getEndDayDateInLastMonthOfDateWithDate:(NSDate *)date;

/**
 *	@brief	返回当前日期所在月的上月的第一天
 *
 *	@param 	date 	当前日期
 *
 *	@return	日期
 */
+ (NSDate *)getFirstDayDateInLastMonthOfDateWithDate:(NSDate *)date;

/**
 *	@brief	返回当前日期的年-月-日
 *
 *	@param 	date 	当前日期
 *
 *	@return	@"年-月-日"
 */
+ (NSString *)getYearMonthDayWithDate:(NSDate *)date;

/**
 *	@brief	返回当前日期的XXXX年XX月XX日
 *
 *	@param 	date 	当前日期
 *
 *	@return	XXXX年XX月XX日
 */
+ (NSString *)getYearMonthDayWithDateInChinese:(NSDate *)date;

/**
 *	@brief	字符串转换成日期 目前只支持xxxx-xx-xx格式
 *
 *	@param 	str 	日期字符串
 *
 *	@return	date
 */
+ (NSDate *)dateFromString:(NSString *)str;

/**
 *	@brief	将字符串转换成nsdate
 *
 *	@param 	str 	待转换的字符串
 *	@param 	format 	转换格式
 *
 *	@return	nsdate
 */
+ (NSDate *)timeFromString:(NSString *)str andFormat:(NSString *)format;

/**
 *	@brief	将日期按照指定的格式转化成字符串
 *
 *	@param 	date 	日期
 *	@param 	format 	格式
 *
 *	@return	转化好的字符串
 */
+ (NSString *)getDateStringWithDate:(NSDate *)date andFormat:(NSString *)format;

@end

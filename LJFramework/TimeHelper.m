//
//  TimeHelper.m
//  Transaction
//
//  Created by 李健 on 13-12-25.
//  Copyright (c) 2013年 李健. All rights reserved.
//

#import "TimeHelper.h"
#import "NSDate+OST_DATE.h"

@implementation TimeHelper

+ (NSDateComponents *)getDateComponents
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *now = [NSDate date];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSDateComponents *comps = [calendar components:unitFlags fromDate:now];
    return comps;
}

+ (NSDateComponents *)getDateComponentsWithDate:(NSDate *)date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    return comps;
}
+ (NSDateComponents *)convertTimeToDateComponents:(long long)time
{
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:time/1000];
    
    return [TimeHelper getDateComponentsWithDate:date];
}

+ (long long)convertDateToSecondTime:(NSDate *)date
{
    return [date timeIntervalSince1970]*1000;
}


+ (NSDate *)convertSecondsToDate:(long long)time
{
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:time/1000];
    return date;
}

+ (NSMutableArray *)getNextPageDays:(int)page
{
    int count = 10;
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd EEEE";
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [dateFormatter setTimeZone:timeZone];
    
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    for (int i = 0; i<count; i++) {
        [comps setDay:-(((page-1) * count)+i)];
        NSDate *newdate = [calendar dateByAddingComponents:comps toDate:[NSDate date] options:0];
        [arr addObject:[dateFormatter stringFromDate:newdate]];
    }
    return arr;
}

+ (NSString *)getWeekDayInweekWithDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"EEEE";
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [dateFormatter setTimeZone:timeZone];
    NSString *weekDayStr = [dateFormatter stringFromDate:date];
    return weekDayStr;
}

+ (NSDate *)getYesterDay:(NSDate *)date
{

    NSDate *yesterday = [date dateAfterDay:-1];
    
    return yesterday;
}

//
+ (NSDate *)getBeginDateInWeekWith:(NSDate *)date
{
    NSDate *weekDate = [date beginningOfWeek];
    NSDate *beginDate = [weekDate dateAfterDay:1];
    return beginDate;
}

+ (NSDate *)getEndDateInWeekWithDate:(NSDate *)date
{
    NSDate *SaturdayDate = [date endOfWeek];
    NSDate *endDate = [SaturdayDate dateAfterDay:1];
    return endDate;
}

+ (NSDate *)getlastWeekDayDateWithDate:(NSDate *)date
{
    NSDate *weekDate = [date beginningOfWeek];
    return weekDate;
}

+ (NSDate *)getlastFirstDayDateWithDate:(NSDate *)date
{
    NSDate *lastWeekDate = [TimeHelper getlastWeekDayDateWithDate:date];
    NSDate *firstDayDate = [lastWeekDate dateAfterDay:-6];
    return firstDayDate;
}

+ (NSDate *)getFirstDayDateInCurrentDateMonthWithDate:(NSDate *)date
{
    NSDate *firstDate = [date beginningOfMonth];
    return firstDate;
}

+ (NSDate *)getEndDayDateInCurrentDateMonthWithDate:(NSDate *)date
{
    NSDate *endDate = [date endOfMonth];
    return endDate;
}


+ (NSDate *)getEndDayDateInLastMonthOfDateWithDate:(NSDate *)date
{
    NSDate *beginDateInCurrentMonth = [TimeHelper getFirstDayDateInCurrentDateMonthWithDate:date];
    NSDate *lastMonthEndDate = [beginDateInCurrentMonth dateAfterDay:-1];
    return lastMonthEndDate;
}

+ (NSDate *)getFirstDayDateInLastMonthOfDateWithDate:(NSDate *)date
{
    NSDate *endDateForLastMonth = [TimeHelper getEndDayDateInLastMonthOfDateWithDate:date];
    NSDate *firstDateForLastMonth = [TimeHelper getFirstDayDateInCurrentDateMonthWithDate:endDateForLastMonth];
    return firstDateForLastMonth;
}

+ (NSDate *)dateFromString:(NSString *)str
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSTimeZone *timeZone = [NSTimeZone defaultTimeZone];
    [dateFormatter setTimeZone:timeZone];
    NSDate *date = [dateFormatter dateFromString:str];
    return date;
}

+ (NSDate *)timeFromString:(NSString *)str andFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = format;
    NSTimeZone *timeZone = [NSTimeZone defaultTimeZone];
    [dateFormatter setTimeZone:timeZone];
    NSDate *date = [dateFormatter dateFromString:str];
    return date;
}

+ (NSString *)getYearMonthDayWithDate:(NSDate *)date
{
    NSDateComponents *comps = [TimeHelper getDateComponentsWithDate:date];
    NSString *dateStr = [NSString stringWithFormat:@"%ld-%02ld-%02ld",(long)comps.year,(long)comps.month,(long)comps.day];
    return dateStr;
}

+ (NSString *)getYearMonthDayWithDateInChinese:(NSDate *)date
{
    NSDateComponents *comps = [TimeHelper getDateComponentsWithDate:date];
    NSString *dateStr = [NSString stringWithFormat:@"%ld年%02ld月%02ld日",(long)comps.year,(long)comps.month,(long)comps.day];
    return dateStr;
}

+ (NSString *)getDateStringWithDate:(NSDate *)date andFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = format;
    NSTimeZone *timeZone = [NSTimeZone defaultTimeZone];
    [dateFormatter setTimeZone:timeZone];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}
@end

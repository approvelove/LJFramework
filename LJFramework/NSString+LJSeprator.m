//
//  NSString+LJSeprator.m
//  FlowCircle
//
//  Created by lijian on 15/1/30.
//  Copyright (c) 2015年 lijian. All rights reserved.
//

#import "NSString+LJSeprator.h"

@implementation NSString (LjSeprator)

- (NSArray *)searchStringComformToCondition:(NSString *)regex
{
    NSError *error = NULL;
    NSRegularExpression *regex_exp = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *matchsArray = [regex_exp matchesInString:self options:NSMatchingReportCompletion range:NSMakeRange(0, self.length)];
    return matchsArray;
}

- (NSArray *)subStringComformToRegex:(NSString *)regex
{
    NSArray *matchsArray = [self searchStringComformToCondition:regex];
    NSMutableArray *resultAry = [@[] mutableCopy];
    for (int i=0; i<matchsArray.count; i++) {
        NSTextCheckingResult *result = matchsArray[i];
        NSRange tempRange = result.range;
        NSString *subStr = [self substringWithRange:tempRange];
        [resultAry addObject:subStr];
    }
    return resultAry;
}

- (NSArray *)componentsSeparatedByRegex:(NSString *)regex
{
    NSInteger orignIndex = 0; //起始索引
    NSMutableArray *resultAry = [@[] mutableCopy];
    NSArray *matchsArray = [self searchStringComformToCondition:regex];
    for (int i=0; i< matchsArray.count; i++) {
        NSTextCheckingResult *result = matchsArray[i];
        NSRange tempRange = result.range;
        NSInteger index_fore = tempRange.location - orignIndex;
        NSString *forString = [self substringWithRange:NSMakeRange(orignIndex, index_fore)];  //前置字符串
        [resultAry addObject:forString];
        orignIndex = tempRange.location + tempRange.length; //重置初始的数据
    }
    //加上最后一部分
    NSString *lastPart = [self substringWithRange:NSMakeRange(orignIndex, self.length-orignIndex)];
    [resultAry addObject:lastPart];
    return resultAry;
}

- (BOOL)isConfirmToRegex:(NSString *)regex
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isValid = [predicate evaluateWithObject:self];
    return isValid;
}
@end

//
//  CommonHelper.m
//  FlowCircle
//
//  Created by lijian on 15/1/21.
//  Copyright (c) 2015年 lijian. All rights reserved.
//

#import "CommonHelper.h"

@implementation CommonHelper

+ (void)postNotificationWithNotificationName:(NSString *)notificationName userInfo:(NSDictionary *)userInfo
{
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:nil userInfo:userInfo];
}
@end

//
//  CommonHelper.h
//  FlowCircle
//
//  Created by lijian on 15/1/21.
//  Copyright (c) 2015年 lijian. All rights reserved.
//

#define rgbaColor(r,g,b,a) [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:a]

#import <Foundation/Foundation.h>
@interface CommonHelper : NSObject

/**
 *	@brief	发送一个通知
 *
 *	@param 	notificationName      通知名
 *	@param 	userInfo      透传消息
 */
+ (void)postNotificationWithNotificationName:(NSString *)notificationName userInfo:(NSDictionary *)userInfo;


@end

//
//  LJToast.h
//  TestChart
//
//  Created by JamesLee on 16/7/7.
//  Copyright © 2016年 JamesLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJToast : UIView

/**
 *  弹出toast
 */
- (void)show;

/**
 *  构造一个Toast对象
 *
 *  @param text 显示内容
 *
 *  @return toast对象
 */
+ (LJToast *)makeToast:(NSString *)text;
@end

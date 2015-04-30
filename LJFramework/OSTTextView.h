//
//  OSTTextView.h
//  onestong
//
//  Created by 李健 on 14-4-22.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OSTTextView : UITextView


/**
 *	@brief	设置placeHolder
 *
 *	@param 	placeHolder 	描述内容
 *
 *	@return	nil
 */
- (void)installPlaceHolder:(NSString *)placeHolder;

/**
 *	@brief	清除描述文字
 *
 *	@return	nil
 */
- (void)clearPlaceHolder;

@end

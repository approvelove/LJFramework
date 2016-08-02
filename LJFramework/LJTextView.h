//
//  LJTextView.h
//  JLD
//
//  Created by James Lee on 16/4/28.
//  Copyright © 2016年 James Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJTextView : UITextView

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

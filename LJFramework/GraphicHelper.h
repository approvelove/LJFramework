//
//  GraphicHelper.h
//  onestong
//
//  Created by 王亮 on 14-4-22.
//  Copyright (c) 2014年 王亮. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface GraphicHelper : NSObject

/**
 *	@brief    将视图变为圆形
 *
 *	@param 	view 	待处理视图
 *
 *	@return	nil
 */
+(void)convertRectangleToCircular:(UIView *)view;

/**
 *	@brief	将视图转换成带边框的圆环
 *
 *	@param 	view 	待处理视图
 *	@param 	color 	边框颜色
 *	@param 	width 	边框宽度
 *
 *	@return	nil
 */
+(void)convertRectangleToCircular:(UIView *)view withBorderColor:(UIColor *)color andBorderWidth:(float)width;

/**
 *	@brief	将视图转化成任意形状的椭圆
 *
 *	@param 	view 	待处理视图
 *	@param 	color 	视图边框颜色
 *	@param 	width 	视图边框宽度
 *	@param 	radius 	视图边框弧度
 *
 *	@return	nil
 */
+(void)convertRectangleToEllipses:(UIView *)view withBorderColor:(UIColor *)color andBorderWidth:(float)width andRadius:(float)radius;

/**
 *	@brief	将制定的颜色转换成图片
 *
 *	@param 	color 	颜色
 *
 *	@return	图片
 */
+ (UIImage *)convertColorToImage:(UIColor *)color;


/**
 *	@brief	//对图片尺寸进行压缩--
 *
 *	@param 	image
 *	@param 	newSize
 *
 *	@return	
 */
+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

@end

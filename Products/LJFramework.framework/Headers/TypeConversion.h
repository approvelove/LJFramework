//
//  TypeConversion.h
//  FlowCircle
//
//  Created by lijian on 15/1/13.
//  Copyright (c) 2015年 lijian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TypeConversion : NSObject

/**
 *	@brief	将字符串转化成为字节类型
 *
 *	@param 	aString 	待转化的字符串
 *
 *	@return	转化后的字节类型
 */
+ (NSData *)dataWithString:(NSString *)aString;

/**
 *	@brief	将字节类型转化成为字符串
 *
 *	@param 	aString 	待转化的字节类型
 *
 *	@return	转化后的字符串
 */
+ (NSString *)stringWithData:(NSData *)aData;

/**
 *	@brief	将data类型转化为16进制的字符串
 *
 *	@param 	sender 	待转换的data
 *
 *	@return	十六进制的字符串
 */
+ (NSString*)stringWithHexBytes2:(NSData *)sender;

/**
 *	@brief	将16进制的字符串转化为data
 *
 *	@param 	hexString 	16进制的字符串
 *
 *	@return	data
 */
+ (NSData*)dataWithHexBytesString:(NSString*)hexString;

/**
 *	@brief	将字节类型数据转化成16进制的字符串
 *
 *	@param 	bytes 	字节类型数据
 *
 *	@return	16进制字符串
 */
+ (NSString *)parseByte2HexString:(Byte *)bytes;

/**
 *	@brief	将字节类型数组转化为16进制的字符串
 *
 *	@param 	bytes 	字节类型数组
 *
 *	@return	16进制字符串
 */
+ (NSString *)parseByteArray2HexString:(Byte[])bytes;

/**
 *	@brief	将字典转化为json字符串
 *
 *	@param 	dictionary 	字典
 *
 *	@return	json字符串
 */
+(NSString *) jsonStringWithDictionary:(NSDictionary *)dictionary;

/**
 *	@brief	将数组转化为json字符串
 *
 *	@param 	array 	数组
 *
 *	@return	json字符串
 */
+(NSString *) jsonStringWithArray:(NSArray *)array;

/**
 *	@brief	将普通字符串转化为json字符串
 *
 *	@return	json字符串
 */
+(NSString *) jsonStringWithString:(NSString *) string;

/**
 *	@brief	将字符串，字典，数组转化为json字符串
 *
 *	@return	json字符串
 */
+(NSString *) jsonStringWithObject:(id) object;

@end

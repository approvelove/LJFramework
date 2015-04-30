//
//  EncryptionClass.h
//  NewLonking
//
//  Created by 李健 on 14-9-12.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EncryptionClass : NSObject

/**
 *	@brief	使用md5加密处理
 *
 *	@param 	str 	加密数据
 *
 *	@return	返回加密后结果
 */
+ (NSString *)md5:(NSString *)str;

/**
 *	@brief	使用AES加密 (需要测试验证)
 *
 *	@param 	tempStr 	待加密数据
 *	@param 	key 	加密密钥
 *
 *	@return	加密后数据
 */
+ (NSData *)AES256EncryptString:(NSString *)tempStr withKey:(NSString *)key;

/**
 *	@brief	使用AES解密(需要测试验证)
 *
 *	@param 	aData 	待解密数据
 *	@param 	key 解密密钥
 *
 *	@return	解密后数据
 */
+ (NSData *)AES256DecryptData:(NSData *)aData WithKey:(NSString *)key;

/**
 *	@brief	对文本进行DES加密
 *
 *	@param 	data    待加密的文本数据
 *	@param 	key 	加密所有的公钥
 *
 *	@return	加密好的数据
 */
+ (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key;

/**
 *	@brief	对文本进行DES解密
 *
 *	@param 	data    待解密的数据
 *	@param 	key 	解密所用的公钥
 *
 *	@return	解密好的数据
 */
+ (NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key;

/**
 *	@brief	将文本格式数据转化为base64字符串
 *
 *	@param 	data 	文本数据
 *
 *	@return	base64字符串
 */
+ (NSString *)base64EncodedStringFrom:(NSData *)data;

/**
 *	@brief	将base64字符串转化为文本数据
 *
 *	@param 	string 	base64字符串
 *
 *	@return	文本数据
 */
+ (NSData *)dataWithBase64DecodedString:(NSString *)string;

@end

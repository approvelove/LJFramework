//
//  FileHelper.m
//  NewLonking
//
//  Created by 李健 on 14-8-30.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "FileHelper.h"
#import "VerifyHelper.h"

@implementation FileHelper

+ (NSString *)getDocumentPathWithName:(NSString *)documentName
{
    NSArray *array =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *fileName = [[array objectAtIndex:0] stringByAppendingPathComponent:documentName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:fileName]) {
        return fileName;
    }
    BOOL isSuc = [[NSFileManager defaultManager] createDirectoryAtPath:fileName withIntermediateDirectories:YES attributes:nil error:nil];
    if (isSuc) {
        return fileName;
    }
   else
   {
       return nil;
   }
}

+ (BOOL)storeFileToDocumentWithData:(NSData *)data andName:(NSString *)fileName andDocumentPath:(NSString *)aPath
{
    NSString *filePath = [NSString stringWithFormat:@"%@",[FileHelper getDocumentPathWithName:fileName]];
    if (![VerifyHelper isEmpty:aPath]) {
       filePath = [NSString stringWithFormat:@"%@/%@",[FileHelper getDocumentPathWithName:aPath],fileName];
    }
    NSFileManager *manager = [NSFileManager defaultManager];
    if (!data || data.length == 0) {
        return NO;
    }
    if ([manager fileExistsAtPath:filePath]) {
        [data writeToFile:filePath atomically:YES];
        return YES;
    }
    BOOL isSUc = [data writeToFile:filePath atomically:YES];
    if (isSUc) {
        NSLog(@"success");
        return YES;
    }
    return NO;
}

+ (NSData *)readFileFromDocumentsWithFileName:(NSString *)fileName andDocumentPath:(NSString *)aPath
{
    NSString *filePath = [NSString stringWithFormat:@"%@",[FileHelper getDocumentPathWithName:fileName]];
    if (![VerifyHelper isEmpty:aPath]) {
        filePath = [NSString stringWithFormat:@"%@/%@",[FileHelper getDocumentPathWithName:aPath],fileName];
    }
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    return data;
}

+ (void)archiveObject:(id)obj withKey:(NSString *)aKey
{
    NSMutableData *mutData = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:mutData];
    [archiver encodeObject:obj forKey:aKey];
    [archiver finishEncoding];
    [mutData writeToFile:[FileHelper getDocumentPathWithName:aKey] atomically:YES];
//    [NSKeyedArchiver archiveRootObject:obj toFile:[FileHelper getDocumentPathWithName:aKey]];
}

+ (id)unArchiveObjectWithKey:(NSString *)aKey
{
    NSMutableData *data = [[NSMutableData alloc] initWithContentsOfFile:[FileHelper getDocumentPathWithName:aKey]];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    id result = [unarchiver decodeObjectForKey:aKey];
    [unarchiver finishDecoding];
    return result;
//    return [NSKeyedUnarchiver unarchiveObjectWithFile:[FileHelper getDocumentPathWithName:aKey]];
}

+ (void)removeFileWithFileName:(NSString *)fileName documentPath:(NSString *)aPath
{
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",aPath,fileName];
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]) {
        [manager removeItemAtPath:filePath error:nil];
    }
}
@end

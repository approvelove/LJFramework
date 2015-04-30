//
//  Contactor.m
//  AddressBook
//
//  Created by 李健 on 14-3-19.
//  Copyright (c) 2014年 李健. All rights reserved.
//

#import "Contactor.h"
#include <objc/runtime.h>
#import "FileHelper.h"

NSString *archiveKey = @"archiveData";

@implementation Contactor
@synthesize firstName,lastName,nickName;
@synthesize homePhone,email,birthday,blogIndex;
@synthesize company,department,recordID,imageData,status,userID;

//对象可以将它们的实例变量和其他数据编码为数据块，然后保存到磁盘中,对象序列化
- (void)encodeWithCoder:(NSCoder *)encoder {
    Class cls = [self class];
    while (cls != [NSObject class]) {
        unsigned int numberOfIvars = 0;
        Ivar* ivars = class_copyIvarList(cls, &numberOfIvars);
        for(const Ivar* p = ivars; p < ivars+numberOfIvars; p++)
        {
            Ivar const ivar = *p;
            const char *type = ivar_getTypeEncoding(ivar);
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            if([key isEqualToString:@"_delegate"])
            {
                continue;
            }
            id value = [self valueForKey:key];
            if (value) {
                switch (type[0]) {
                    case _C_STRUCT_B: {
                        NSUInteger ivarSize = 0;
                        NSUInteger ivarAlignment = 0;
                        NSGetSizeAndAlignment(type, &ivarSize, &ivarAlignment);
                        NSData *data = [NSData dataWithBytes:(const char *)(__bridge void *)self + ivar_getOffset(ivar)
                                                      length:ivarSize];
                        [encoder encodeObject:data forKey:key];
                    }
                        break;
                    default:
                        
                        if ([value conformsToProtocol:@protocol(NSCoding)])
                        {
                            [encoder encodeObject:value forKey:key];
                        }else {
                            //assert(0); // crash for debug
                        }
                        
                        break;
                }
            }
        }
        if (ivars) {
            free(ivars);
        }
        
        cls = class_getSuperclass(cls);
    }
}

- (id)initWithCoder:(NSCoder *)decoder {
    
    self = [super init];
    
    if (self) {
        Class cls = [self class];
        while (cls != [NSObject class]) {
            unsigned int numberOfIvars = 0;
            Ivar* ivars = class_copyIvarList(cls, &numberOfIvars);
            
            for(const Ivar* p = ivars; p < ivars+numberOfIvars; p++)
            {
                Ivar const ivar = *p;
                const char *type = ivar_getTypeEncoding(ivar);
                const char *name = ivar_getName(ivar);
                NSString *key = [NSString stringWithUTF8String:name];
                id value = [decoder decodeObjectForKey:key];
                if (value) {
                    switch (type[0]) {
                        case _C_STRUCT_B: {
                            NSUInteger ivarSize = 0;
                            NSUInteger ivarAlignment = 0;
                            NSGetSizeAndAlignment(type, &ivarSize, &ivarAlignment);
                            NSData *data = [decoder decodeObjectForKey:key];
                            char *sourceIvarLocation = (char*)(__bridge void *)self+ ivar_getOffset(ivar);
                            [data getBytes:sourceIvarLocation length:ivarSize];
                            memcpy((char *)(__bridge void *)self + ivar_getOffset(ivar), sourceIvarLocation, ivarSize);
                        }
                            break;
                        default:
                            [self setValue:value forKey:key];
                            
                            break;
                    }
                }
            }
            
            if (ivars) {
                free(ivars);
            }
            cls = class_getSuperclass(cls);
        }
    }
    
    return self;
}


- (id)copyWithZone:(NSZone *)zone
{
    id copy = [[[self class] alloc] init];
    if (copy) {
        [copy setFirstName:[self.firstName copyWithZone:zone]];
        [copy setLastName:[self.lastName copyWithZone:zone]];
        [copy setNickName:[self.nickName copyWithZone:zone]];
        [copy setHomePhone:[self.homePhone copyWithZone:zone]];
        [copy setEmail:[self.email copyWithZone:zone]];
        [copy setBirthday:[self.birthday copyWithZone:zone]];
        [copy setBlogIndex:[self.blogIndex copyWithZone:zone]];
        [copy setCompany:[self.company copyWithZone:zone]];
        [copy setDepartment:[self.department copyWithZone:zone]];
        [copy setFullName:[self.fullName copyWithZone:zone]];
        [copy setImageData:[self.imageData copyWithZone:zone]];
        [copy setStatus:self.status];
        [copy setUserID:self.userID];
    }
    return copy;
}

- (void)archiveData
{
    if (!self) {
        return;
    }
    NSMutableData *mutData = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:mutData];
    [archiver encodeObject:self forKey:archiveKey];
    [archiver finishEncoding];
    [mutData writeToFile:[FileHelper getDocumentPathWithName:@"Contactors"] atomically:YES];
}

+ (Contactor *)unArchiveData
{
    NSMutableData *data = [[NSMutableData alloc] initWithContentsOfFile:[FileHelper getDocumentPathWithName:@"Contactors"]];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    Contactor *result = [unarchiver decodeObjectForKey:archiveKey];
    [unarchiver finishDecoding];
    return result;
}
@end

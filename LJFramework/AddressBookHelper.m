//
//  AddressBookHelper.m
//  AddressBookHelper
//
//  Created by 李健 on 14-3-19.
//  Copyright (c) 2014年 李健. All rights reserved.
//

#import "AddressBookHelper.h"
#import <AddressBook/AddressBook.h>

@implementation AddressBookHelper

-(void)GetUserAddressBookWithOperation:(ADDRESSBOOKOPERATION)operation parameter:(id)parameter
{
    //获取通讯录权限
    ABAddressBookRef ab = NULL;
    // ABAddressBookCreateWithOptions is iOS 6 and up.
    if (&ABAddressBookCreateWithOptions) {
        CFErrorRef error = nil;
        ab = ABAddressBookCreateWithOptions(NULL, &error);
        
        if (error) { NSLog(@"%@", error); }
    }
    if (ab) {
        // ABAddressBookRequestAccessWithCompletion is iOS 6 and up. 适配IOS6以上版本
        if (&ABAddressBookRequestAccessWithCompletion) {
            ABAddressBookRequestAccessWithCompletion(ab,
                                                     ^(bool granted, CFErrorRef error) {
                                                         if (granted) {
                                                             [self operationWithObject:CFBridgingRelease(ab) Operation:operation paramater:parameter];
                                                             
                                                         }
                                                         else {
                                                             // Ignore the error
                                                             NSLog(@"load addressbookerror");
                                                         }
                                                     });
        }
//        else {
//            [self operationWithObject:CFBridgingRelease(ab) Operation:operation paramater:parameter];
//        }
    }
}

- (void)operationWithObject:(id)arguement Operation:(ADDRESSBOOKOPERATION)operation paramater:(NSDictionary *)param
{
    NSMutableDictionary *paramDictionary = [NSMutableDictionary dictionary];
    if (arguement) {
        [paramDictionary setObject:arguement forKey:@"arguement"];
    }
    if (param) {
        [paramDictionary setObject:param forKey:@"paramater"];
    }
    
    switch (operation) {
        case ADDRESSBOOKOPERATION_FINDPERSONALL:
            [NSThread detachNewThreadSelector:@selector(constructInThread:)
                                     toTarget:self
                                   withObject:arguement];
            break;
        case ADDRESSBOOKOPERATION_FINDPERSONONE:
            [NSThread detachNewThreadSelector:@selector(getOnePersonInAddressBookWithParamater:)
                                     toTarget:self
                                   withObject:paramDictionary];
            break;
//        case ADDRESSBOOKOPERATION_FINDGROUPALL:
//            //获取所有组 暂时不做
//            break;
//        case ADDRESSBOOKOPERATION_FINDGROUPONE:
//            //获取单个组暂时不做
//            break;
        case ADDRESSBOOKOPERATION_ADDONE:
            [NSThread detachNewThreadSelector:@selector(addContactorWithParamater:)
                                     toTarget:self
                                   withObject:paramDictionary];
            break;
        case ADDRESSBOOKOPERATION_DELETEONE:
            [NSThread detachNewThreadSelector:@selector(deleteContactorWithParamater:)
                                     toTarget:self
                                   withObject:paramDictionary];
            break;
//        case ADDRESSBOOKOPERATION_DELETEGROUPONE:
//            //删除一个组
//            break;
    }
}

- (void)deleteContactorWithParamater:(NSDictionary *)param
{
    ABAddressBookRef ab = (__bridge ABAddressBookRef)(param[@"arguement"]);
    int personID = [param[@"paramater"] intValue];
    CFErrorRef error = NULL;
    ABRecordRef deletePerson = ABAddressBookGetPersonWithRecordID(ab, personID);
    ABAddressBookRemoveRecord(ab, deletePerson, &error);
    ABAddressBookSave(ab, &error);
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_ADDRESSBOOK_DELETEPERSON_OVER object:nil];
}

////获取所有组
//- (void)getAllGroupInAddressBookWithParamater:(NSDictionary *)param
//{
//     ABAddressBookRef ab = (__bridge ABAddressBookRef)(param[@"arguement"]);
//}

//添加组 该方法目前暂不使用
- (void)addOneGroupOnAddressBook:(NSDictionary *)param
{
    ABAddressBookRef ab = (__bridge ABAddressBookRef)(param[@"arguement"]);
    NSString *groupName = param[@"paramater"];
    ABRecordRef newGroup = ABGroupCreate();
    CFErrorRef error = NULL;
    ABRecordSetValue(newGroup, kABGroupNameProperty, (__bridge CFTypeRef)(groupName), &error);
    ABAddressBookAddRecord(ab, newGroup, nil);
    ABAddressBookSave(ab, nil);
    CFRelease(newGroup);
}

//添加联系人
- (void)addContactorWithParamater:(NSDictionary *)param
{
    ABAddressBookRef ab = (__bridge ABAddressBookRef)(param[@"arguement"]);
    Contactor *temCtor = param[@"paramater"];
    if (temCtor == nil) {
        return;
    }
    ABRecordRef newPerson = ABPersonCreate();
    CFErrorRef error = NULL;
    ABRecordSetValue(newPerson, kABPersonFirstNameProperty, (__bridge CFTypeRef)(temCtor.firstName), &error);
    ABRecordSetValue(newPerson, kABPersonLastNameProperty, (__bridge CFTypeRef)(temCtor.lastName), &error);
    ABRecordSetValue(newPerson, kABPersonOrganizationProperty, (__bridge CFTypeRef)(temCtor.company), &error);
    ABRecordSetValue(newPerson, kABPersonDepartmentProperty, (__bridge CFTypeRef)(temCtor.department), &error);
    ABRecordSetValue(newPerson, kABPersonNicknameProperty, (__bridge CFTypeRef)(temCtor.nickName), &error);
    ABRecordSetValue(newPerson, kABPersonBirthdayProperty, (__bridge CFTypeRef)(temCtor.birthday), &error);
    
    //    ABRecordSetValue(newPerson, kABPersonFirstNamePhoneticProperty, firsrNamePY.text, &error);
    //    ABRecordSetValue(newPerson, kABPersonLastNamePhoneticProperty, lastNamePY.text, &error);
    //phone number
    ABMutableMultiValueRef multiPhone = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    //    ABMultiValueAddValueAndLabel(multiPhone, houseNumber.text, kABPersonPhoneHomeFAXLabel, NULL);
    ABMultiValueAddValueAndLabel(multiPhone, (__bridge CFTypeRef)(temCtor.homePhone), kABPersonPhoneMobileLabel, NULL);
    ABRecordSetValue(newPerson, kABPersonPhoneProperty, multiPhone, &error);
    CFRelease(multiPhone);
    //email
    ABMutableMultiValueRef multiEmail = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    ABMultiValueAddValueAndLabel(multiEmail, (__bridge CFTypeRef)(temCtor.email), kABWorkLabel, NULL);
    ABRecordSetValue(newPerson, kABPersonEmailProperty, multiEmail, &error);
    CFRelease(multiEmail);
    //picture
    //    NSData *dataRef = UIImagePNGRepresentation(head.image);
    //    ABPersonSetImageData(newPerson, (CFDataRef)dataRef, &error);
    ABAddressBookAddRecord(ab, newPerson, &error);
    ABAddressBookSave(ab, &error);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_ADDRESSBOOK_ADDONEPERSON_OVER object:nil];
    
    CFRelease(newPerson);
}


//获取指定联系人
- (void)getOnePersonInAddressBookWithParamater:(NSDictionary *)param
{
    ABAddressBookRef ab = (__bridge ABAddressBookRef)(param[@"arguement"]);
    NSString *nameStr = param[@"paramater"];
    if (nameStr == nil) {
        return;
    }
    
    CFStringRef nameRef = (__bridge CFStringRef)nameStr;
    CFArrayRef results = ABAddressBookCopyPeopleWithName(ab, nameRef);
    CFRelease(nameRef);
    
    NSArray *personAry = [self readPersonDetailBypersonAry:results];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_ADDRESSBOOK_READONECONTACTOR_OVER object:nil userInfo:@{@"contactors":personAry}];
    
    CFRelease(results);
    personAry = nil;
}

//获取所有联系人
-(void)constructInThread:(ABAddressBookRef) ab
{
    CFArrayRef results = ABAddressBookCopyArrayOfAllPeople(ab);
    NSMutableArray* contactArray = [self readPersonDetailBypersonAry:results];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_ADDRESSBOOK_READALLCONTACTORS_OVER object:nil userInfo:@{@"contactors":contactArray}];
    CFRelease(results);
    contactArray = nil;
}

- (NSMutableArray *)readPersonDetailBypersonAry:(CFArrayRef)results
{
    NSMutableArray* contactArray = [[NSMutableArray alloc] init];
    for(int i = 0; i < CFArrayGetCount(results); i++)
    {
        ABRecordRef person = CFArrayGetValueAtIndex(results, i);
        //姓
        NSString *firstName = (NSString*)CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNameProperty));
        //姓音标
        //        NSString *firstNamePhonetic = (NSString*)CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNamePhoneticProperty));
        //名
        NSString *lastname = (NSString*)CFBridgingRelease(ABRecordCopyValue(person, kABPersonLastNameProperty));
        //名音标
        //        NSString *lastnamePhonetic = (NSString*)CFBridgingRelease(ABRecordCopyValue(person, kABPersonLastNamePhoneticProperty));
        //公司
        NSString *Organization = (NSString*)CFBridgingRelease(ABRecordCopyValue(person, kABPersonOrganizationProperty));
        //读取jobtitle工作
        //        NSString *jobtitle = (NSString*)CFBridgingRelease(ABRecordCopyValue(person, kABPersonJobTitleProperty));
        //读取department部门
        NSString *department = (NSString*)CFBridgingRelease(ABRecordCopyValue(person, kABPersonDepartmentProperty));
        //读取birthday生日
        NSDate *birthday = (NSDate*)CFBridgingRelease(ABRecordCopyValue(person, kABPersonBirthdayProperty));
        //读取nickname呢称
        NSString *nickname = (NSString*)CFBridgingRelease(ABRecordCopyValue(person, kABPersonNicknameProperty));
        //读取电话多值
        NSString* phoneString = @"";
        ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
        for (int k = 0; k<ABMultiValueGetCount(phone); k++)
        {
            //获取电话Label
            //            NSString * personPhoneLabel = (NSString*)CFBridgingRelease(ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(phone, k)));
            //获取該Label下的电话值
            NSString * personPhone = (NSString*)CFBridgingRelease(ABMultiValueCopyValueAtIndex(phone, k));
            phoneString = [phoneString stringByAppendingFormat:@"%@",personPhone];
            personPhone = nil;
            
        }
        CFRelease(phone);
        //获取email多值
        NSString* emailString = @"";
        ABMultiValueRef email = ABRecordCopyValue(person, kABPersonEmailProperty);
        int emailcount = (int)ABMultiValueGetCount(email);
        for (int x = 0; x < emailcount; x++)
        {
            //获取email Label
            //            NSString* emailLabel = (NSString*)CFBridgingRelease(ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(email, x)));
            //获取email值
            NSString* emailContent = (NSString*)CFBridgingRelease(ABMultiValueCopyValueAtIndex(email, x));
            emailString = [emailString stringByAppendingFormat:@",%@",emailContent];
            emailContent = nil;
        }
        CFRelease(email);
        
        //获取URL多值
        NSString* urlString = @"";
        ABMultiValueRef url = ABRecordCopyValue(person, kABPersonURLProperty);
        for (int m = 0; m < ABMultiValueGetCount(url); m++)
        {
            //获取电话Label
            //            NSString * urlLabel = (NSString*)CFBridgingRelease(ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(url, m)));
            //获取該Label下url值
            NSString * urlContent = (NSString*)CFBridgingRelease(ABMultiValueCopyValueAtIndex(url,m));
            urlString = [urlString stringByAppendingFormat:@"%@",urlContent];
            urlContent = nil;
        }
        CFRelease(url);
        
        //获取头像
        CFDataRef dataRef = ABPersonCopyImageData(person);
        NSData *tempImageData = (__bridge NSData *)dataRef;
        //存储联系人
        Contactor *ctor = [[Contactor alloc] init];
        ctor.firstName = firstName?firstName:@"";
        ctor.lastName = lastname?lastname:@"";
        ctor.homePhone = phoneString?[phoneString stringByReplacingOccurrencesOfString:@"-" withString:@""]:@"";  //去掉横线
        ctor.email = emailString?emailString:@"";
        ctor.company = Organization?Organization:@"";
        ctor.nickName = nickname?nickname:@"";
        ctor.department = department?department:@"";
        ctor.birthday = birthday;
        ctor.blogIndex = urlString?urlString:@"";
        ctor.fullName = [NSString stringWithFormat:@"%@%@",ctor.lastName,ctor.firstName];
        ctor.recordID = ABRecordGetRecordID(person);
        ctor.imageData = tempImageData;
        
        [contactArray addObject:ctor];
        emailString = nil;
        urlString = nil;
        phoneString = nil;
    }
    return contactArray;
}
@end


//
//  BaseViewController.m
//  RRT
//
//  Created by lijian on 14/11/21.
//
//

#import "BaseViewController.h"
#import "MBProgressHUD.h"
#import "CRToast.h"
#import "PGToast.h"

@interface BaseViewController ()

@property (nonatomic, strong) NSMutableDictionary *options;
@end

@implementation BaseViewController
@synthesize options;

- (void)viewDidLoad
{
    [super viewDidLoad];
    options =[@{kCRToastNotificationTypeKey               : @(CRToastTypeNavigationBar),
                kCRToastNotificationPresentationTypeKey   : @(CRToastPresentationTypeCover),
                kCRToastUnderStatusBarKey                 : @(YES),
                kCRToastTextKey                           : @"HELLO",
                kCRToastSubtitleTextKey                    :@"",
                kCRToastTextAlignmentKey                  : @(NSTextAlignmentLeft),
                kCRToastSubtitleTextAlignmentKey          : @(NSTextAlignmentLeft),
                kCRToastTimeIntervalKey                   : @(1.5),
                kCRToastAnimationInTypeKey                : @(CRToastAnimationTypeGravity),
                kCRToastAnimationOutTypeKey               : @(CRToastAnimationTypeGravity),
                kCRToastAnimationInDirectionKey           : @(0),
                kCRToastAnimationOutDirectionKey          : @(0)}mutableCopy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 通用操作

- (void)showAlertwithTitle:(NSString *)titleStr
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:titleStr delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

- (void)startLoading:(NSString *)labelText
{
    [[MBProgressHUD showHUDAddedTo:self.view animated:YES] setLabelText:labelText];
}

- (void)startLoading
{
    [self startLoading:@"正在加载..."];
}

- (void)stopLoading
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

-(void)ShowToastMessage:(NSString*)titleStr subMessage:(NSString*)SubtitleStr
{
    [self options][kCRToastSubtitleTextKey] =SubtitleStr;
    [self options][kCRToastTextKey] = titleStr;
    [CRToastManager showNotificationWithOptions:[self options]
                                 apperanceBlock:^(void) {
                                     NSLog(@"Appeared");
                                 }
                                completionBlock:^(void) {
                                    NSLog(@"Completed");
                                }];
}

- (void)showPGToast:(NSString *)title
{
    if(title == nil || [[title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]  isEqual: @""])
    {
        return;
    }
    PGToast *toast = [PGToast makeToast:title];
    [toast show];
}
@end

//
//  BaseViewController.h
//  RRT
//
//  Created by lijian on 14/11/21.
//
//

#import <UIKit/UIKit.h>
#import "CommonHelper.h"

@interface BaseViewController : UIViewController

/**
 *	@brief	弹窗显示提示信息
 *
 *	@param 	titleStr 	待显示的内容
 */
- (void)showAlertwithTitle:(NSString *)titleStr;

/**
 *	@brief	显示提示信息
 *
 *	@param 	labelText 	显示的提示内容
 */
- (void)startLoading:(NSString *)labelText;

/**
 *	@brief	显示提示信息 默认显示“正在加载...”
 */
- (void)startLoading;

/**
 *	@brief	停止提示的显示
 */
- (void)stopLoading;

-(void)ShowToastMessage:(NSString*)titleStr subMessage:(NSString*)SubtitleStr;

- (void)showPGToast:(NSString *)title;
@end

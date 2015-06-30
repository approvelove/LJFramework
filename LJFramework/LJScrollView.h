//
//  LJScrollView.h
//  Test
//
//  Created by lijian on 15/4/23.
//  Copyright (c) 2015年 lijian. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LJScrollViewDelegate;


typedef NS_ENUM(NSInteger, ScrollDirection) {
    ScrollDirection_left,
    ScrollDirection_right
};

@interface LJScrollView : UIScrollView

@property (nonatomic) BOOL needShuffling;  //是否需要轮播

@property (nonatomic) NSTimeInterval shufflingInterval; //轮播时间间隔

@property (nonatomic, copy) NSArray *imageSource; //轮播的数据源

@property (nonatomic) UIViewContentMode imageMode;  //图片的显示方式

@property (nonatomic, weak) id<LJScrollViewDelegate> LJDelegate;

@property (nonatomic) BOOL showPageControl; //是否显示pageControl的点

/**
 *	@brief	启动自动轮播
 *
 *	@param 	interval 	轮播时间间隔
 */
- (void)startAutoShufflingWithTimeinterval:(NSTimeInterval)interval;

/**
 *	@brief	停止自动轮播
 */
- (void)stopAutoShuffling;

@end

@protocol LJScrollViewDelegate <NSObject>

- (void)scrollViewDidScroll:(LJScrollView *)scrollView;

- (void)scrollViewDidEndScrollingAnimation:(LJScrollView *)scrollView;

- (void)scrollViewDidZoom:(LJScrollView *)scrollView;

- (void)scrollViewWillBeginDragging:(LJScrollView *)scrollView;

- (void)scrollViewWillEndDragging:(LJScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset;

- (void)scrollViewDidEndDragging:(LJScrollView *)scrollView willDecelerate:(BOOL)decelerate;

- (void)scrollViewWillBeginDecelerating:(LJScrollView *)scrollView;

- (void)scrollViewDidEndDecelerating:(LJScrollView *)scrollView;

- (UIView *)viewForZoomingInScrollView:(LJScrollView *)scrollView;

- (void)scrollViewWillBeginZooming:(LJScrollView *)scrollView withView:(UIView *)view;

- (void)scrollViewDidEndZooming:(LJScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale;

- (BOOL)scrollViewShouldScrollToTop:(LJScrollView *)scrollView;

- (void)scrollViewDidScrollToTop:(LJScrollView *)scrollView;
@end
//
//  LJScrollView.m
//  Test
//
//  Created by lijian on 15/4/23.
//  Copyright (c) 2015年 lijian. All rights reserved.
//

#import "LJScrollView.h"

@interface LJScrollView()<UIScrollViewDelegate>
{
    BOOL _needShuffling;
    NSTimeInterval _shufflingInterval;
    NSTimer *timer;
    UIPageControl *pageCtrl;
    NSMutableArray *imageData;
    BOOL goNext;
}
@end

@implementation LJScrollView
@dynamic needShuffling,shufflingInterval;
@synthesize imageSource,LJDelegate,imageMode,showPageControl;

- (NSTimeInterval)shufflingInterval
{
    if (_shufflingInterval <= 0) {
        _shufflingInterval = 2.f; ///设置默认的2秒间隔
    }
    return _shufflingInterval;
}

- (void)setShufflingInterval:(NSTimeInterval)shufflingInterval
{
    _shufflingInterval = shufflingInterval;
}

- (BOOL)needShuffling
{
    return _needShuffling;
}

- (void)setNeedShuffling:(BOOL)needShuffling
{
    _needShuffling = needShuffling;
    if (needShuffling) {
        //当设置为需要轮播的时候
        /*
         1、检查数据源
         2、自动设置它的pageControl属性
         3、在数据源充足的情况下设置轮播
         */
        /////////////////第一步///////////////
        if (!self.imageSource || self.imageSource.count == 0) {
            //当数据源不充足时不执行轮播操作
            _needShuffling = NO;  //重置needShuffling属性
            return;
        }
        self.delegate = self;
        imageData = [self.imageSource mutableCopy];
        [imageData insertObject:[self.imageSource lastObject] atIndex:0];
        [imageData addObject:[self.imageSource firstObject]];
        self.contentSize = CGSizeMake(imageData.count * CGRectGetWidth(self.bounds), 0);
        [self loadAllImageView];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        /////////////////第二步///////////////
        self.pagingEnabled = YES;
        [self addPageControl];
    }
}

- (void)loadAllImageView
{
    for (UIView *temp in self.subviews) {
        [temp removeFromSuperview];
    }
    for (int i=0; i<imageData.count; i++) {
        [self loadImageViewWithTag:i];
    }
}

#pragma mark - step
- (void)addPageControl
{
    
    CGPoint origin = CGPointMake(0, CGRectGetMaxY(self.frame) - 20);
    if (pageCtrl) {
        [pageCtrl removeFromSuperview];
        pageCtrl = nil;
    }
    pageCtrl.userInteractionEnabled = NO;
    pageCtrl = [[UIPageControl alloc] initWithFrame:CGRectMake(origin.x, origin.y, CGRectGetWidth(self.bounds), 20)];
    pageCtrl.backgroundColor = [UIColor clearColor];
    pageCtrl.currentPageIndicatorTintColor = [UIColor blueColor];
    pageCtrl.pageIndicatorTintColor = [UIColor whiteColor];
    pageCtrl.numberOfPages = self.imageSource.count;
    [self.superview insertSubview:pageCtrl aboveSubview:self];
    [self setContentOffset:CGPointMake(CGRectGetWidth(self.bounds), 0) animated:NO];
    if (!self.showPageControl) {
        pageCtrl.hidden = YES;
    }
}

- (void)startAutoShufflingWithTimeinterval:(NSTimeInterval)interval
{
    self.shufflingInterval = interval;
    if (!timer) {
        timer = [NSTimer scheduledTimerWithTimeInterval:self.shufflingInterval target:self selector:@selector(goNextPage) userInfo:nil repeats:YES];
    }
    [timer fire]; //开始轮播
}

- (void)stopAutoShuffling
{
    [timer invalidate];
}

- (void)goNextPage
{
    goNext = YES;
    [self setContentOffset:CGPointMake(self.contentOffset.x + CGRectGetWidth(self.frame), 0) animated:YES];
}

- (void)loadImageViewWithTag:(int)tag
{
    UIImageView *currentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(tag*CGRectGetWidth(self.bounds), 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
    currentImageView.image = imageData[tag];
    currentImageView.clipsToBounds = YES;
    currentImageView.tag = tag;
    currentImageView.contentMode = self.imageMode;
    [self addSubview:currentImageView];
}


#pragma mark - 协议
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    ///修复系统bug scrollView的contentOffSet的Y值为－64
    [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, 0)];
    [self dealWithScrollViewScrollToEdge];
    
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    if (page == 0) {
        //当scrollView的第0页时，实际上是显示的最后一页
        pageCtrl.currentPage = self.imageSource.count -1;
    }
    else if (page == imageData.count - 1)
    {
        //当scrollView滚动到最后一页时，实际上显示的是第0页
        pageCtrl.currentPage = 0;
    }
    else
    {
        pageCtrl.currentPage = page - 1;
    }
    
    if (self.LJDelegate && [self.LJDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.LJDelegate scrollViewDidScroll:self];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (goNext) {
        if (self.contentOffset.x > (self.contentSize.width - 2* self.frame.size.width)) {
            [self setContentOffset:CGPointMake(CGRectGetWidth(self.frame), 0) animated:NO];
        }
    }
    
    if (self.LJDelegate && [self.LJDelegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)]) {
        [self.LJDelegate scrollViewDidEndScrollingAnimation:self];
    }
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    if (self.LJDelegate && [self.LJDelegate respondsToSelector:@selector(scrollViewDidZoom:)]) {
        [self.LJDelegate scrollViewDidZoom:self];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.LJDelegate && [self.LJDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [self.LJDelegate scrollViewWillBeginDragging:self];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (self.LJDelegate && [self.LJDelegate respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)]) {
        [self.LJDelegate scrollViewWillEndDragging:self withVelocity:velocity targetContentOffset:targetContentOffset];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.LJDelegate && [self.LJDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [self.LJDelegate scrollViewDidEndDragging:self willDecelerate:decelerate];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if (self.LJDelegate && [self.LJDelegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]) {
        [self.LJDelegate scrollViewWillBeginDecelerating:self];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.LJDelegate && [self.LJDelegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [self.LJDelegate scrollViewDidEndDecelerating:self];
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    if (self.LJDelegate && [self.LJDelegate respondsToSelector:@selector(viewForZoomingInScrollView:)]) {
        return [self.LJDelegate viewForZoomingInScrollView:self];
    }
    return nil;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
    if (self.LJDelegate && [self.LJDelegate respondsToSelector:@selector(scrollViewWillBeginZooming:withView:)]) {
        [self.LJDelegate scrollViewWillBeginZooming:self withView:view];
    }
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    if (self.LJDelegate && [self.LJDelegate respondsToSelector:@selector(scrollViewDidEndZooming:withView:atScale:)]) {
        [self.LJDelegate scrollViewDidEndZooming:self withView:view atScale:scale];
    }
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    if (self.LJDelegate && [self.LJDelegate respondsToSelector:@selector(scrollViewShouldScrollToTop:)]) {
        return [self.LJDelegate scrollViewShouldScrollToTop:self];
    }
    return NO;
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    if (self.LJDelegate && [self.LJDelegate respondsToSelector:@selector(scrollViewDidScrollToTop:)]) {
        [self.LJDelegate scrollViewDidScrollToTop:self];
    }
}
#pragma mark - support
- (void)dealWithScrollViewScrollToEdge
{
    if (self.contentOffset.x < CGRectGetWidth(self.frame)) {
        [self setContentOffset:CGPointMake((self.imageSource.count+1) * CGRectGetWidth(self.frame), 0) animated:NO];
    }
    else if (self.contentOffset.x > (self.contentSize.width - self.frame.size.width)) {
        [self setContentOffset:CGPointMake(CGRectGetWidth(self.frame), 0) animated:NO];
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

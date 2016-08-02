//
//  LJToast.m
//  TestChart
//
//  Created by JamesLee on 16/7/7.
//  Copyright © 2016年 JamesLee. All rights reserved.
//

#import "LJToast.h"

@implementation LJToast

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)show
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    self.center = CGPointMake(keyWindow.center.x, keyWindow.center.y - 80);
    [keyWindow addSubview:self];
    [keyWindow bringSubviewToFront:self];
    [self showAnimation];
}

+ (LJToast *)makeToast:(NSString *)text
{
    //黄金分割
    CGFloat textLabelWidth = 120.f;
    CGFloat textLabelHeight = 60.f;
    
    LJToast *toast = [[LJToast alloc] initWithFrame:CGRectZero];
    toast.backgroundColor = [UIColor colorWithRed:53.f/255 green:53.f/255 blue:53.f/255 alpha:1.f];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.text = text;
    textLabel.textColor = [UIColor whiteColor];
    textLabel.numberOfLines = 0;
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.lineBreakMode = NSLineBreakByCharWrapping;
    textLabel.font = [UIFont systemFontOfSize:16.f];
    toast.frame = CGRectMake(0, 0, textLabelWidth+60, textLabelHeight+60);
    textLabel.frame = CGRectMake(30, 30, textLabelWidth, textLabelHeight);
    [toast addSubview:textLabel];
    return toast;
}

- (void)remove
{
    if (self) {
        [self removeFromSuperview];
    }
}

- (void)showAnimation
{
    self.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self performSelector:@selector(hideAnimation) withObject:self afterDelay:1.f];
    }];
}

- (void)hideAnimation
{
    self.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished){
        [self remove];
    }];
}
@end

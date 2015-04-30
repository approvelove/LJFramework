//
//  PGToast.m
//
//
//  Created by lad on 12-12-21.
//  Copyright (c) 2012年 archermind. All rights reserved.
//

#import "PGToast.h"
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

#define bottomPadding 50
#define startDisappearSecond 1.0
#define disappeartDurationSecond 0.8
#define kErrMessageSeparated @":"

const CGFloat pgToastTextPadding     = 5;
const CGFloat pgToastLabelWidth      = 200;
const CGFloat pgToastLabelHeight     = 60;

@interface PGToast()

@property (nonatomic, copy) NSString *pgLabelText;
@property (nonatomic, strong) UILabel *pgLabel;

- (id)initWithText:(NSString *)text;    
- (void)deviceOrientationChange;

@end

@implementation PGToast

static UIInterfaceOrientation lastOrientation; 

@synthesize pgLabel;
@synthesize pgLabelText;

- (id)initWithText:(NSString *)text
{

    if (self = [super init])
    {
        self.pgLabelText = text;
         
    }    
    return self;
}


+ (PGToast *)makeToast:(NSString *)text
{
    
    PGToast *pgToast = [[PGToast alloc] initWithText:text];
    return pgToast;
}


- (void)show
{
    if([self.pgLabelText isEqualToString:@""])
    {
        return;
    }
    
    if([self.pgLabel superview] != nil)
    {
        [self.pgLabel removeFromSuperview];
    }
    
    UIFont *font = [UIFont systemFontOfSize:15.f];
    CGSize textSize = [pgLabelText sizeWithFont:font constrainedToSize:CGSizeMake(pgToastLabelWidth, pgToastLabelHeight)];
    
    self.pgLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, textSize.width + 2 * pgToastTextPadding, textSize.height + 2 * pgToastTextPadding+5)];
    self.pgLabel.backgroundColor = [UIColor blackColor];
    self.pgLabel.textColor = [UIColor whiteColor];

    self.pgLabel.numberOfLines = 0;
    self.pgLabel.font = font;
    self.pgLabel.textAlignment = NSTextAlignmentCenter;
    self.pgLabel.text = self.pgLabelText;
    
    [NSTimer scheduledTimerWithTimeInterval:startDisappearSecond target:self selector:@selector(toastDisappear:) userInfo:nil repeats:NO];
    
    UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    
    self.pgLabel.layer.cornerRadius = 5.f;
    self.pgLabel.clipsToBounds = YES;
    [window addSubview:self.pgLabel];
    [self deviceOrientationChange];
}

- (void)deviceOrientationChange
{
    
    UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    CGPoint point = window.center;    
    NSLog(@"point %f, %f", point.x, point.y);
    CGFloat centerX=0, centerY=0;
    CGFloat windowCenterX = window.center.x;
    CGFloat windowCenterY = window.center.y;
    CGFloat windowWidth = window.frame.size.width;
    CGFloat windowHeight = window.frame.size.height;
    
    
    UIInterfaceOrientation currentOrient= [UIApplication
                                           sharedApplication].statusBarOrientation;
    
    if (currentOrient == UIInterfaceOrientationLandscapeRight)
    {
        NSLog(@"right ...");
        CGAffineTransform rotateTransform   = CGAffineTransformMakeRotation(M_PI/2);
        pgLabel.transform = CGAffineTransformConcat(window.transform, rotateTransform);
        centerX = bottomPadding;
        centerY = windowCenterY;
    }
    else if(currentOrient == UIInterfaceOrientationLandscapeLeft)
    {
        NSLog(@"left ...");
        CGAffineTransform rotateTransform;
        if (lastOrientation == UIInterfaceOrientationPortrait) {
            rotateTransform   = CGAffineTransformMakeRotation(-M_PI/2);
        } else {
            rotateTransform   = CGAffineTransformMakeRotation(M_PI/2);
        }
        
        pgLabel.transform = CGAffineTransformConcat(pgLabel.transform, rotateTransform);
        centerX = windowWidth - bottomPadding;
        centerY = windowCenterY;
        
    }
    else if(currentOrient == UIInterfaceOrientationPortraitUpsideDown)
    {
        NSLog(@"down ...");
        lastOrientation = currentOrient;
        pgLabel.transform = CGAffineTransformRotate(window.transform, -M_PI);
        
        centerX = windowCenterX;
        centerY = bottomPadding;
        
    }
    else if(currentOrient == UIInterfaceOrientationPortrait)
    {
        NSLog(@"up ...");
        lastOrientation = currentOrient;
        pgLabel.transform = window.transform;
        centerX = windowCenterX;
        centerY = windowHeight - bottomPadding;
        
    }

    self.pgLabel.center = CGPointMake(centerX, centerY);
}

- (void)toastDisappear:(NSTimer *)timer
{
    [timer invalidate];
    [NSTimer scheduledTimerWithTimeInterval:1/60.0 target:self selector:@selector(startDisappear:) userInfo:nil repeats:YES];
}

- (void)startDisappear:(NSTimer *)timer
{
    static int timeCount = 60 * disappeartDurationSecond;
    if (timeCount >= 0)
    {
        [self.pgLabel setAlpha:timeCount/60.0];
        timeCount--;
    }
    else
    {
        [self.pgLabel removeFromSuperview];
        [timer invalidate];
        timeCount = 60 * disappeartDurationSecond;
    }
}
@end

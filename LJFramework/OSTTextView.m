//
//  OSTTextView.m
//  onestong
//
//  Created by 李健 on 14-4-22.
//  Copyright (c) 2014年 王亮. All rights reserved.
//


static const int PLACEHOLDER_TAG = 10;

#import "OSTTextView.h"


@interface OSTTextView ()
{
    
}
@end

@implementation OSTTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)installPlaceHolder:(NSString *)placeHolder
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(4, 9, 300, 14)];
    label.text = placeHolder;
    label.font = [UIFont systemFontOfSize:14.f];
    label.textColor = [UIColor lightGrayColor];
    label.tag = PLACEHOLDER_TAG;
    label.backgroundColor = [UIColor clearColor];
    [self addSubview:label];
}

- (void)clearPlaceHolder
{
    UILabel *label = (UILabel *)[self viewWithTag:PLACEHOLDER_TAG];
    if (label) {
        [label removeFromSuperview];
        label = nil;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

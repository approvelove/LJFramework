//
//  LJTextView.m
//  JLD
//
//  Created by James Lee on 16/4/28.
//  Copyright © 2016年 James Lee. All rights reserved.
//

#import "LJTextView.h"

static NSInteger PLACEHOLDER_TAG = 10;
static NSInteger limit_textHeight = 10000;

@interface LJTextView ()
{
    NSString *_ljPlaceHolder;
}
@end

@implementation LJTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self];
}

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
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self];
    _ljPlaceHolder = placeHolder;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged) name:UITextViewTextDidChangeNotification object:self];
    UILabel *label = [[UILabel alloc] init];
    label.text = placeHolder;
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:14.f];
    label.lineBreakMode = NSLineBreakByCharWrapping;
    CGSize aSize = [label sizeThatFits:CGSizeMake(CGRectGetWidth(self.frame)-4, limit_textHeight)];
    [label setFrame:CGRectMake(4, 8, CGRectGetWidth(self.frame)-4, aSize.height)];
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

#pragma mark - privite
- (void)textFieldChanged
{
    if (self.text && self.text.length>0) {
        [self clearPlaceHolder];
    } else {
        [self installPlaceHolder:_ljPlaceHolder];
    }
}
@end

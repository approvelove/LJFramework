//
//  OSTImageView.m
//  onestong
//
//  Created by 李健 on 14-4-26.
//  Copyright (c) 2014年 王亮. All rights reserved.
//

#import "OSTImageView.h"
#import "GraphicHelper.h"

@interface OSTImageView()
{
    PhotoImageViewClicked photoImageViewClicked;
}
@end


@implementation OSTImageView
@synthesize imageSetted,mapInfoAry,imageName;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.mapInfoAry = [NSMutableArray array];
    }
    return self;
}

- (void)registTapGestureShowImage
{
    //刚刚注册了手势
    self.imageSetted = NO;
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tapGesture];
}

- (void)tap:(UIGestureRecognizer *)gesture
{
    if (photoImageViewClicked) {
        photoImageViewClicked(self);
    }
    if (self.imageSetted == NO) {
        //第一次  选择视图
        [[NSNotificationCenter defaultCenter] postNotificationName:OSTIMAGEVIEW_PICKIMAGE_NOTIFICATION object:nil userInfo:@{@"obj":self}];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:OSTIMAGEVIEW_SHOWIMAGE_NOTIFICATION object:nil userInfo:@{@"obj":self}];
    }
}

//对图片尺寸进行压缩--
+(NSData*)compressImage:(UIImage*)image
{
    CGSize imagesize = image.size;
    float maxH = [[UIApplication sharedApplication] keyWindow].frame.size.height;
    float maxW = [[UIApplication sharedApplication] keyWindow].frame.size.width;
    
    if (imagesize.height>maxH) {
        imagesize.width = (imagesize.width/imagesize.height)*maxH;
        imagesize.height = maxH;
    }
    if (imagesize.width>maxW) {
        imagesize.height = imagesize.height*(maxW/imagesize.width);
        imagesize.width = maxW;
    }
    
    //对图片大小进行压缩--
    image = [GraphicHelper imageWithImage:image scaledToSize:imagesize];
    return UIImageJPEGRepresentation(image, 0.05f);
}

- (void)photoimageViewClicked:(PhotoImageViewClicked)aBlock
{
    photoImageViewClicked = aBlock;
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

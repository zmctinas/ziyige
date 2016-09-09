//
//  imageDisplayView.m
//  ziyige
//
//  Created by daimangkeji on 16/6/22.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "imageDisplayView.h"
#import "SDWebImageDownloader.h"

@implementation imageDisplayView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame andImageUrl:(NSString*)imageUrl
{
    self = [self initWithFrame:frame];
    
    __block UIImage* showImage = [UIImage imageNamed:@"1024"];
    UIImageView* backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH)];
    backImageView.image = showImage;
//    backImageView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:backImageView];
    
    UIBlurEffect* blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView* blurView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    blurView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH);
    [self addSubview:blurView];
    
    UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH)];
    imageView.image = showImage;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.userInteractionEnabled = YES;
    imageView.tag = self.tag;
    [self addSubview:imageView];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchImage:)];
    [imageView addGestureRecognizer:tap];
    
    [[SDWebImageDownloader sharedDownloader]downloadImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@%@",IMAGE_BASEURL,lujing,zhongtu,imageUrl]] options:SDWebImageDownloaderLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
//        showImage = image;
        if (finished) {
            backImageView.image = image;
            imageView.image = image;
        }
    }];
    
    return self;
}

-(void)touchImage:(UITapGestureRecognizer*)tap
{
    [[NSNotificationCenter defaultCenter]postNotificationName:IMAGE_DETAIL_NOTIFICATION object:[NSNumber numberWithInteger:self.tag - 100]];
}

@end

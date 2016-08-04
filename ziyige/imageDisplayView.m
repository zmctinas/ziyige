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
    
    [self addSubview:imageView];
    
    [[SDWebImageDownloader sharedDownloader]downloadImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_BASEURL,imageUrl]] options:SDWebImageDownloaderLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
//        showImage = image;
        if (finished) {
            backImageView.image = image;
            imageView.image = image;
        }
    }];
    
    return self;
}

@end

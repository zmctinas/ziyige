//
//  imageShowViewController.m
//  ziyige
//
//  Created by daimangkeji on 16/8/17.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "imageShowViewController.h"

@interface imageShowViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;



@end

@implementation imageShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[[[UIApplication sharedApplication] keyWindow] rootViewController]setNeedsStatusBarAppearanceUpdate];
    
    
//    [[UIStatusBar alloc]init];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController*)childViewControllerForStatusBarHidden{
    return self;
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

-(void)viewDidAppear:(BOOL)animated
{
    [self showImage];
}

-(void)showImage
{
    for (int i = 0; i < self.imageSource.count; i++) {
        NSString* imageUrl = self.imageSource[i];
        UIScrollView* imgScr = [[UIScrollView alloc]initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//        imgScr.zoomScale = 3;
        
        imgScr.minimumZoomScale = 1;
        imgScr.maximumZoomScale = 3;
//        imgScr.bouncesZoom = YES;
        imgScr.userInteractionEnabled = YES;
        imgScr.delegate = self;
        imgScr.backgroundColor = [UIColor clearColor];
        [self.scrollView addSubview:imgScr];
        
        UITapGestureRecognizer* tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchScrollView:)];
        [imgScr addGestureRecognizer:tap1];
        
        UIImageView* image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        image.contentMode = UIViewContentModeScaleAspectFit;
//        image.contentScaleFactor = 3;
        
        [imgScr addSubview:image];
        [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@%@",IMAGE_BASEURL,lujing,origin,imageUrl]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
    }
    [self.scrollView setContentSize:CGSizeMake(SCREEN_WIDTH*self.imageSource.count, 0)];
    [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH*self.index.integerValue, 0)];
}

-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return scrollView.subviews[0];
}

-(void)touchScrollView:(UITapGestureRecognizer*)tap
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end

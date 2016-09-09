//
//  ViewController.m
//  父子控制器
//
//  Created by 戴川 on 16/6/3.
//  Copyright © 2016年 戴川. All rights reserved.
//

#import "DCNavTabBarController.h"

#define DCScreenW    [UIScreen mainScreen].bounds.size.width
#define DCScreenH    [UIScreen mainScreen].bounds.size.height

@interface DCNavTabBarController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIButton *oldBtn;
@property(nonatomic,strong)NSArray *VCArr;
@property (nonatomic, weak) UIScrollView *contentView;
@property (nonatomic, weak) UIScrollView *topBar;
@property(nonatomic,assign) CGFloat btnW ;

@property (nonatomic, weak) UIView *slider;

@end

@implementation DCNavTabBarController
-(UIColor *)sliderColor
{
    if(_sliderColor == nil)
    {
        _sliderColor = [UIColor clearColor];
    }
    return  _sliderColor;
}
-(UIColor *)btnTextNomalColor
{
    if(_btnTextNomalColor == nil)
    {
        _btnTextNomalColor = [UIColor blackColor];
    }
    return _btnTextNomalColor;
}
-(UIColor *)btnTextSeletedColor
{
    if(_btnTextSeletedColor == nil)
    {
        _btnTextSeletedColor = [UIColor blackColor];
    }
    return _btnTextSeletedColor;
}
-(UIColor *)topBarColor
{
    if(_topBarColor == nil)
    {
        _topBarColor = [UIColor clearColor];
    }
    return _topBarColor;
}
-(instancetype)initWithSubViewControllers:(NSArray *)subViewControllers
{
    if(self = [super init])
    {
        _VCArr = subViewControllers;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加上面的导航条
    [self addTopBar];
    
    //添加子控制器
    [self addVCView];
    
    //添加滑块
    [self addSliderView];
    
    [self addBottomLine];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

-(void)addBottomLine
{
    UIImageView* view1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.topBar.frame)-2, CGRectGetWidth(self.topBar.frame), 2)];
    view1.contentMode = UIViewContentModeScaleAspectFit;
    view1.image = [UIImage imageNamed:@"icon_line"];
    [self.view addSubview:view1];
    UIImageView* view = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.topBar.frame), 2)];
    view.contentMode = UIViewContentModeScaleAspectFit;
    view.image = [UIImage imageNamed:@"icon_line"];
    [self.view addSubview:view];
}

-(void)addSliderView
{
    if(self.VCArr.count == 0) return;

    UIView *slider = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetHeight(self.topBar.frame)-3,self.btnW, 3)];
    slider.backgroundColor = self.sliderColor;
    [self.topBar addSubview:slider];
    self.slider = slider;
}
-(void)addTopBar
{
    if(self.VCArr.count == 0) return;
    NSUInteger count = self.VCArr.count;
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, DCScreenW, 44)];
    scrollView.backgroundColor = self.topBarColor;
    self.topBar = scrollView;
    self.topBar.bounces = NO;
    [self.view addSubview:self.topBar];
    
    if(count <= 5)
    {
         self.btnW = DCScreenW / count;
    }else
    {
         self.btnW = DCScreenW / 5.0;
    }
    //添加button
    for (int i=0; i<count; i++)
    {
        UIViewController *vc = self.VCArr[i];
        
        UIButton * btn = [UIButton buttonWithType:0];
        btn.frame = CGRectMake(i*self.btnW, 0, self.btnW, 44);
        
        btn.tag = 10000+i;
        
        UIImageView* btnBlackImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 4, CGRectGetWidth(btn.frame), CGRectGetHeight(btn.frame)-8)];
        btnBlackImage.tag = 299;
        btnBlackImage.contentMode = UIViewContentModeScaleAspectFit;
        
        [btn setTitle:vc.title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [btn addSubview:btnBlackImage];
        [btn sendSubviewToBack:btnBlackImage];
        btn.backgroundColor = [UIColor clearColor];
        [self.topBar addSubview:btn];
        if(i == 0)
        {
            btn.selected = YES;
            self.oldBtn = btn;
            UIImage * image = [UIImage imageNamed:@"icon_btn_menu"];
            UIImageView* imageView = (UIImageView*)[self.oldBtn viewWithTag:299];
            imageView.image = image;
        }
    }
    self.topBar.contentSize = CGSizeMake(self.btnW *count, -64);
}

-(void)addVCView
{
    self.view.backgroundColor = [UIColor clearColor];
    UIScrollView *contentView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0+44, DCScreenW, DCScreenH -44)];
    self.contentView = contentView;
    self.contentView.bounces = NO;
    contentView.delegate = self;
    contentView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:contentView];
    
    NSUInteger count = self.VCArr.count;
    for (int i=0; i<count; i++) {
        UIViewController *vc = self.VCArr[i];
        [self addChildViewController:vc];
        vc.view.frame = CGRectMake(i*DCScreenW, 0, DCScreenW, DCScreenH -44);
        [contentView addSubview:vc.view];
        vc.view.backgroundColor = [UIColor clearColor];
    }
    contentView.contentSize = CGSizeMake(count*DCScreenW, DCScreenH-44);
    contentView.pagingEnabled = YES;
}

-(void)click:(UIButton *)sender
{
    if(sender.selected) return;
    self.oldBtn.selected = NO;
    sender.selected = YES;
    
    UIImageView* oldimageView = (UIImageView*)[self.oldBtn viewWithTag:299];
    oldimageView.image = [UIImage imageNamed:@"icon_avator_default"];
    UIImage * image = [UIImage imageNamed:@"icon_btn_menu"];
    UIImageView* imageView = (UIImageView*)[sender viewWithTag:299];
    imageView.image = image;
    self.contentView.contentOffset = CGPointMake((sender.tag - 10000)*DCScreenW, 0);
    
//    [UIView animateWithDuration:0.3 animations:^{
//        sender.transform = CGAffineTransformMakeScale(1.2, 1.2);
//    }];
//    self.oldBtn.transform = CGAffineTransformIdentity;
    self.oldBtn = sender;
    
    //判断导航条是否需要移动
    CGFloat maxX = CGRectGetMaxX(self.slider.frame);
    if(maxX >=DCScreenW  && sender.tag != self.VCArr.count + 10000 - 1)
    {
        [UIView animateWithDuration:0.3 animations:^{
            self.topBar.contentOffset = CGPointMake(maxX - DCScreenW + self.btnW, 0);
        }];
    }else if(maxX < DCScreenW)
    {
        [UIView animateWithDuration:0.3 animations:^{
            self.topBar.contentOffset = CGPointMake(0, 0);
        }];
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //滑动导航条
    self.slider.frame = CGRectMake(scrollView.contentOffset.x / DCScreenW *self.btnW , CGRectGetHeight(self.topBar.frame)-3, self.btnW, 3);
}
//判断是否切换导航条按钮的状态
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offX =  scrollView.contentOffset.x;
    int tag = (int)(offX /DCScreenW + 0.5) + 10000;
    UIButton *btn = [self.view viewWithTag:tag];
    if(tag != self.oldBtn.tag)
    {
        [self click:btn];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

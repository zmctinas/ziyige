//
//  saleAlertViewController.m
//  ziyige
//
//  Created by daimangkeji on 16/6/16.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "saleAlertViewController.h"

@interface saleAlertViewController ()

@property (weak, nonatomic) IBOutlet UIView *saleAlertView;

- (IBAction)okBtn:(UIButton *)sender;

@end

@implementation saleAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self addAnimotion];
}

-(void)setUI
{
    self.saleAlertView.layer.masksToBounds = YES;
    self.saleAlertView.layer.cornerRadius = 5;
}

-(void)addAnimotion
{
    // 设定为缩放
    //    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    CAKeyframeAnimation* animation1 = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation1.delegate = self;
    //    animation.delegate = self;
    
    animation1.duration = 0.5;
    
    animation1.keyTimes = @[
                            [NSNumber numberWithFloat:0.0],
                            [NSNumber numberWithFloat:0.7],
                            [NSNumber numberWithFloat:1.0],
                            ];
    animation1.values = @[
                          [NSNumber numberWithFloat:0.3],
                          [NSNumber numberWithFloat:1.3],
                          [NSNumber numberWithFloat:1.0],
                          ];
    
    //    // 动画选项设定
    //    animation.duration = 5; // 动画持续时间
    //    animation.repeatCount = 1; // 重复次数
    //    animation.autoreverses = YES; // 动画结束时执行逆动画
    //
    // 缩放倍数
    //    animation.fromValue = [NSNumber numberWithFloat:0.3]; // 开始时的倍率
    //    animation.byValue = [NSNumber numberWithFloat:1.2];
    //    animation.toValue = [NSNumber numberWithFloat:1.0]; // 结束时的倍率
    
    // 添加动画
    [_saleAlertView.layer addAnimation:animation1 forKey:@"scale-layer"];
}



- (IBAction)okBtn:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
@end

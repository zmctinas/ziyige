//
//  moneyViewController.m
//  ziyige
//
//  Created by daimangkeji on 16/8/3.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "moneyViewController.h"
#import "moneyAlertViewController.h"
#import "withDrawlViewController.h"

@interface moneyViewController ()<alertProtocol>

@property(strong,nonatomic)UIBarButtonItem* rightItem;

@end

@implementation moneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"金额";
    
    self.navigationItem.rightBarButtonItem = self.rightItem;
    
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter

-(void)makeSureBtn
{
    withDrawlViewController* with = [[withDrawlViewController alloc]init];
    [self.navigationController pushViewController:with animated:YES];
}

-(UIBarButtonItem*)rightItem
{
    if (!_rightItem) {
        UIButton* btn = [UIButton buttonWithType:0];
        btn.frame = CGRectMake(0, 0, 40, 30);
        [btn setTitleColor:[UIColor colorWithHexString:@"#1d252e"] forState:UIControlStateNormal];
        [btn setTitle:@"提现" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn addTarget:self action:@selector(withDrawBtn:) forControlEvents:UIControlEventTouchUpInside];
        _rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    }
    return _rightItem;
}

#pragma mark - private

-(void)withDrawBtn:(UIButton*)btn
{
    moneyAlertViewController* alert = [[moneyAlertViewController alloc]init];
    alert.delegate = self;
    alert.modalPresentationStyle = UIModalPresentationOverFullScreen;
    alert.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

@end

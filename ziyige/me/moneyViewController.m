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
#import "moneyModel.h"
#import "moneyEntity.h"
#import "withRecordViewController.h"

@interface moneyViewController ()<alertProtocol>

@property(strong,nonatomic)UIBarButtonItem* rightItem;
@property(strong,nonatomic)moneyModel* model;
@property(strong,nonatomic)moneyEntity* entity;
//@property(strong,nonatomic)UIBarButtonItem* rightItem;
@property (weak, nonatomic) IBOutlet UILabel *balaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *cashLabel;
- (IBAction)tixianBtn:(UIButton *)sender;


@end

@implementation moneyViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"金额";
    
    self.navigationItem.rightBarButtonItem = self.rightItem;
    
    [self.model getUserMoney];
    
    [self addObserverForNotifications:@[GET_MONEY_INDEX_NOTIFICATION]];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter
-(UIBarButtonItem*)rightItem
{
    if (!_rightItem) {
        UIButton* btn = [UIButton buttonWithType:0];
        btn.frame = CGRectMake(0, 0, 80, 30);
        [btn setTitleColor:[UIColor colorWithHexString:@"#1d252e"] forState:UIControlStateNormal];
        [btn setTitle:@"提现记录" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn addTarget:self action:@selector(recordBtn:) forControlEvents:UIControlEventTouchUpInside];
        _rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    }
    return  _rightItem;
}

-(void)recordBtn:(UIButton*)sender
{
    withRecordViewController* with = [[withRecordViewController alloc]init];
    [self.navigationController pushViewController:with animated:YES];
}

-(moneyModel*)model
{
    if (!_model) {
        _model = [[moneyModel alloc]init];
    }
    return _model;
}

-(void)makeSureBtn
{
    withDrawlViewController* with = [[withDrawlViewController alloc]init];
    with.remainderMoney = self.entity.cash;
    [self.navigationController pushViewController:with animated:YES];
}

//-(UIBarButtonItem*)rightItem
//{
//    if (!_rightItem) {
//        UIButton* btn = [UIButton buttonWithType:0];
//        btn.frame = CGRectMake(0, 0, 40, 30);
//        [btn setTitleColor:[UIColor colorWithHexString:@"#1d252e"] forState:UIControlStateNormal];
//        [btn setTitle:@"提现" forState:UIControlStateNormal];
//        btn.titleLabel.font = [UIFont systemFontOfSize:16];
//        [btn addTarget:self action:@selector(withDrawBtn:) forControlEvents:UIControlEventTouchUpInside];
//        _rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
//    }
//    return _rightItem;
//}

#pragma mark - private

-(void)receivedNotification:(NSNotification *)notification
{
    if ([notification.name isEqualToString:GET_MONEY_INDEX_NOTIFICATION]) {
        self.entity = (moneyEntity*)notification.object;
        [self setUpUI];
    }
}

-(void)setUpUI
{
    self.balaceLabel.text = [NSString stringWithFormat:@"%@元",self.entity.balance];
    self.cashLabel.text = [NSString stringWithFormat:@"%@元",self.entity.cash];
}

-(void)withDrawBtn:(UIButton*)btn
{
    moneyAlertViewController* alert = [[moneyAlertViewController alloc]init];
    alert.delegate = self;
    alert.modalPresentationStyle = UIModalPresentationOverFullScreen;
    alert.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

- (IBAction)tixianBtn:(UIButton *)sender {
    
    [self withDrawBtn:nil];
    
}
@end

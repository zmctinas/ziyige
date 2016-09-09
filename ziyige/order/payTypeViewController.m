//
//  payTypeViewController.m
//  ziyige
//
//  Created by daimangkeji on 16/8/18.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "payTypeViewController.h"
#import "buyRecordViewController.h"


@interface payTypeViewController ()
{
    NSInteger selectIndex;
}

- (IBAction)typeBtn:(UIButton *)sender;
- (IBAction)payTypeBtn:(UIButton *)sender;
- (IBAction)nextBtn:(UIButton *)sender;


@end

@implementation payTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    selectIndex = 20;
    
    self.title = @"支付方式";
    
    [self addObserverForNotifications:@[CREATE_PAY_TYPE_ORDER_NOTIFICATION]];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)receivedNotification:(NSNotification *)notification
{
    if ([notification.name isEqualToString:CREATE_PAY_TYPE_ORDER_NOTIFICATION]) {
        NSLog(@"%@",notification.object);
        
        NSDictionary* dic = (NSDictionary*)notification.object;
        
        if (selectIndex == 20) {
            [alipayObject alipay:[self.messageDic[@"total_fee"] floatValue] order:self.messageDic[@"out_trade_no"] block:^(NSDictionary *dic) {
                NSLog(@"%@",dic);
                if ([dic[@"resultStatus"] isEqualToString:@"9000"]) {
                    //                [self showTips];
                    [self jumpViewController];
                }else
                {
                    //                [self cancelOrder:out_trade_no];
                }
            }];
            
        }else{
            NSLog(@"%@",dic);
            [weixinObject weixinPay:1 order:dic[@"out_trade_no"] prepay:[NSMutableDictionary dictionaryWithDictionary:dic] block:^(BOOL payRet) {
                if (payRet) {
                    //                [self showTips];
                    [self jumpViewController];
                }else
                {
                    //                [self cancelOrder:out_trade_no];
                }
            }];
        }
        
    }
}

- (IBAction)typeBtn:(UIButton *)sender {
    
    UIButton* btn = (UIButton*)[self.view viewWithTag:sender.tag + 10];
    [self payTypeBtn:btn];
    
}

- (IBAction)payTypeBtn:(UIButton *)sender {
    
    sender.selected = YES;
    selectIndex = sender.tag;
    
    for (int i = 0 ; i<2; i++) {
        if (sender.tag != i+20) {
            UIButton* btn = (UIButton*)[self.view viewWithTag:i+20];
            btn.selected = NO;
        }
    }
    
}

- (IBAction)nextBtn:(UIButton *)sender {
    
    if (selectIndex == 20) {
//        NSLog(@"%@",self.messageDic)
        [self.model createPayTypeOrder:self.messageDic[@"out_trade_no"] payMent:@"aliwap"];
    }else
    {
        [self.model createPayTypeOrder:self.messageDic[@"out_trade_no"] payMent:@"wechat"];
        
    }
    
}

-(void)jumpViewController
{
    buyRecordViewController* record = [[buyRecordViewController alloc]init];
    record.isRootPush = YES;
    [self.navigationController pushViewController:record animated:YES];
}
@end

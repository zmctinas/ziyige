//
//  myCountViewController.m
//  ziyige
//
//  Created by daimangkeji on 16/6/13.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "myCountViewController.h"
#import "buyRecordViewController.h"
#import "salerRecordViewController.h"
#import "collectViewController.h"
#import "moneyViewController.h"


@interface myCountViewController ()

@property(strong,nonatomic)UIBarButtonItem* rightItem;



- (IBAction)collectBtn:(UIButton *)sender;
- (IBAction)buyRecordBtn:(UIButton *)sender;
- (IBAction)saleRecordBtn:(UIButton *)sender;
- (IBAction)moneyBtn:(UIButton *)sender;


@end

@implementation myCountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单";
    
//    self.navigationItem.rightBarButtonItem = self.rightItem;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    self.tabBarController.tabBar.hidden = YES;
//}
//
//-(void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    self.tabBarController.tabBar.hidden = NO;
//}

#pragma mark - getter

-(UIBarButtonItem*)rightItem
{
    if (!_rightItem) {
        UIButton* btn = [UIButton buttonWithType:0];
        btn.frame = CGRectMake(0, 0, 40, 25);
        [btn setTitle:@"提现" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(touchRightBtn:) forControlEvents:UIControlEventTouchUpInside];
        _rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    }
    return _rightItem;
}



#pragma mark - xib

- (IBAction)collectBtn:(UIButton *)sender {
    
    collectViewController* collect = [[collectViewController alloc]init];
    [self.navigationController pushViewController:collect animated:YES];
    
    
}

- (IBAction)buyRecordBtn:(UIButton *)sender {
    
    buyRecordViewController* buyRecord = [[buyRecordViewController alloc]init];
    [self.navigationController pushViewController:buyRecord animated:YES];
    
}

- (IBAction)saleRecordBtn:(UIButton *)sender {
    
    salerRecordViewController* sale = [[salerRecordViewController alloc]init];
    [self.navigationController pushViewController:sale animated:YES];
    
}

- (IBAction)moneyBtn:(UIButton *)sender {
    
    moneyViewController* money = [[moneyViewController alloc]init];
    [self.navigationController pushViewController:money animated:YES];
    
}

#pragma mark - privete

-(void)touchRightBtn:(UIButton*)sender
{
    NSLog(@"点击提现");
}


@end

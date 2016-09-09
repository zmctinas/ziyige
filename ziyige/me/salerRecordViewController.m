//
//  salerRecordViewController.m
//  ziyige
//
//  Created by daimangkeji on 16/6/16.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "salerRecordViewController.h"
#import "buyRecordTableViewCell.h"
#import "saleAlertViewController.h"
#import "orderDetailViewController.h"

@interface salerRecordViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


- (IBAction)selectStatusBtn:(UIButton *)sender;

@end

@implementation salerRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"回购记录";
    self.headerIndex = 6;
    
    [self registerCell];
    
    _tableView.estimatedRowHeight = 180;
    
    [self addObserverForNotifications:@[GET_ORDER_LIST_NOTIFICATION,@"touchTypeBtn"]];
    
    [self.model getTradeList:@"5"];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter

-(orderModel*)model
{
    if (!_model) {
        _model = [[orderModel alloc]init];
    }
    return _model;
}

#pragma mark - private

-(void)receivedNotification:(NSNotification *)notification
{
    if ([notification.name isEqualToString:GET_ORDER_LIST_NOTIFICATION]) {
        [_tableView reloadData];
    }
}

-(void)registerCell
{
    UINib* nib = [UINib nibWithNibName:@"buyRecordTableViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"unsaleCell"];
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.dataSource.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    buyRecordTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"unsaleCell" forIndexPath:indexPath];
    
    cell.entity = self.model.dataSource[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    orderDetailViewController* detail = [[orderDetailViewController alloc]init];
    orderEntity* entity = self.model.dataSource[indexPath.row];
    detail.trade_no = entity.out_trade_no;
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - xib

- (IBAction)selectStatusBtn:(UIButton *)sender {
    
    sender.selected = YES;
    self.headerIndex = sender.tag - 10;
    
    for (int i = 0; i < 2; i++) {
        UIButton* btn = (UIButton*)[self.view viewWithTag:15+i];
        if (btn.tag != sender.tag) {
            btn.selected = NO;
        }
    }
    [self.model getTradeList:[NSString stringWithFormat:@"%ld",self.headerIndex]];
}
@end

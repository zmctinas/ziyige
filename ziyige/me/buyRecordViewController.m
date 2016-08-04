//
//  buyRecordViewController.m
//  ziyige
//
//  Created by daimangkeji on 16/6/16.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "buyRecordViewController.h"
#import "buyRecordTableViewCell.h"
#import "finishedTableViewCell.h"
#import "orderDetailViewController.h"

@interface buyRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray* _tableSource;
    NSInteger typeIndex;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *backView;

- (IBAction)selectstatusBtn:(UIButton *)sender;

@end

@implementation buyRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"购买记录";
    
    [self registerCell];
    _tableView.estimatedRowHeight = 180;
    
    [self.model getTradeList:@"0"];
    
    [self addObserverForNotifications:@[GET_ORDER_LIST_NOTIFICATION,@"touchTypeBtn"]];
    
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
    }else if ([notification.name isEqualToString:@"touchTypeBtn"])
    {
        
    }
}

-(void)registerCell
{
    UINib* nib = [UINib nibWithNibName:@"buyRecordTableViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"unfinishCell"];
    
    UINib* finishNib = [UINib nibWithNibName:@"finishedTableViewCell" bundle:nil];
    [_tableView registerNib:finishNib forCellReuseIdentifier:@"finishCell"];
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.dataSource.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (typeIndex != 6) {
        buyRecordTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"unfinishCell" forIndexPath:indexPath];
        
        cell.entity = self.model.dataSource[indexPath.row];
        
        return cell;
    }else
    {
        buyRecordTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"finishCell" forIndexPath:indexPath];
        
        cell.entity = self.model.dataSource[indexPath.row];
        
        return cell;
    }
    
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

- (IBAction)selectstatusBtn:(UIButton *)sender {
    
    sender.selected = YES;
    
    for (UIButton* btn in self.backView.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            if (btn.tag != sender.tag) {
                btn.selected = NO;
            }
        }
    }
    
    [self.model getTradeList:[NSString stringWithFormat:@"%ld",sender.tag-10]];
    
}
@end

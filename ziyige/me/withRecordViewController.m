//
//  withRecordViewController.m
//  ziyige
//
//  Created by daimangkeji on 16/8/4.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "withRecordViewController.h"
#import "withDrawlTableViewCell.h"
#import "withDrawlModel.h"
#import "withDrawlEntity.h"

@interface withRecordViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray* _tableSource;
}

@property(strong,nonatomic)UIBarButtonItem* leftItem;
@property(strong,nonatomic)withDrawlModel* model;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation withRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"提现记录";
    
    _tableSource = [NSMutableArray array];
    
    [self registercell];
    
    _tableView.tableFooterView = [[UIView alloc]init];
    
    _tableView.estimatedRowHeight = 132;
    
    _tableView.tableFooterView = [[UIView alloc]init];
    
    [self.model getCashList:@"1"];
    
    [self addObserverForNotifications:@[USER_WITHDRAWL_RECORD_NOTIFICATION]];
    
    if (_isRootPush) {
        self.navigationItem.leftBarButtonItem = self.leftItem;
    }
    
    // 上拉加载
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [self.model getCashList:@"1"];
        
    }];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter

-(UIBarButtonItem*)leftItem
{
    
    if (_leftItem == nil) {
        
        UIButton* btn = [UIButton buttonWithType:0];
        btn.frame = CGRectMake(0, 0, 40, 40);
        [btn setImage:[UIImage imageNamed:@"icon_arrowleft"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(gobackBtn:) forControlEvents:UIControlEventTouchUpInside];
        _leftItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    }
    return _leftItem;
}

-(withDrawlModel*)model
{
    if (!_model) {
        _model = [[withDrawlModel alloc]init];
    }
    return _model;
}


#pragma mark - private

-(void)gobackBtn:(UIButton*)button
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)receivedNotification:(NSNotification *)notification
{
    if ([notification.name isEqualToString:USER_WITHDRAWL_RECORD_NOTIFICATION]) {
        if (notification.object) {
            [self.tableView.mj_footer endRefreshing];
        }else
        {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [_tableView reloadData];
    }
}

-(void)registercell
{
    UINib* nib = [UINib nibWithNibName:@"withDrawlTableViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"recordcell"];
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.tableSource.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    withDrawlTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"recordcell" forIndexPath:indexPath];
    
    cell.entity = self.model.tableSource[indexPath.row];
    
    return cell;
}


@end

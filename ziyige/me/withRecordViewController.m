//
//  withRecordViewController.m
//  ziyige
//
//  Created by daimangkeji on 16/8/4.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "withRecordViewController.h"
#import "withDrawlTableViewCell.h"

@interface withRecordViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray* _tableSource;
}

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private

-(void)registercell
{
    UINib* nib = [UINib nibWithNibName:@"withDrawlTableViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"recordcell"];
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    withDrawlTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"recordcell" forIndexPath:indexPath];
    return cell;
}


@end

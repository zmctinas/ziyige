//
//  addressViewController.m
//  ziyige
//
//  Created by daimangkeji on 16/6/24.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "addressViewController.h"
#import "editAddressViewController.h"
#import "addressModel.h"
#import "addressTableViewCell.h"

@interface addressViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)addressModel* model;

@property(strong,nonatomic)UIBarButtonItem* rightItem;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation addressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"收件地址";
    
    self.navigationItem.rightBarButtonItem = self.rightItem;
    [self registercell];
    self.tableView.estimatedRowHeight = 120;
    
    [self addObserverForNotifications:@[GET_AREA_LIST_NOTIFICATION,DEL_AREA_NOTIFICATION,SET_DEFAULT_AREA_NOTIFICATION,START_EDIT_AREA_NOTIFICATION,EDIT_AREA_NOTIFICATION]];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.model getAddressList];
}

#pragma mark - private

-(void)receivedNotification:(NSNotification *)notification
{
    if ([notification.name isEqualToString:GET_AREA_LIST_NOTIFICATION]) {
        [_tableView reloadData];
    }else if ([notification.name isEqualToString:DEL_AREA_NOTIFICATION])
    {
        [self.model getAddressList];
    }else if ([notification.name isEqualToString:SET_DEFAULT_AREA_NOTIFICATION])
    {
//        [self.model getAddressList];
        [self.navigationController popViewControllerAnimated:YES];
    }else if ([notification.name isEqualToString:START_EDIT_AREA_NOTIFICATION])
    {
        editAddressViewController* address = [[editAddressViewController alloc]init];
        address.entity = notification.object;
        
        [self.navigationController pushViewController:address animated:YES];
    }else if ([notification.name isEqualToString:EDIT_AREA_NOTIFICATION])
    {
        
    }
}

-(void)registercell
{
    UINib* nib = [UINib nibWithNibName:@"addressTableViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"addcell"];
}

-(void)touchRightItem:(UIButton*)sender
{
    editAddressViewController* address = [[editAddressViewController alloc]init];
    [self.navigationController pushViewController:address animated:YES];
}

#pragma mark - getter

-(addressModel*)model
{
    if (!_model) {
        _model = [[addressModel alloc]init];
    }
    return _model;
}

-(UIBarButtonItem*)rightItem
{
    if (!_rightItem) {
        UIButton* btn = [UIButton buttonWithType:0];
        btn.frame = CGRectMake(0, 0, 40, 30);
        [btn setTitle:@"新增" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#1d252e"] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn addTarget:self action:@selector(touchRightItem:) forControlEvents:UIControlEventTouchUpInside];
        _rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    }
    return _rightItem;
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.dataSource.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    addressTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"addcell" forIndexPath:indexPath];
    cell.tag = indexPath.row;
    cell.entity = self.model.dataSource[indexPath.row];
    cell.model = self.model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.Omodel.addEntity = self.model.dataSource[indexPath.row];
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TRUE;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    addressEntity* entity = self.model.dataSource[indexPath.row];
    if ([self.Omodel.addEntity.addid isEqualToString:entity.addid]) {
        self.Omodel.addEntity = nil;
    }
    [self.model delAddress:entity.addid];
}

@end

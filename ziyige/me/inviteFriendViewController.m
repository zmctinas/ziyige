//
//  inviteFriendViewController.m
//  ziyige
//
//  Created by daimangkeji on 16/8/4.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "inviteFriendViewController.h"
#import "inviteTableViewCell.h"
#import "inviteModel.h"

@interface inviteFriendViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray* _tableSource;
}
@property(strong,nonatomic)inviteModel* model;
@property (weak, nonatomic) IBOutlet UITableView *tableView;



@end

@implementation inviteFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"邀请记录";
    
    _tableSource = [NSMutableArray array];
    [self registercell];
    _tableView.estimatedRowHeight = 96;
    _tableView.tableFooterView = [[UIView alloc]init];
    
    [self.model getInviteList:self.inviteCode];
    
    [self addObserverForNotifications:@[USER_INVITE_RECORD_NOTIFICATION]];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter

-(inviteModel*)model
{
    if (!_model) {
        _model = [[inviteModel alloc]init];
    }
    return _model;
}


#pragma mark - private

-(void)receivedNotification:(NSNotification *)notification
{
    if ([notification.name isEqualToString:USER_INVITE_RECORD_NOTIFICATION]) {
        [self.tableView reloadData];
    }
}

-(void)registercell
{
    UINib* nib = [UINib nibWithNibName:@"inviteTableViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"invitecell"];
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.tableSource.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    inviteTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"invitecell" forIndexPath:indexPath];
    
    cell.entity = self.model.tableSource[indexPath.row];
    
    return cell;
}

@end

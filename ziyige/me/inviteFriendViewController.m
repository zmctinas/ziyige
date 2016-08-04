//
//  inviteFriendViewController.m
//  ziyige
//
//  Created by daimangkeji on 16/8/4.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "inviteFriendViewController.h"
#import "inviteTableViewCell.h"

@interface inviteFriendViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray* _tableSource;
}

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private

-(void)registercell
{
    UINib* nib = [UINib nibWithNibName:@"inviteTableViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"invitecell"];
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    inviteTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"invitecell" forIndexPath:indexPath];
    return cell;
}

@end

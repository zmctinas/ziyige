//
//  newsViewController.m
//  ziyige
//
//  Created by daimangkeji on 16/6/7.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "newsViewController.h"
#import "newsTableViewCell.h"

@interface newsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray* _tableSource;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation newsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"咨询";
    _tableSource = [NSMutableArray array];
    
    [self registerCell];
    _tableView.estimatedRowHeight = 110;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private

-(void)registerCell
{
    UINib* nib = [UINib nibWithNibName:@"newsTableViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"newCell"];
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    newsTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"newCell" forIndexPath:indexPath];
    
    return cell;
}

@end

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

@interface salerRecordViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


- (IBAction)selectStatusBtn:(UIButton *)sender;

@end

@implementation salerRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"回购记录";
    
    [self registerCell];
    _tableView.estimatedRowHeight = 180;
    
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(touchTypeBtn:) name:@"touchTypeBtn" object:nil];
    
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



-(void)touchTypeBtn:(UIButton*)sender
{
    saleAlertViewController* alert = [[saleAlertViewController alloc]init];
    
    alert.modalPresentationStyle = UIModalPresentationOverFullScreen;
    alert.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

-(void)registerCell
{
    UINib* nib = [UINib nibWithNibName:@"buyRecordTableViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"unsaleCell"];
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    buyRecordTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"unsaleCell" forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - xib

- (IBAction)selectStatusBtn:(UIButton *)sender {
    
    sender.selected = YES;
    
    for (int i = 0; i < 3; i++) {
        UIButton* btn = (UIButton*)[self.view viewWithTag:10+i];
        if (btn.tag != sender.tag) {
            btn.selected = NO;
        }
    }
    
}
@end

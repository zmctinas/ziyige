//
//  goodsDetailViewController.m
//  ziyige
//
//  Created by daimangkeji on 16/6/21.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "goodsDetailViewController.h"
#import "headTableViewCell.h"
#import "middleTableViewCell.h"
#import "bottomTableViewCell.h"
#import "preOrderViewController.h"
#import "middleTwoTableViewCell.h"
#import "ruleViewController.h"
#import "imageShowViewController.h"
#import "inviteShareViewController.h"
#import "loginViewController.h"

@interface goodsDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;


- (IBAction)goBackBtn:(UIButton *)sender;
- (IBAction)collectBtn:(UIButton *)sender;
- (IBAction)goBuyBtn:(UIButton *)sender;
- (IBAction)shareBtn:(UIButton *)sender;


@end

@implementation goodsDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self registerCell];
    
    [self.model getGoodsDetail];
    
    [self addObserverForNotifications:@[GET_DETAIL_NOTIFICATION,ADD_COLLECT_NOTIFICATION,DEL_COLLECT_NOTIFICATION,RULE_DETAIL_NOTIFICATION,IMAGE_DETAIL_NOTIFICATION]];
    
    self.tableView.estimatedRowHeight = 80;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

#pragma mark - private

-(void)receivedNotification:(NSNotification *)notification
{
    if ([notification.name isEqualToString:GET_DETAIL_NOTIFICATION]) {
        [_tableView reloadData];
        detailEntity* entity = [self.model.detailSource firstObject];
        if ([entity.is_collect isEqualToString:@"1"]) {
            self.collectBtn.selected = YES;
        }else
        {
            self.collectBtn.selected = NO;
        }
    }else if([notification.name isEqualToString:ADD_COLLECT_NOTIFICATION])
    {
        self.collectBtn.selected = YES;
    }else if ([notification.name isEqualToString:DEL_COLLECT_NOTIFICATION])
    {
        self.collectBtn.selected = NO;
    }else if ([notification.name isEqualToString:RULE_DETAIL_NOTIFICATION])
    {
        ruleViewController* rule = [[ruleViewController alloc]init];
        [self.navigationController pushViewController:rule animated:YES];
    }else if ([notification.name isEqualToString:IMAGE_DETAIL_NOTIFICATION])
    {
        
        detailEntity* entity = [self.model.detailSource firstObject];
        
        imageShowViewController* image = [[imageShowViewController alloc]init];
        image.imageSource = entity.imageSource;
        image.index = notification.object;
        image.modalPresentationStyle = UIModalPresentationOverFullScreen;
        image.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:image animated:YES completion:^{
            
        }];
    }
}

-(void)registerCell
{
    UINib* head = [UINib nibWithNibName:@"headTableViewCell" bundle:nil];
    [_tableView registerNib:head forCellReuseIdentifier:@"headCell"];
    
    UINib* middle = [UINib nibWithNibName:@"middleTableViewCell" bundle:nil];
    [_tableView registerNib:middle forCellReuseIdentifier:@"middleCell"];
    
    UINib* bottom = [UINib nibWithNibName:@"bottomTableViewCell" bundle:nil];
    [_tableView registerNib:bottom forCellReuseIdentifier:@"bottomCell"];
    
    UINib* middleTwo = [UINib nibWithNibName:@"middleTwoTableViewCell" bundle:nil];
    [_tableView registerNib:middleTwo forCellReuseIdentifier:@"middelTwoCell"];
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.detailSource.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            headTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"headCell" forIndexPath:indexPath];
            cell.entity = self.model.detailSource[indexPath.row];
            return cell;
        }
            break;
        case 1:
        {
            middleTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"middleCell" forIndexPath:indexPath];
            cell.entity = self.model.detailSource[indexPath.row];
            return cell;
        }
            break;
        case 2:
        {
            middleTwoTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"middelTwoCell" forIndexPath:indexPath];
            cell.entity = self.model.detailSource[indexPath.row];
            return cell;
        }
            break;
        case 3:
        {
            bottomTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"bottomCell" forIndexPath:indexPath];
            cell.entity = self.model.detailSource[indexPath.row];
            return cell;
        }
            break;
            
        default:
            break;
    }
    return nil;
}

#pragma mark - xib

- (IBAction)goBackBtn:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)collectBtn:(UIButton *)sender {
    
    if ([ValidationManager isLogin]) {
        
        if (sender.selected) {
            [self.model delCollect];
        }else
        {
            [self.model addCollect];
        }
    }else
    {
        loginViewController* login = [[loginViewController alloc]init];
        login.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:login animated:YES];
    }
    
}

- (IBAction)goBuyBtn:(UIButton *)sender {
    
    if ([ValidationManager isLogin]) {
    
        preOrderViewController* preOrder = [[preOrderViewController alloc]init];
        
        preOrder.model.goodsEntity = self.model.curEntity;
        
        [self.navigationController pushViewController:preOrder animated:YES];
    }else
        {
            loginViewController* login = [[loginViewController alloc]init];
            login.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:login animated:YES];
        }
    
}

- (IBAction)shareBtn:(UIButton *)sender {
    
    inviteShareViewController* alert = [[inviteShareViewController alloc]init];
    
    detailEntity* entity = [self.model.detailSource firstObject];
    alert.yaoqingma = entity.goods_id;
    alert.isDetail = YES;
    alert.modalPresentationStyle = UIModalPresentationOverFullScreen;
    alert.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
}
@end

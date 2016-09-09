//
//  paintingsViewController.m
//  ziyige
//
//  Created by daimangkeji on 16/6/7.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "paintingsViewController.h"
#import "XMHFlowLayout.h"
#import "collectionViewCell.h"
#import "goodsModel.h"
#import "goodsDetailViewController.h"

@interface paintingsViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,XMHFlowLayoutDelegate>
@property(strong,nonatomic)goodsModel* model;

@property (nonnull, strong)XMHFlowLayout *layOut;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@end

@implementation paintingsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _layOut = [[XMHFlowLayout alloc] init];
    _layOut.degelate =self;
    [_collectionView setCollectionViewLayout:_layOut];
    
    [self addObserverForNotifications:@[GOODS_LIST]];
    
    [self registerCell];
    [self refresh];
    
    self.collectionView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [self refresh];
    }];
    self.collectionView.mj_footer = [MJRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Notification
- (void)receivedNotification:(NSNotification *)notification
{
//    [self hideHUD];
    if ([notification.name isEqualToString:GOODS_LIST])
    {
//        [self.tableView.header endRefreshing];
//        [self.tableView.footer endRefreshing];
        [self.collectionView reloadData];
        BOOL noMoreData = [notification.object boolValue];
        if (noMoreData)
        {
//            [self.collectionView.foot noticeNoMoreData];
        }
        return;
    }
}

#pragma mark - getter

-(goodsModel*)model
{
    if (!_model) {
        _model = [[goodsModel alloc]init];
    }
    return _model;
}

#pragma mark - private

-(void)refresh
{
    [self.model getGoodsWithActid:@"1"];
}

-(void)registerCell
{
    UINib* nib = [UINib nibWithNibName:@"collectionViewCell" bundle:nil];
    [_collectionView registerNib:nib forCellWithReuseIdentifier:@"collection"];
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.model.goodsSource.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    collectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collection" forIndexPath:indexPath];
    
    goodsEntity* entity = self.model.goodsSource[indexPath.item];
    cell.Gentity = entity;
    return cell;
}

#pragma mark - UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    goodsDetailViewController* detail = [[goodsDetailViewController alloc]init];
    detail.hidesBottomBarWhenPushed = YES;
    goodsEntity* entity = self.model.goodsSource[indexPath.item];
    self.model.curEntity = entity;
    detail.model = self.model;
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - XMHFlowLayoutDelegate

-(CGFloat)Flow:(XMHFlowLayout *)Flow heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath*)indexPath{
//    Model *model = self.dataArr[indexPath.row];
    goodsEntity* entity = self.model.goodsSource[indexPath.row];
    CGFloat height = width/entity.width.floatValue*entity.height.floatValue;
    entity.exceptHeight = height;
    return  height;
}


@end

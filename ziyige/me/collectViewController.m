//
//  collectViewController.m
//  ziyige
//
//  Created by daimangkeji on 16/7/4.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "collectViewController.h"
#import "goodsModel.h"
#import "XMHFlowLayout.h"
#import "collectionViewCell.h"
#import "goodsDetailViewController.h"

@interface collectViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,XMHFlowLayoutDelegate>

@property(strong,nonatomic)goodsModel* model;
@property (nonnull, strong)XMHFlowLayout *layOut;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation collectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"收藏";
    
    _layOut = [[XMHFlowLayout alloc] init];
    _layOut.degelate =self;
    [_collectionView setCollectionViewLayout:_layOut];
    
    [self addObserverForNotifications:@[GET_COLLECT_LIST_NOTIFICATION]];
    
    [self registerCell];
    
    
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.model getCollectList];
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

-(void)receivedNotification:(NSNotification *)notification
{
    if ([notification.name isEqualToString:GET_COLLECT_LIST_NOTIFICATION]) {
        [_collectionView reloadData];
    }
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
    NSDictionary *attribute = @{NSFontAttributeName : [UIFont systemFontOfSize:14]};
    CGSize retSize = [entity.goods_name boundingRectWithSize:CGSizeMake(SCREEN_WIDTH/2, MAXFLOAT)
                                                     options:
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                                  attributes:attribute
                                                     context:nil].size;
    return  height+retSize.height+20+10;
}

@end

//
//  searchViewController.m
//  ziyige
//
//  Created by daimangkeji on 16/8/4.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "searchViewController.h"
#import "goodsModel.h"
#import "XMHFlowLayout.h"
#import "collectionViewCell.h"
#import "goodsDetailViewController.h"

@interface searchViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,XMHFlowLayoutDelegate,UITextFieldDelegate>
{
    NSInteger type;
    NSString* cost;
}

@property(strong,nonatomic)goodsModel* model;
@property (nonnull, strong)XMHFlowLayout *layOut;
@property(strong,nonatomic)UIView* sortView;
@property(strong,nonatomic)UIView* backView;
@property(strong,nonatomic)UIView* costView;

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIImageView *statusView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UITextField *searchField;

- (IBAction)goBackBtn:(UIButton *)sender;

- (IBAction)sortBtn:(UIButton *)sender;

- (IBAction)shaixuanBtn:(UIButton *)sender;


@end

@implementation searchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    type = 1;
    cost = @"0,max";
    
    _layOut = [[XMHFlowLayout alloc] init];
    _layOut.degelate =self;
    [_collectionView setCollectionViewLayout:_layOut];
    
    [self addObserverForNotifications:@[SEARCH_GOODS_LIST,GET_SEARCH_LIST_NOTIFICATION]];
    
    [self registerCell];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
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
    if ([notification.name isEqualToString:GET_SEARCH_LIST_NOTIFICATION]) {
        
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        //        [self.tableView.header endRefreshing];
        //        [self.tableView.footer endRefreshing];
        [self.collectionView reloadData];
        BOOL noMoreData = [notification.object boolValue];
        if (noMoreData)
        {
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }
            
        
    }
}

-(void)showBackView
{
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    self.backView.backgroundColor = [UIColor blackColor];
    self.backView.alpha = 0.5;
    [self.view addSubview:self.backView];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchBackView:)];
    [self.backView addGestureRecognizer:tap];
    
}

-(void)touchBackView:(UITapGestureRecognizer*)tap
{
//    UIView* view = tap.view;
//    [view removeFromSuperview];
    if (self.sortView) {
        
        [UIView animateWithDuration:0.3 animations:^{
            self.backView.alpha = 0.0;
            self.sortView.frame = CGRectMake(0, self.sortView.frame.origin.y-self.sortView.frame.size.height, self.sortView.frame.size.width, self.sortView.frame.size.height);
        }completion:^(BOOL finished) {
            [self.backView removeFromSuperview];
            [self.sortView removeFromSuperview];
        }];
        
    }
    
    if (self.costView) {
        [UIView animateWithDuration:0.3 animations:^{
            self.backView.alpha = 0.0;
            self.costView.frame = CGRectMake(0, self.costView.frame.origin.y-self.costView.frame.size.height, self.costView.frame.size.width, self.costView.frame.size.height);
        }completion:^(BOOL finished) {
            [self.backView removeFromSuperview];
            [self.costView removeFromSuperview];
        }];
        
    }
}

-(void)showSortView
{
    self.sortView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 56)];
    [self.view addSubview:self.sortView];
    self.sortView.backgroundColor = [UIColor whiteColor];
    UIImageView* imageView = [[UIImageView alloc]initWithFrame:self.sortView.bounds];
    imageView.image = [UIImage imageNamed:@"bg_menu_sort"];
    imageView.contentMode = UIViewContentModeScaleToFill;
    [self.sortView addSubview:imageView];
    NSArray* nameArr = @[@"从低到高",@"从高到低"];
    for (int i = 0 ; i < 2; i++) {
        UIButton* btn = [UIButton buttonWithType:0];
        btn.frame = CGRectMake(i*SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, 56);
        [btn setTitle:nameArr[i] forState:UIControlStateNormal];
        btn.tag = 20 + i;
        [btn setTitleColor:[UIColor colorWithHexString:@"#1d252e"] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.sortView addSubview:btn];
        [btn addTarget:self action:@selector(touchSortBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    [self.view bringSubviewToFront:self.topView];
    [self.view bringSubviewToFront:self.statusView];
    
    CABasicAnimation *animation =
    [CABasicAnimation animationWithKeyPath:@"position"];
    
    animation.duration = 1; // 动画持续时间
    animation.repeatCount = 1; // 不重复
    animation.beginTime = CACurrentMediaTime(); // 2秒后执行
    animation.autoreverses = NO; // 结束后执行逆动画
    animation.speed = 4.0;
    
    // 动画先加速后减速
    animation.timingFunction =
    [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
    
    // 设定动画起始帧和结束帧
    //    animation.fromValue = [NSValue valueWithCGRect:CGRectMake(0, 568*[FrameSize proportionWidth], 320*[FrameSize proportionWidth], 319*[FrameSize proportionWidth])]; // 起始点
    //    animation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 249*[FrameSize proportionWidth], 320*[FrameSize proportionWidth], 319*[FrameSize proportionWidth])]; // 终了点
    
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(_sortView.layer.position.x, _sortView.layer.position.y - _sortView.frame.size.height)];
    animation.toValue = [NSValue valueWithCGPoint:_sortView.layer.position];
    [_sortView.layer addAnimation:animation forKey:@"move-layer"];
    
}

-(void)touchSortBtn:(UIButton*)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        self.backView.alpha = 0.0;
        self.sortView.frame = CGRectMake(0, self.sortView.frame.origin.y-self.sortView.frame.size.height, self.sortView.frame.size.width, self.sortView.frame.size.height);
    }completion:^(BOOL finished) {
        [self.backView removeFromSuperview];
        [self.sortView removeFromSuperview];
    }];
    
    type = sender.tag - 20 + 1;
    [self searchGoods];
}

-(void)showCastView
{
    self.costView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 224)];
    [self.view addSubview:self.costView];
    self.costView.backgroundColor = [UIColor whiteColor];
    UIImageView* imageView = [[UIImageView alloc]initWithFrame:self.costView.bounds];
    imageView.image = [UIImage imageNamed:@"bg_menu_cost"];
    imageView.contentMode = UIViewContentModeScaleToFill;
    [self.costView addSubview:imageView];
    NSArray* nameArr = @[@"一万以下",@"一万到十万",@"十万到三十万",@"三十万以上"];
    for (int i = 0 ; i < 4; i++) {
        UIButton* btn = [UIButton buttonWithType:0];
        btn.frame = CGRectMake(0, i*56, SCREEN_WIDTH, 56);
        [btn setTitle:nameArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#1d252e"] forState:UIControlStateNormal];
        btn.tag = 30 + i;
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.costView addSubview:btn];
        [btn addTarget:self action:@selector(touchCostBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    for (int i = 0 ; i < 3; i++) {
        UIImageView* line = [[UIImageView alloc]initWithFrame:CGRectMake(10, (i+1)*56, SCREEN_WIDTH - 20, 2)];
        line.image = [UIImage imageNamed:@"icon_line"];
        [self.costView addSubview:line];
    }
    
    [self.view bringSubviewToFront:self.topView];
    [self.view bringSubviewToFront:self.statusView];
    
    CABasicAnimation *animation =
    [CABasicAnimation animationWithKeyPath:@"position"];
    
    animation.duration = 1; // 动画持续时间
    animation.repeatCount = 1; // 不重复
    animation.beginTime = CACurrentMediaTime(); // 2秒后执行
    animation.autoreverses = NO; // 结束后执行逆动画
    animation.speed = 4.0;
    
    // 动画先加速后减速
    animation.timingFunction =
    [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
    
    // 设定动画起始帧和结束帧
    //    animation.fromValue = [NSValue valueWithCGRect:CGRectMake(0, 568*[FrameSize proportionWidth], 320*[FrameSize proportionWidth], 319*[FrameSize proportionWidth])]; // 起始点
    //    animation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 249*[FrameSize proportionWidth], 320*[FrameSize proportionWidth], 319*[FrameSize proportionWidth])]; // 终了点
    
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(_costView.layer.position.x, _costView.layer.position.y - _costView.frame.size.height)];
    animation.toValue = [NSValue valueWithCGPoint:_costView.layer.position];
    [_costView.layer addAnimation:animation forKey:@"move-layer"];
}

-(void)touchCostBtn:(UIButton*)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        self.backView.alpha = 0.0;
        self.costView.frame = CGRectMake(0, self.costView.frame.origin.y-self.costView.frame.size.height, self.costView.frame.size.width, self.costView.frame.size.height);
    }completion:^(BOOL finished) {
        [self.backView removeFromSuperview];
        [self.costView removeFromSuperview];
    }];
    
    NSArray* costName = @[@"0,10000",@"10000,100000",@"100000,300000",@"300000,"];
    cost = costName[sender.tag - 30];
    
    [self searchGoods];
}

-(void)registerCell
{
    UINib* nib = [UINib nibWithNibName:@"collectionViewCell" bundle:nil];
    [_collectionView registerNib:nib forCellWithReuseIdentifier:@"collection"];
}
//东西山水
-(void)searchGoods
{
    [self.model searchGoods:self.searchField.text type:[NSString stringWithFormat:@"%ld",type] cost:cost];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [self searchGoods];
    
    [textField resignFirstResponder];
    
    return YES;
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
    NSDictionary *attribute = @{NSFontAttributeName : [UIFont systemFontOfSize:14]};
    goodsEntity* entity = self.model.goodsSource[indexPath.row];
    CGFloat height = width/entity.width.floatValue*entity.height.floatValue;
    entity.exceptHeight = height;
    CGSize retSize = [entity.goods_name boundingRectWithSize:CGSizeMake(SCREEN_WIDTH/2, MAXFLOAT)
                                                     options:
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                                  attributes:attribute
                                                     context:nil].size;
    return  height+retSize.height+20+10;
}

#pragma mark - xib

- (IBAction)goBackBtn:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)sortBtn:(UIButton *)sender {
    
    [self showBackView];
    
    [self showSortView];
}

- (IBAction)shaixuanBtn:(UIButton *)sender {
    
    [self showBackView];
    
    [self showCastView];
}
@end

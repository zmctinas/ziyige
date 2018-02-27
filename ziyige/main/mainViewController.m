//
//  mainViewController.m
//  ziyige
//
//  Created by daimangkeji on 16/6/7.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "mainViewController.h"

#import "paintingsViewController.h"
#import "playthingViewController.h"
#import "potteryViewController.h"
#import "DCNavTabBarController.h"
#import "searchViewController.h"
#import "loginViewController.h"
#import "XMHFlowLayout.h"
#import "collectionViewCell.h"
#import "goodsModel.h"
#import "goodsDetailViewController.h"


#define DCScreenW    [UIScreen mainScreen].bounds.size.width
#define DCScreenH    [UIScreen mainScreen].bounds.size.height

@interface mainViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,XMHFlowLayoutDelegate>

@property(assign,nonatomic)NSInteger btnIndex;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIScrollView *topBar;

@property(strong,nonatomic)goodsModel* model;

@property (nonnull, strong)XMHFlowLayout *layOut;
@property(nonatomic,assign) CGFloat btnW ;
@property (nonatomic, weak) UIButton *oldBtn;

@property(strong,nonatomic)UIBarButtonItem* rightItem;

@end

@implementation mainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"子宜阁";
    
    [self addTopBar];
    _model = nil;
    _layOut = [[XMHFlowLayout alloc] init];
    _layOut.degelate =self;
    [_collectionView setCollectionViewLayout:_layOut];
    self.btnIndex = 1;
    [self registerCell];
    
    [self addObserverForNotifications:@[GOODS_LIST]];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    self.navigationItem.rightBarButtonItem = self.rightItem;
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refresh];
    }];
    
    // 上拉加载
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [self refresh];
        
    }];
    
    self.navigationItem.leftBarButtonItem = nil;
    
    [self.collectionView.mj_header beginRefreshing];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addChilds
{
    NSArray* childArr = @[@"paintings",@"plaything",@"pottery",@"pottery",@"pottery",@"pottery"];
    NSArray* childtitle = @[@"字画",@"文玩",@"瓷器",@"瓷器",@"瓷器",@"瓷器"];
    NSMutableArray* childs = [NSMutableArray array];
    
    for (int i = 0 ; i < childArr.count ; i++) {
        NSString* str = childArr[i];
        NSString* childString = [NSString stringWithFormat:@"%@ViewController",str];
        Class childClass = NSClassFromString(childString);
        UIViewController* childVC = [[childClass alloc]init];
        childVC.title = childtitle[i];
        
        [childs addObject:childVC];
    }
    
    DCNavTabBarController *tabBarVC = [[DCNavTabBarController alloc]initWithSubViewControllers:childs];
    tabBarVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    
    [self.view addSubview:tabBarVC.view];
    [self addChildViewController:tabBarVC];
    
}

-(UIBarButtonItem*)rightItem
{
    if (!_rightItem) {
        UIButton* btn = [UIButton buttonWithType:0];
        btn.frame = CGRectMake(0, 0, 25, 25);
        [btn setTitleColor:[UIColor colorWithHexString:@"#1d252e"] forState:UIControlStateNormal];
//        [btn setTitle:@"提现记录" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn setImage:[UIImage imageNamed:@"icon_search"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(searchBtn:) forControlEvents:UIControlEventTouchUpInside];
        _rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    }
    return  _rightItem;
}

-(void)searchBtn:(UIButton*)sender
{
    searchViewController* search = [[searchViewController alloc]init];
    search.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:search animated:YES];
}

#pragma mark - Notification
- (void)receivedNotification:(NSNotification *)notification
{
    //    [self hideHUD];
    if ([notification.name isEqualToString:GOODS_LIST])
    {
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

#pragma mark - getter

-(goodsModel*)model
{
    if (!_model) {
        _model = [[goodsModel alloc]init];
    }
    return _model;
}

#pragma mark - private

-(void)addTopBar
{
    NSArray* childtitle = @[@"字画",@"文玩",@"瓷器",@"玉器",@"珠宝",@"杂项"];
    if(childtitle.count == 0) return;
    NSUInteger count = childtitle.count;
    
//    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, DCScreenW, 44)];
//    scrollView.backgroundColor = self.topBarColor;
//    self.topBar = scrollView;
//    self.topBar.bounces = NO;
//    [self.view addSubview:self.topBar];
    
    if(count <= 5)
    {
        self.btnW = DCScreenW / count;
    }else
    {
        self.btnW = DCScreenW / 5.0;
    }
    //添加button
    for (int i=0; i<count; i++)
    {
        NSString *vc = childtitle[i];
        
        UIButton * btn = [UIButton buttonWithType:0];
        btn.frame = CGRectMake(i*self.btnW, 0, self.btnW, 44);
        
        btn.tag = 10000+i;
        
        UIImageView* btnBlackImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 4, CGRectGetWidth(btn.frame), CGRectGetHeight(btn.frame)-8)];
        btnBlackImage.tag = 299;
        btnBlackImage.contentMode = UIViewContentModeScaleAspectFit;
        
        [btn setTitle:vc forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [btn addSubview:btnBlackImage];
        [btn sendSubviewToBack:btnBlackImage];
        btn.backgroundColor = [UIColor clearColor];
        [self.topBar addSubview:btn];
        if(i == 0)
        {
            btn.selected = YES;
            self.oldBtn = btn;
            UIImage * image = [UIImage imageNamed:@"icon_btn_menu"];
            UIImageView* imageView = (UIImageView*)[self.oldBtn viewWithTag:299];
            imageView.image = image;
        }
    }
    self.topBar.contentSize = CGSizeMake(self.btnW *count, -64);
}

-(void)click:(UIButton *)sender
{
    if(sender.selected) return;
    self.oldBtn.selected = NO;
    sender.selected = YES;
    self.btnIndex = sender.tag - 10000 + 1;
//
    UIImageView* oldimageView = (UIImageView*)[self.oldBtn viewWithTag:299];
    oldimageView.image = [UIImage imageNamed:@""];
    UIImage * image = [UIImage imageNamed:@"icon_btn_menu"];
    UIImageView* imageView = (UIImageView*)[sender viewWithTag:299];
    imageView.image = image;
//    self.contentView.contentOffset = CGPointMake((sender.tag - 10000)*DCScreenW, 0);
    
//    [UIView animateWithDuration:0.3 animations:^{
//        sender.transform = CGAffineTransformMakeScale(1.2, 1.2);
//    }];
//    self.oldBtn.transform = CGAffineTransformIdentity;
    self.oldBtn = sender;
    
    [self.collectionView.mj_header beginRefreshing];
//
//    //判断导航条是否需要移动
//    CGFloat maxX = CGRectGetMaxX(self.slider.frame);
//    if(maxX >=DCScreenW  && sender.tag != self.VCArr.count + 10000 - 1)
//    {
//        [UIView animateWithDuration:0.3 animations:^{
//            self.topBar.contentOffset = CGPointMake(maxX - DCScreenW + self.btnW, 0);
//        }];
//    }else if(maxX < DCScreenW)
//    {
//        [UIView animateWithDuration:0.3 animations:^{
//            self.topBar.contentOffset = CGPointMake(0, 0);
//        }];
//    }
}

-(void)refresh
{
    [self.model getGoodsWithActid:[NSString stringWithFormat:@"%ld",self.btnIndex]];
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
    
    NSLog(@"%@",entity.goods_price);
    NSLog(@"%@",entity.goods_id);
    NSLog(@"%@",entity.goods_name);
    NSLog(@"%@",entity.thumb_goods_url);
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    if ([ValidationManager isLogin]) {
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

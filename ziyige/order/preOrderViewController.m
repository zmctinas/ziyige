//
//  preOrderViewController.m
//  ziyige
//
//  Created by daimangkeji on 16/6/23.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "preOrderViewController.h"
#import "sendTypeViewController.h"

#import "addressViewController.h"
#import "addressEntity.h"

#import "buyRecordViewController.h"

@interface preOrderViewController ()<sentTypeDelegate>

//@property(strong,nonatomic)addressEntity* entity;

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UIButton *onlineBtn;
@property (weak, nonatomic) IBOutlet UIButton *offlineBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *guigeLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *sendTypeBtn;
@property (weak, nonatomic) IBOutlet UIButton *addressBtn;

- (IBAction)sendTypeBtn:(UIButton*)sender;
- (IBAction)addressBtn:(UIButton *)sender;
- (IBAction)payTypeBtn:(UIButton *)sender;
- (IBAction)addOrderBtn:(UIButton *)sender;

@end

@implementation preOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单确认";
    
    [self.model getDefAddress];
    
    [self changeUI];
    
    [self addObserverForNotifications:@[GET_DEFAULT_AREA_NOTIFICATION,ADD_ORDER_NOTIFICATION]];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setUpUI];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    
}

#pragma mark - private

-(void)receivedNotification:(NSNotification *)notification
{
    if ([notification.name isEqualToString:GET_DEFAULT_AREA_NOTIFICATION]) {
        [self.addressBtn setTitle:[NSString stringWithFormat:@"%@%@%@%@",self.model.addEntity.province,self.model.addEntity.city,self.model.addEntity.district,self.model.addEntity.address] forState:UIControlStateNormal];
    }else if ([notification.name isEqualToString:SELECT_AREA_NOTIFICATION])
    {
        [self.addressBtn setTitle:[NSString stringWithFormat:@"%@%@%@%@",self.model.addEntity.province,self.model.addEntity.city,self.model.addEntity.district,self.model.addEntity.address] forState:UIControlStateNormal];
    }else if ([notification.name isEqualToString:ADD_ORDER_NOTIFICATION])
    {
        buyRecordViewController* buy = [[buyRecordViewController alloc]init];
        [self.navigationController pushViewController:buy animated:YES];
    }
}

-(void)changeUI
{
    [self setUpUI];
    
    [_iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_BASEURL,self.model.goodsEntity.thumb_goods_url]] placeholderImage:[UIImage imageNamed:@"icon_avator_default"]];
    _titleLabel.text = self.model.goodsEntity.goods_name;
    _guigeLabel.text = [NSString stringWithFormat:@"规格:%@",self.model.goodsEntity.specifications];
    _priceLabel.text = [NSString stringWithFormat:@"￥%@",self.model.goodsEntity.goods_price];
}

-(void)setUpUI
{
    [self.sendTypeBtn setTitle:self.model.entity.sendType forState:UIControlStateNormal];
}

#pragma mark - getter

-(orderModel*)model
{
    if (!_model) {
        _model = [[orderModel alloc]init];
    }
    return _model;
}

#pragma Mark - xib

- (IBAction)sendTypeBtn:(id)sender {
    
    sendTypeViewController* alert = [[sendTypeViewController alloc]init];
    alert.entity = self.model.entity;
    alert.delegate = self;
    alert.modalPresentationStyle = UIModalPresentationOverFullScreen;
    alert.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
}

- (IBAction)addressBtn:(UIButton *)sender {
    
    addressViewController* address = [[addressViewController alloc]init];
    
    address.entity = self.model.addEntity;
    
    [self.navigationController pushViewController:address animated:YES];
    
}

- (IBAction)payTypeBtn:(UIButton *)sender {
    
    if (sender.tag == 10) {
        self.onlineBtn.selected = YES;
        self.offlineBtn.selected = NO;
        self.model.entity.pay_ment = @"online";
    }else
    {
        self.onlineBtn.selected = NO;
        self.offlineBtn.selected = YES;
        self.model.entity.pay_ment = @"offline";
    }
    
}

- (IBAction)addOrderBtn:(UIButton *)sender {
    
    self.model.entity.user_id = [UserInfo info].currentUser.userId;
    self.model.entity.goods_id = self.model.goodsEntity.goods_id;
    if ([self.model.entity.distribution isEqualToString:@"express"]) {
        if (self.model.addEntity.addid) {
            self.model.entity.addr_id = self.model.addEntity.addid;
        }else
        {
            [self.view makeToast:@"请选择收货地址"];
            return;
        }
    }
    if (self.textView.text.length>0) {
        self.model.entity.body = self.textView.text;
    }
    [self.model addTrade:self.model.entity];
    
}
@end

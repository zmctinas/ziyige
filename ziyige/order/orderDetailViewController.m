//
//  orderDetailViewController.m
//  ziyige
//
//  Created by daimangkeji on 16/7/6.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "orderDetailViewController.h"
#import "orderModel.h"

@interface orderDetailViewController ()

@property(strong,nonatomic)orderModel* model;


@property (weak, nonatomic) IBOutlet UIButton *addressLabel;

@property (weak, nonatomic) IBOutlet UILabel *paymentLabel;
@property (weak, nonatomic) IBOutlet UIButton *sendTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *trade_noLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *guigeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UITextView *messageLabel;
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;

- (IBAction)finishBtn:(UIButton *)sender;

@end

@implementation orderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单详情";
    
    [self.model getTradeDetail:_trade_no];
    
    
    [self addObserverForNotifications:@[GET_ORDER_DETAIL_NOTIFICATION]];
    
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

-(void)refreshUI
{
    [_addressLabel setTitle:[NSString stringWithFormat:@"%@/%@/%@",self.model.detailEntity.province,self.model.detailEntity.city,self.model.detailEntity.district] forState:UIControlStateNormal];
    _trade_noLabel.text = [NSString stringWithFormat:@"单号：%@",self.model.detailEntity.out_trade_no];
    _timeLabel.text = [NSString stringWithFormat:@"时间：%@",self.model.detailEntity.add_time];
    [_iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_BASEURL,self.model.detailEntity.thumb_goods_url]] placeholderImage:[UIImage imageNamed:@""]];
    _nameLabel.text = self.model.detailEntity.goods_name;
    _guigeLabel.text = self.model.detailEntity.specifications;
    _priceLabel.text = self.model.detailEntity.total_fee;
    _messageLabel.text = self.model.detailEntity.body;
    if ([self.model.detailEntity.pay_ment isEqualToString:@"online"]) {
        _paymentLabel.text = @"在线支付";
    }else
    {
        _paymentLabel.text = @"线下支付";
    }
    
    if ([self.model.detailEntity.distribution isEqualToString:@"express"]) {
        [_sendTypeLabel setTitle:@"卖家配送" forState:UIControlStateNormal];
    }else
    {
        [_sendTypeLabel setTitle:@"自行提取" forState:UIControlStateNormal];
    }
}

-(void)receivedNotification:(NSNotification *)notification
{
    if ([notification.name isEqualToString:GET_ORDER_DETAIL_NOTIFICATION]) {
        [self refreshUI];
    }
}

#pragma mark - xib

- (IBAction)finishBtn:(UIButton *)sender {
}
@end

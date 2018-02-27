//
//  orderDetailViewController.m
//  ziyige
//
//  Created by daimangkeji on 16/7/6.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "orderDetailViewController.h"

#import "payTypeViewController.h"
#import "saleAlertViewController.h"

@interface orderDetailViewController ()




@property (weak, nonatomic) IBOutlet UIButton *addressLabel;


@property (weak, nonatomic) IBOutlet UIButton *sendTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *trade_noLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *guigeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UITextView *messageLabel;
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;
@property (weak, nonatomic) IBOutlet UILabel *hejiLabel;



- (IBAction)finishBtn:(UIButton *)sender;

@end

@implementation orderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单详情";
    
    [self.model getTradeDetail:_trade_no];
    
    
    [self addObserverForNotifications:@[GET_ORDER_DETAIL_NOTIFICATION,CONFIRM_ORDER_NOTIFICATION]];
    
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
    if ([self.model.detailEntity.distribution isEqualToString:@"express"]) {
        [_addressLabel setTitle:[NSString stringWithFormat:@"%@/%@/%@%@",self.model.detailEntity.province,self.model.detailEntity.city,self.model.detailEntity.district,self.model.detailEntity.address] forState:UIControlStateNormal];
    }
    
    _trade_noLabel.text = [NSString stringWithFormat:@"单号：%@",self.model.detailEntity.out_trade_no];
    _timeLabel.text = [NSString stringWithFormat:@"时间：%@",self.model.detailEntity.add_time];

    [_iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@%@",IMAGE_BASEURL,lujing,suolue,self.model.detailEntity.thumb_goods_url]] placeholderImage:[UIImage imageNamed:@"512"]];
    _nameLabel.text = self.model.detailEntity.goods_name;
    _guigeLabel.text = [NSString stringWithFormat:@"规格：%@",self.model.detailEntity.specifications];
    _priceLabel.text = [NSString stringWithFormat:@"￥%@",self.model.detailEntity.total_fee];
    _hejiLabel.text = [NSString stringWithFormat:@"合计：￥%@",self.model.detailEntity.total_fee];;
    _messageLabel.text = self.model.detailEntity.body;
    
    
    if ([self.model.detailEntity.distribution isEqualToString:@"express"]) {
        [_sendTypeLabel setTitle:@"卖家配送" forState:UIControlStateNormal];
    }else
    {
        [_sendTypeLabel setTitle:@"自行提取" forState:UIControlStateNormal];
    }
    
    switch (self.model.detailEntity.status.integerValue) {
        case 0:
        {
            [self.finishBtn setTitle:@"去付款" forState:UIControlStateNormal];
            self.finishBtn.enabled = YES;
        }
            break;
        case 1:
        {
            [self.finishBtn setTitle:@"待发货" forState:UIControlStateNormal];
            self.finishBtn.enabled = NO;
        }
            break;
        case 2:
        {
            [self.finishBtn setTitle:@"待自提" forState:UIControlStateNormal];
            self.finishBtn.enabled = NO;
        }
            break;
        case 3:
        {
            [self.finishBtn setTitle:@"确认收货" forState:UIControlStateNormal];
            self.finishBtn.enabled = YES;
        }
            break;
        case 4:
        {
            [self.finishBtn setTitle:@"申请回购" forState:UIControlStateNormal];
            self.finishBtn.enabled = YES;
        }
            break;
        case 5:
        {
            [self.finishBtn setTitle:@"回购中" forState:UIControlStateNormal];
            self.finishBtn.enabled = NO;
        }
            break;
        case 6:
        {
            [self.finishBtn setTitle:@"回购完成" forState:UIControlStateNormal];
            self.finishBtn.enabled = NO;
        }
            break;
            
        default:
            break;
    }
    
}

-(void)receivedNotification:(NSNotification *)notification
{
    if ([notification.name isEqualToString:GET_ORDER_DETAIL_NOTIFICATION]) {
        [self refreshUI];
    }else if ([notification.name isEqualToString:BUY_BACK_ORDER_NOTIFICATION])
    {
        saleAlertViewController* alert = [[saleAlertViewController alloc]init];
        
        alert.modalPresentationStyle = UIModalPresentationOverFullScreen;
        alert.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:alert animated:YES completion:^{
            
        }];
    }else if ( [notification.name isEqualToString:CONFIRM_ORDER_NOTIFICATION])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - xib

- (IBAction)finishBtn:(UIButton *)sender {
    
    
    if ([sender.currentTitle isEqualToString:@"去付款"]) {
        payTypeViewController* pay = [[payTypeViewController alloc]init];
        
        pay.model = self.model;
        pay.messageDic = @{@"out_trade_no":self.trade_no,@"total_fee":self.model.detailEntity.total_fee};
        
        [self.navigationController pushViewController:pay animated:YES];
    }else if ([sender.currentTitle isEqualToString:@"申请回购"])
    {
        [self.model buyBackOrder:self.model.detailEntity.out_trade_no];
    }else if ([sender.currentTitle isEqualToString:@"确认收货"])
    {
        [self.model comfirmOrder:self.model.detailEntity.out_trade_no];
    }
    
   
        
    
    
}
@end

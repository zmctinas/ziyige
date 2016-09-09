//
//  buyRecordTableViewCell.m
//  ziyige
//
//  Created by daimangkeji on 16/6/16.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "buyRecordTableViewCell.h"
#import "saleAlertViewController.h"

@implementation buyRecordTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setEntity:(goodsEntity *)entity
{
    _entity = entity;
    
    [_iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@%@",IMAGE_BASEURL,lujing,suolue,_entity.thumb_goods_url]] placeholderImage:[UIImage imageNamed:@"1024"]];
//    [_iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_BASEURL,_entity.thumb_goods_url]] placeholderImage:[UIImage imageNamed:@""]];
    _titleLabel.text = _entity.goods_name;
    _priceLabel.text = [NSString stringWithFormat:@"￥%@",_entity.total_fee];
    if (_entity.specifications.length>0) {
        _guigeLabel.text = [NSString stringWithFormat:@"规格：%@",_entity.specifications];
    }else
    {
        _guigeLabel.text = @"";
    }
    _timeLabel.text = _entity.add_time;
    
    _numLabel.text = [NSString stringWithFormat:@"x%@",_entity.amount];
    
    switch (_entity.status.integerValue) {
        case 0:
        {
            [self.statusBtn setTitle:@"去付款" forState:UIControlStateNormal];
            self.statusBtn.enabled = YES;
        }
            break;
        case 1:
        {
            [self.statusBtn setTitle:@"待发货" forState:UIControlStateNormal];
            self.statusBtn.enabled = NO;
        }
            break;
        case 2:
        {
            [self.statusBtn setTitle:@"待自提" forState:UIControlStateNormal];
            self.statusBtn.enabled = NO;
        }
            break;
        case 3:
        {
            [self.statusBtn setTitle:@"确认收货" forState:UIControlStateNormal];
            self.statusBtn.enabled = YES;
        }
            break;
        case 4:
        {
            [self.statusBtn setTitle:@"申请回购" forState:UIControlStateNormal];
            self.statusBtn.enabled = YES;
        }
            break;
        case 5:
        {
            [self.statusBtn setTitle:@"回购中" forState:UIControlStateNormal];
            self.statusBtn.enabled = NO;
        }
            break;
        case 6:
        {
            [self.statusBtn setTitle:@"回购完成" forState:UIControlStateNormal];
            self.statusBtn.enabled = NO;
        }
            break;
            
        default:
            break;
    }
    
    
}

- (IBAction)tyoeBtn:(UIButton *)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"touchTypeBtn" object:@(_entity.status.integerValue)userInfo:@{@"out_trade_no":_entity.out_trade_no}];
    
}
@end

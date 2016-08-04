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
    
    [_iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_BASEURL,_entity.thumb_goods_url]] placeholderImage:[UIImage imageNamed:@""]];
    _titleLabel.text = _entity.goods_name;
    _priceLabel.text = [NSString stringWithFormat:@"￥%@",_entity.goods_price];
    _guigeLabel.text = _entity.specifications;
    
    switch (_entity.status.integerValue) {
        case 0:
        {
            [self.statusBtn setTitle:@"去付款" forState:UIControlStateNormal];
        }
            break;
        case 1:
        {
            [self.statusBtn setTitle:@"备货中" forState:UIControlStateNormal];
        }
            break;
        case 2:
        {
            [self.statusBtn setTitle:@"待自提" forState:UIControlStateNormal];
        }
            break;
        case 3:
        {
            [self.statusBtn setTitle:@"已发货" forState:UIControlStateNormal];
        }
            break;
        case 4:
        {
            [self.statusBtn setTitle:@"去付款" forState:UIControlStateNormal];
        }
            break;
        case 5:
        {
            [self.statusBtn setTitle:@"去付款" forState:UIControlStateNormal];
        }
            break;
        case 6:
        {
            [self.statusBtn setTitle:@"去付款" forState:UIControlStateNormal];
        }
            break;
            
        default:
            break;
    }
    
    
}

- (IBAction)tyoeBtn:(UIButton *)sender {
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"touchTypeBtn" object:nil];
    
}
@end

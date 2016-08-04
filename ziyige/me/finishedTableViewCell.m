//
//  finishedTableViewCell.m
//  ziyige
//
//  Created by daimangkeji on 16/6/16.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "finishedTableViewCell.h"

@implementation finishedTableViewCell

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
    
}

@end

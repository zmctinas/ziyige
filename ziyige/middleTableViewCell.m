//
//  middleTableViewCell.m
//  ziyige
//
//  Created by daimangkeji on 16/6/22.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "middleTableViewCell.h"

@implementation middleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setEntity:(detailEntity *)entity
{
    _entity = entity;
    
    self.nameLabel.text = _entity.goods_name;
    self.priceLabel.text = [NSString stringWithFormat:@"价格：￥%@",_entity.goods_price];
    self.specificationLabel.text = [NSString stringWithFormat:@"规格：%@",_entity.specifications];
    self.marketLabel.text = [NSString stringWithFormat:@"市场参考价：￥%@",entity.market_price];
}

@end

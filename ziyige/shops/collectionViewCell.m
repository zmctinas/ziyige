//
//  collectionViewCell.m
//  ziyige
//
//  Created by daimangkeji on 16/6/20.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "collectionViewCell.h"

@implementation collectionViewCell

-(void)setGentity:(goodsEntity *)Gentity
{
    _Gentity = Gentity;
    
    NSLog(@"%@",[NSString stringWithFormat:@"%@%@",IMAGE_BASEURL,_Gentity.thumb_goods_url]);
    [_iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_BASEURL,_Gentity.thumb_goods_url]] placeholderImage:[UIImage imageNamed:@""]];
    _titleLabel.text = _Gentity.goods_name;
    _priceLabel.text = _Gentity.price;
    
    if (_Gentity.exceptHeight) {
        _imageViewHeight.constant = _Gentity.exceptHeight;
    }
    
}

-(void)setCentity:(collectEntity *)Centity
{
    _Centity = Centity;
    
    [_iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_BASEURL,_Centity.thumb_goods_url]] placeholderImage:[UIImage imageNamed:@""]];
    _titleLabel.text = _Centity.goods_name;
    _priceLabel.text = _Centity.price;
    
    if (_Centity.exceptHeight) {
        _imageViewHeight.constant = _Centity.exceptHeight;
    }
    
    
}


@end

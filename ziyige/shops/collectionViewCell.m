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
    
    [_iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@%@",IMAGE_BASEURL,lujing,suolue,_Gentity.thumb_goods_url]] placeholderImage:[UIImage imageNamed:@"1024"]];
    _titleLabel.text = _Gentity.goods_name;
    _priceLabel.text = _Gentity.price;
    NSLog(@"%@",Gentity.goods_price);
    
    if (_Gentity.exceptHeight) {
        _imageViewHeight.constant = _Gentity.exceptHeight;
    }
    NSDictionary *attribute = @{NSFontAttributeName : [UIFont systemFontOfSize:14]};
    CGSize retSize = [_Gentity.goods_name boundingRectWithSize:CGSizeMake(SCREEN_WIDTH/2, MAXFLOAT)
                                                     options:
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                                  attributes:attribute
                                                     context:nil].size;
    self.labelHeight.constant = retSize.height;
    
    
}

-(void)setCentity:(collectEntity *)Centity
{
    _Centity = Centity;
    
    [_iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_BASEURL,_Centity.thumb_goods_url]] placeholderImage:[UIImage imageNamed:@"icon_avator_default"]];
    _titleLabel.text = _Centity.goods_name;
    _priceLabel.text = _Centity.price;
    
    if (_Centity.exceptHeight) {
        _imageViewHeight.constant = _Centity.exceptHeight;
    }
    NSDictionary *attribute = @{NSFontAttributeName : [UIFont systemFontOfSize:14]};
    CGSize retSize = [_Gentity.goods_name boundingRectWithSize:CGSizeMake(SCREEN_WIDTH/2, MAXFLOAT)
                                                       options:
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                                    attributes:attribute
                                                       context:nil].size;
    self.labelHeight.constant = retSize.height;
    
    
}


@end

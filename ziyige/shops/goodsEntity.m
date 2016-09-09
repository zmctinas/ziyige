//
//  goodsEntity.m
//  ziyige
//
//  Created by daimangkeji on 16/6/20.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "goodsEntity.h"

@implementation goodsEntity

-(NSString*)price
{
    return [NSString stringWithFormat:@"价格：￥%@",self.goods_price];
}

@end

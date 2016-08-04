//
//  collectEntity.m
//  ziyige
//
//  Created by daimangkeji on 16/7/4.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "collectEntity.h"

@implementation collectEntity

-(NSString*)price
{
    return [NSString stringWithFormat:@"估价：￥%@",self.goods_price];
}


@end

//
//  orderEntity.m
//  ziyige
//
//  Created by daimangkeji on 16/6/24.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "orderEntity.h"

@implementation orderEntity

- (instancetype)init
{
    self = [super init];
    if (self) {
        _distribution = @"express";
        _pay_ment = @"online";
    }
    return self;
}

-(NSString*)sendType
{
    if ([_distribution isEqualToString:@"express"]) {
        return @"卖家配送";
    }
    return @"自提提取";
}

@end

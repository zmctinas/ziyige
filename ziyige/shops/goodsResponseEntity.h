//
//  goodsResponseEntity.h
//  ziyige
//
//  Created by daimangkeji on 16/6/20.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "rootEntity.h"

@interface goodsResponseEntity : rootEntity

@property (nonatomic,strong) NSArray *data;
@property (nonatomic) NSInteger pages;

@end

//
//  detailEntity.h
//  ziyige
//
//  Created by daimangkeji on 16/6/22.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "rootEntity.h"

@interface detailEntity : rootEntity

@property(copy,nonatomic)NSString* desc;
@property(copy,nonatomic)NSString* goods_name;
@property(copy,nonatomic)NSString* is_collect;
@property(copy,nonatomic)NSString* specifications;
@property(copy,nonatomic)NSString* stock;
@property(copy,nonatomic)NSString* goods_id;
@property(copy,nonatomic)NSString* act_id;
@property(copy,nonatomic)NSString* add_time;
@property(copy,nonatomic)NSString* goods_price;

@property(strong,nonatomic)NSMutableArray* imageSource;

@end

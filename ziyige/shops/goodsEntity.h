//
//  goodsEntity.h
//  ziyige
//
//  Created by daimangkeji on 16/6/20.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "rootEntity.h"

@interface goodsEntity : rootEntity

@property(copy,nonatomic)NSString* goods_id;
@property(copy,nonatomic)NSString* goods_name;
@property(copy,nonatomic)NSString* goods_price;
@property(copy,nonatomic)NSString* specifications;
@property(copy,nonatomic)NSString* thumb_goods_url;
@property(copy,nonatomic)NSString* height;
@property(copy,nonatomic)NSString* width;
@property(copy,nonatomic)NSString* add_time;
@property(copy,nonatomic)NSString* amount;

@property(copy,nonatomic)NSString* out_trade_no;

@property(copy,nonatomic)NSString* status;

@property(copy,nonatomic)NSString* price;

@property(copy,nonatomic)NSString* total_fee;

@property(assign,nonatomic)CGFloat exceptHeight;

@end

//
//  collectEntity.h
//  ziyige
//
//  Created by daimangkeji on 16/7/4.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "rootEntity.h"

@interface collectEntity : rootEntity

@property(copy,nonatomic)NSString* goods_id;
@property(copy,nonatomic)NSString* goods_name;
@property(copy,nonatomic)NSString* goods_price;
@property(copy,nonatomic)NSString* specifications;
@property(copy,nonatomic)NSString* thumb_goods_url;
@property(copy,nonatomic)NSString* height;
@property(copy,nonatomic)NSString* width;

@property(copy,nonatomic)NSString* price;

@property(assign,nonatomic)CGFloat exceptHeight;

@end

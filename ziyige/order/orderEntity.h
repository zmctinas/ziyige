//
//  orderEntity.h
//  ziyige
//
//  Created by daimangkeji on 16/6/24.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "rootEntity.h"

typedef enum SendType {
    SendTypeSellerSend              = 0,
    SendTypeBuyerTake               = 1
}SendType;

typedef enum PayType {
    PayTypeOnLine              = 0,
    PayTypeOffLine             = 1
}PayType;

@interface orderEntity : rootEntity

@property(copy,nonatomic)NSString* user_id;
@property(copy,nonatomic)NSString* goods_id;
@property(copy,nonatomic)NSString* pay_ment;
@property(copy,nonatomic)NSString* distribution;
@property(copy,nonatomic)NSString* addr_id;
@property(copy,nonatomic)NSString* body;

@property(copy,nonatomic)NSString* out_trade_no;
@property(copy,nonatomic)NSString* specifications;
@property(copy,nonatomic)NSString* thumb_goods_url;
@property(copy,nonatomic)NSString* total_fee;
@property(copy,nonatomic)NSString* status;

@property(copy,nonatomic)NSString* sendType;

@end

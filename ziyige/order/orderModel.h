//
//  orderModel.h
//  ziyige
//
//  Created by daimangkeji on 16/6/24.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "rootModel.h"
#import "orderEntity.h"
#import "WebService+order.h"
#import "addressEntity.h"
#import "goodsEntity.h"
#import "orderDetialModel.h"

@interface orderModel : rootModel
{
    NSString* oldStatus;
}

@property(strong,nonatomic)NSMutableArray* dataSource;
@property(assign,nonatomic)NSInteger pages;
@property(strong,nonatomic)orderEntity* entity;
@property(strong,nonatomic)addressEntity* addEntity;
@property(strong,nonatomic)goodsEntity* goodsEntity;
@property(strong,nonatomic)orderDetialModel* detailEntity;

-(void)addTrade:(orderEntity*)entity;

- (void)getDefAddress;

-(void)getTradeList:(NSString*)status;

-(void)getTradeDetail:(NSString*)trade_no;


@end

//
//  orderModel.m
//  ziyige
//
//  Created by daimangkeji on 16/6/24.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "orderModel.h"
#import "goodsResponseEntity.h"

@implementation orderModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _pages = 1;
    }
    return self;
}

-(void)addTrade:(orderEntity *)entity
{
    NSDictionary* dic = [entity mj_keyValues];
    
    [self.webService addTrade:dic completion:^(BOOL isSuccess, NSString *message, id result) {
        if (isSuccess&&!message) {
            [[NSNotificationCenter defaultCenter]postNotificationName:ADD_ORDER_NOTIFICATION object:result];
        }else
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:WebServiceErrorNotification object:message];
        }
    }];
}



-(void)getDefAddress
{
    UserEntity* entity = [UserInfo info].currentUser;
    [self.webService getDefaultAddress:entity.userId completion:^(BOOL isSuccess, NSString *message, id result) {
        if (isSuccess&&!message) {
            
            [addressEntity mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
                return @{@"addid":@"id"};
            }];
            self.addEntity = [addressEntity mj_objectWithKeyValues:result];
            [[NSNotificationCenter defaultCenter]postNotificationName:GET_DEFAULT_AREA_NOTIFICATION object:result];
        }else{
            
            [[NSNotificationCenter defaultCenter] postNotificationName:WebServiceErrorNotification object:message];
        }
        
    }];
}

-(void)getTradeList:(NSString *)status
{
    
    __block NSMutableArray* source = self.dataSource;
    
    if (![oldStatus isEqualToString:status]) {
        self.pages = 1;
    }
    
    oldStatus = status;
    
    [self.webService getOrderListuserid:[UserInfo info].currentUser.userId Status:status pages:[NSString stringWithFormat:@"%ld",self.pages] completion:^(BOOL isSuccess, NSString *message, id result) {
        if (isSuccess&&!message) {
            goodsResponseEntity* response = result;
            //由于服务端在这个接口 在没有更多数据的时候 传回来的ResultCode是Fail，因此做不同的处理。
            if (self.pages == 1)
            {
                [source removeAllObjects];
            }
            if ([response.data count])
            {
                [source addObjectsFromArray:response.data];
            }
            BOOL noMoreData = YES;
            if (self.pages < response.pages)
            {
                noMoreData = NO;
                self.pages++;
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:GET_ORDER_LIST_NOTIFICATION object:@(noMoreData)];
        }else if (isSuccess&&message)
        {
            [source removeAllObjects];
            [[NSNotificationCenter defaultCenter] postNotificationName:GET_ORDER_LIST_NOTIFICATION object:@(NO)];
            [[NSNotificationCenter defaultCenter] postNotificationName:WebServiceErrorNotification object:message];
        }else
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:WebServiceErrorNotification object:message];
        }
    }];
}

-(void)getTradeDetail:(NSString *)trade_no
{
    [self.webService getOrderDetail:trade_no completion:^(BOOL isSuccess, NSString *message, id result) {
        if (isSuccess&&!message) {
            self.detailEntity = [orderDetialModel mj_objectWithKeyValues:result];
            [[NSNotificationCenter defaultCenter] postNotificationName:GET_ORDER_LIST_NOTIFICATION object:result];
        }else
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:WebServiceErrorNotification object:message];
        }
    }];
}

-(void)createPayTypeOrder:(NSString*)tradeNo payMent:(NSString*)payment
{
    UserEntity* entity = [UserInfo info].currentUser;
    [self.webService createPayTypeOrder:entity.userId tradeNo:tradeNo payMent:payment completion:^(BOOL isSuccess, NSString *message, id result) {
        if (isSuccess&&!message) {
            [[NSNotificationCenter defaultCenter] postNotificationName:CREATE_PAY_TYPE_ORDER_NOTIFICATION object:result];
        }else
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:WebServiceErrorNotification object:message];
        }
    }];
}

-(void)comfirmOrder:(NSString *)tradeNo
{
    [self.webService comfirmOrder:tradeNo completion:^(BOOL isSuccess, NSString *message, id result) {
        if (isSuccess&&!message) {
            [[NSNotificationCenter defaultCenter] postNotificationName:CONFIRM_ORDER_NOTIFICATION object:result];
        }else
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:WebServiceErrorNotification object:message];
        }
    }];
}

-(void)buyBackOrder:(NSString *)tradeNo
{
    [self.webService buyBackOrder:tradeNo completion:^(BOOL isSuccess, NSString *message, id result) {
        if (isSuccess&&!message) {
            [[NSNotificationCenter defaultCenter] postNotificationName:BUY_BACK_ORDER_NOTIFICATION object:result];
        }else
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:WebServiceErrorNotification object:message];
        }
    }];
}

-(orderEntity*)entity
{
    if (!_entity) {
        _entity = [[orderEntity alloc]init];
    }
    return _entity;
}

-(NSMutableArray*)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

@end

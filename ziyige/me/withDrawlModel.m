//
//  withDrawlModel.m
//  ziyige
//
//  Created by daimangkeji on 16/8/12.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "withDrawlModel.h"
#import "WebService+money.h"
#import "goodsResponseEntity.h"

@implementation withDrawlModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _pages = 1;
    }
    return self;
}

-(void)userWithDrawl:(NSString *)money type:(NSString *)type
{
    UserEntity* entity = [UserInfo info].currentUser;
    
    [self.webService userWithdrawl:entity.userId money:money type:type completion:^(BOOL isSuccess, NSString *message, id result) {
        if (isSuccess&&!message) {
            [[NSNotificationCenter defaultCenter] postNotificationName:USER_WITHDRAWL_NOTIFICATION object:result];
        }else
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:WebServiceErrorNotification object:message];
        }
    }];
}
//王晓伟
-(void)setPayment:(NSString *)payment type:(NSString *)type realName:(NSString *)realName
{
    UserEntity* entity = [UserInfo info].currentUser;

    [self.webService setPayment:entity.userId payment:payment type:type realName:realName completion:^(BOOL isSuccess, NSString *message, id result) {
        if (isSuccess&&!message) {
            [[NSNotificationCenter defaultCenter] postNotificationName:USER_PAYMENT_NOTIFICATION object:message];
        }else
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:WebServiceErrorNotification object:message];
        }
    }];
}

-(void)getPayment:(NSString *)type
{
    UserEntity* entity = [UserInfo info].currentUser;
    [self.webService getPayment:entity.userId type:type completion:^(BOOL isSuccess, NSString *message, id result) {
        if (isSuccess&&!message) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:USER_GET_PAYMENT_NOTIFICATION object:result];
        }else
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:WebServiceErrorNotification object:message];
        }
    }];
}

-(void)getCashList:(NSString *)pages
{
    UserEntity* entity = [UserInfo info].currentUser;
    
    [self.webService getCashList:entity.userId page:[NSString stringWithFormat:@"%ld",(long)self.pages] completion:^(BOOL isSuccess, NSString *message, id result) {
        if (isSuccess&&!message) {
            NSLog(@"%@",result);
            goodsResponseEntity*  response = result;
            //由于服务端在这个接口 在没有更多数据的时候 传回来的ResultCode是Fail，因此做不同的处理。
            if (self.pages == 1)
            {
                [self.tableSource removeAllObjects];
            }
            if ([response.data count])
            {
                [self.tableSource addObjectsFromArray:response.data];
            }
            BOOL noMoreData = YES;
            if (self.pages < response.pages)
            {
                noMoreData = NO;
                self.pages++;
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:USER_WITHDRAWL_RECORD_NOTIFICATION object:@(noMoreData)];
        }else
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:WebServiceErrorNotification object:message];
        }
    }];
}

-(NSMutableArray*)tableSource
{
    if (!_tableSource) {
        _tableSource = [NSMutableArray array];
    }
    return _tableSource;
}

@end

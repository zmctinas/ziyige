//
//  moneyModel.m
//  ziyige
//
//  Created by daimangkeji on 16/8/12.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "moneyModel.h"
#import "moneyEntity.h"

@implementation moneyModel

-(void)getUserMoney
{
    UserEntity* entity = [UserInfo info].currentUser;
    NSLog(@"%@",entity.userId);
    [self.webService getUserMoney:entity.userId completion:^(BOOL isSuccess, NSString *message, id result) {
        if (isSuccess&&!message) {
            moneyEntity* entity = [moneyEntity mj_objectWithKeyValues:result];
            [[NSNotificationCenter defaultCenter] postNotificationName:GET_MONEY_INDEX_NOTIFICATION object:entity];
        }else
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:WebServiceErrorNotification object:message];
        }
    }];
}


@end

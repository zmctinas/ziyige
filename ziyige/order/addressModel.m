//
//  addressModel.m
//  ziyige
//
//  Created by daimangkeji on 16/6/28.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "addressModel.h"

@implementation addressModel



-(void)addAddress:(addressEntity *)entity
{
    [self.webService addAddress:entity completion:^(BOOL isSuccess, NSString *message, id result) {
        if (isSuccess) {
            [[NSNotificationCenter defaultCenter]postNotificationName:ADD_AREA_NOTIFICATION object:result];
        }
    }];
}

-(void)getAddressList
{
    [self.webService getAddressList:^(BOOL isSuccess, NSString *message, id result) {
        if (isSuccess) {
            
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:result];
            
            [[NSNotificationCenter defaultCenter]postNotificationName:GET_AREA_LIST_NOTIFICATION object:result];
        }
    }];
}

-(void)delAddress:(NSString *)addid
{
    [self.webService delAddress:addid completion:^(BOOL isSuccess, NSString *message, id result) {
        if (isSuccess) {
            [[NSNotificationCenter defaultCenter]postNotificationName:DEL_AREA_NOTIFICATION object:result];
        }
    }];
}

-(void)setDefault:(NSString *)addid
{
    UserEntity* entity = [UserInfo info].currentUser;
    [self.webService setDefault:entity.userId addid:addid completion:^(BOOL isSuccess, NSString *message, id result) {
        if (isSuccess&&!message) {
            [[NSNotificationCenter defaultCenter]postNotificationName:SET_DEFAULT_AREA_NOTIFICATION object:result];
        }else
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:WebServiceErrorNotification object:message];
        }
        
    }];
}

-(void)editAddress:(addressEntity *)entity
{
    [self.webService editAddress:entity completion:^(BOOL isSuccess, NSString *message, id result) {
        
        if (isSuccess&&!message) {
            [[NSNotificationCenter defaultCenter]postNotificationName:EDIT_AREA_NOTIFICATION object:result];
        }else
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:WebServiceErrorNotification object:message];
        }
    }];
}


-(NSMutableArray*)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

@end

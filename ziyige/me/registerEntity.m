//
//  registerEntity.m
//  ziyige
//
//  Created by daimangkeji on 16/6/21.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "registerEntity.h"

@implementation registerEntity

- (instancetype)init
{
    self = [super init];
    if (self) {
        _userName = @"藏友";
    }
    return self;
}

+ (void)map
{
    [registerEntity mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"userId":@"user_id",
                 @"userName":@"user_name",
                 @"phoneNumber":@"phoneNumber",
                 @"isSeller":@"is_seller",
                 @"shopId":@"shop_id",
                 @"latitude":@"latitude",
                 @"longtitude":@"longtitude",
                 @"password":@"password",
                 @"registerDate":@"registerDate",
                 @"easemob":@"easemob",
                 @"photo":@"photo",
                 @"lastlogin":@"lastlogin",
                 @"clientId":@"clientId",
                 @"deviceToken":@"deviceToken",
                 @"deviceType":@"device_type",
                 @"sex":@"sex",
                 @"cityCode":@"cityCode",
                 @"signature":@"signature",
                 @"userType":@"user_type"
                 };
    }];
}

@end

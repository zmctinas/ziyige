//
//  inviteModel.m
//  ziyige
//
//  Created by daimangkeji on 16/8/16.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "inviteModel.h"
#import "WebService+userManager.h"
#import "goodsResponseEntity.h"

@implementation inviteModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _pages = 1;
    }
    return self;
}

-(void)getInviteCode
{
    UserEntity* entity = [UserInfo info].currentUser;
    [self.webService getInviteCode:entity.userId completion:^(BOOL isSuccess, NSString *message, id result) {
        if (isSuccess&&!message) {
            [[NSNotificationCenter defaultCenter] postNotificationName:USER_INVITE_NOTIFICATION object:result];
        }else
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:WebServiceErrorNotification object:message];
        }
    }];
}

-(void)getInviteList:(NSString *)inviteCode
{
    [self.webService getInviteList:inviteCode page:@"1" completion:^(BOOL isSuccess, NSString *message, id result) {
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
            [[NSNotificationCenter defaultCenter] postNotificationName:USER_INVITE_RECORD_NOTIFICATION object:@(noMoreData)];
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

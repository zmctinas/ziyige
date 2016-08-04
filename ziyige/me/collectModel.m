//
//  collectModel.m
//  ziyige
//
//  Created by daimangkeji on 16/7/4.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "collectModel.h"
#import "goodsResponseEntity.h"

@implementation collectModel

-(void)getCollectList
{
    [self.webService getCollectList:[UserInfo info].currentUser.userId pages:@"1" completion:^(BOOL isSuccess, NSString *message, id result) {
        if (isSuccess&&!message) {
            goodsResponseEntity*  response = result;
            //由于服务端在这个接口 在没有更多数据的时候 传回来的ResultCode是Fail，因此做不同的处理。
            if (self.pages == 1)
            {
                [self.goodsSource removeAllObjects];
            }
            if ([response.data count])
            {
                [self.goodsSource addObjectsFromArray:response.data];
            }
            BOOL noMoreData = YES;
            if (self.pages < response.pages)
            {
                noMoreData = NO;
                self.pages++;
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:GET_COLLECT_LIST_NOTIFICATION object:@(noMoreData)];
        }else
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:WebServiceErrorNotification object:message];
        }
    }];
}

@end

//
//  goodsModel.m
//  ziyige
//
//  Created by daimangkeji on 16/6/20.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "goodsModel.h"
#import "WebService+index.h"
#import "goodsResponseEntity.h"
#import "detailEntity.h"

@implementation goodsModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _pages = 1;
    }
    return self;
}

-(void)getGoodsWithActid:(NSString*)actid
{
    if (self.oldActId.integerValue != actid.integerValue) {
        self.pages = 1;
        self.oldActId = actid;
    }
    [self.webService requestGoodsWithAct:actid pages:[NSString stringWithFormat:@"%ld",self.pages] completion:^(BOOL isSuccess, NSString *message, id result) {
        
        if (isSuccess)
        {
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
            [[NSNotificationCenter defaultCenter] postNotificationName:GOODS_LIST object:@(noMoreData)];
        }
        
    }];
}

-(void)getGoodsDetail
{
    UserEntity* entity = [UserInfo info].currentUser;
    NSString* userid ;
    if (entity.userId) {
        userid = entity.userId;
    }else
    {
        userid = @"";
    }
    [self.webService getGoodsDetail:userid goodsID:self.curEntity.goods_id completion:^(BOOL isSuccess, NSString *message, id result) {
        if (isSuccess) {
            NSDictionary* dic = result;
            NSLog(@"%@",dic);
            NSInteger imageNum = [dic[@"num"] integerValue];
            NSMutableArray* imageArr = [NSMutableArray array];
            for (int i = 0; i < imageNum; i ++) {
                NSString* imageKey = [NSString stringWithFormat:@"img%d",i+1];
                [imageArr addObject:dic[imageKey]];
            }
            detailEntity* response = [detailEntity mj_objectWithKeyValues:dic];
            response.imageSource = imageArr;
            [self.detailSource addObject:response];
            [self.detailSource addObject:response];
            [self.detailSource addObject:response];
            [self.detailSource addObject:response];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:GET_DETAIL_NOTIFICATION object:nil];
        }
    }];
}

-(void)addCollect
{
    UserEntity* entity = [UserInfo info].currentUser;
    [self.webService addCollect:entity.userId goodsID:self.curEntity.goods_id completion:^(BOOL isSuccess, NSString *message, id result) {
        if (isSuccess) {
            [[NSNotificationCenter defaultCenter] postNotificationName:ADD_COLLECT_NOTIFICATION object:nil];
        }
    }];
}

-(void)delCollect
{
    UserEntity* entity = [UserInfo info].currentUser;
    [self.webService delCollect:entity.userId goodsID:self.curEntity.goods_id completion:^(BOOL isSuccess, NSString *message, id result) {
        if (isSuccess) {
            [[NSNotificationCenter defaultCenter] postNotificationName:DEL_COLLECT_NOTIFICATION object:nil];
        }
    }];
}

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


-(void)searchGoods:(NSString*)keywords type:(NSString *)type cost:(NSString *)cost
{
    [self.webService searchGoods:keywords pages:[NSString stringWithFormat:@"%ld",(long)self.pages] type:type cost:cost completion:^(BOOL isSuccess, NSString *message, id result) {
        if (isSuccess&&!message) {
            goodsResponseEntity*  response = result;
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
            [[NSNotificationCenter defaultCenter] postNotificationName:GET_SEARCH_LIST_NOTIFICATION object:@(noMoreData)];
        }else if (isSuccess&&message)
        {
            [self.goodsSource removeAllObjects];
            [[NSNotificationCenter defaultCenter] postNotificationName:GET_SEARCH_LIST_NOTIFICATION object:@(NO)];
            [[NSNotificationCenter defaultCenter] postNotificationName:WebServiceErrorNotification object:message];
        }else
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:WebServiceErrorNotification object:message];
        }
    }];
}


-(NSMutableArray*)detailSource
{
    if (!_detailSource) {
        _detailSource = [NSMutableArray array];
    }
    return _detailSource;
}

-(NSMutableArray*)goodsSource
{
    if (!_goodsSource) {
        _goodsSource = [NSMutableArray array];
    }
    return _goodsSource;
}

-(void)setCurEntity:(goodsEntity *)curEntity
{
    _curEntity = nil;
    [_detailSource removeAllObjects];
    _curEntity = curEntity;
}

@end

//
//  goodsModel.h
//  ziyige
//
//  Created by daimangkeji on 16/6/20.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "rootModel.h"
#import "goodsEntity.h"

@interface goodsModel : rootModel

@property(strong,nonatomic)NSMutableArray* goodsSource;
@property(nonatomic,assign)NSInteger pages;
@property(strong,nonatomic)goodsEntity* curEntity;

@property(strong,nonatomic)NSMutableArray* detailSource;

-(void)getGoodsWithActid:(NSString*)actid;

-(void)getGoodsDetail;

-(void)addCollect;

-(void)delCollect;

-(void)getCollectList;

@end

//
//  addressModel.h
//  ziyige
//
//  Created by daimangkeji on 16/6/28.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "rootModel.h"
#import "addressEntity.h"
#import "WebService+order.h"

@interface addressModel : rootModel

@property(strong,nonatomic)NSMutableArray* dataSource;


-(void)addAddress:(addressEntity*)entity;

-(void)getAddressList;

-(void)delAddress:(NSString*)addid;

-(void)setDefault:(NSString*)addid;

-(void)editAddress:(addressEntity*)entity;


@end

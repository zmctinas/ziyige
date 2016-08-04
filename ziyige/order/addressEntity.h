//
//  addressEntity.h
//  ziyige
//
//  Created by daimangkeji on 16/6/27.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "rootEntity.h"

@interface addressEntity : rootEntity

@property(copy,nonatomic)NSString* link_name;

@property(copy,nonatomic)NSString* tel_num;

@property(copy,nonatomic)NSString* province;

@property(copy,nonatomic)NSString* city;

@property(copy,nonatomic)NSString* district;

@property(copy,nonatomic)NSString* address;

@property(copy,nonatomic)NSString* user_id;

@property(copy,nonatomic)NSString* addid;

@property(copy,nonatomic)NSString* is_def;


@end

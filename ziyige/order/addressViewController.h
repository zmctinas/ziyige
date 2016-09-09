//
//  addressViewController.h
//  ziyige
//
//  Created by daimangkeji on 16/6/24.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "fatherViewController.h"
#import "addressEntity.h"
#import "orderModel.h"

@interface addressViewController : fatherViewController

@property(strong,nonatomic)orderModel* Omodel;
@property(strong,nonatomic)addressEntity* entity;

@end

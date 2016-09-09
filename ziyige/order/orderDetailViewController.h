//
//  orderDetailViewController.h
//  ziyige
//
//  Created by daimangkeji on 16/7/6.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "fatherViewController.h"
#import "orderModel.h"

@interface orderDetailViewController : fatherViewController

@property(strong,nonatomic)NSString* trade_no;

@property(strong,nonatomic)orderModel* model;

@end

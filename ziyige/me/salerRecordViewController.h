//
//  salerRecordViewController.h
//  ziyige
//
//  Created by daimangkeji on 16/6/16.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "fatherViewController.h"
#import "orderModel.h"

@interface salerRecordViewController : fatherViewController

@property(strong,nonatomic)orderModel* model;
@property(assign,nonatomic)NSInteger headerIndex;

@end

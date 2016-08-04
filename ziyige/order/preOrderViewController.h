//
//  preOrderViewController.h
//  ziyige
//
//  Created by daimangkeji on 16/6/23.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "fatherViewController.h"
#import "orderModel.h"


@interface preOrderViewController : fatherViewController

@property(strong,nonatomic)orderModel* model;

-(void)setUpUI;

@end

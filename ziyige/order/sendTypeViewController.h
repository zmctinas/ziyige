//
//  sendTypeViewController.h
//  ziyige
//
//  Created by daimangkeji on 16/6/24.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "fatherViewController.h"
#import "orderEntity.h"

@protocol sentTypeDelegate <NSObject>

-(void)changeUI;


@end

@interface sendTypeViewController : fatherViewController

@property(assign,nonatomic)id<sentTypeDelegate> delegate;

@property(strong,nonatomic)orderEntity* entity;

@end

//
//  aliAcountViewController.h
//  yuanli
//
//  Created by 代忙 on 16/4/6.
//  Copyright © 2016年 wxw. All rights reserved.
//

#import "fatherViewController.h"
#import "withDrawlModel.h"

@interface aliAcountViewController : fatherViewController

@property(strong,nonatomic)NSDictionary* messageDic;
@property(strong,nonatomic)NSString* money;
@property(strong,nonatomic)withDrawlModel* model;

@end

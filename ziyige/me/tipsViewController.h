//
//  tipsViewController.h
//  ziyige
//
//  Created by daimangkeji on 16/9/8.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "fatherViewController.h"

@protocol alertDelegate <NSObject>

-(void)viewWillDissmiss;

@end

@interface tipsViewController : fatherViewController

@property(assign,nonatomic)id<alertDelegate> delegate;

@end

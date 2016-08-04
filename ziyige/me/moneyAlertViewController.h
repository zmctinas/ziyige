//
//  moneyAlertViewController.h
//  ziyige
//
//  Created by daimangkeji on 16/8/3.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "fatherViewController.h"

@protocol alertProtocol <NSObject>

-(void)makeSureBtn;

@end

@interface moneyAlertViewController : fatherViewController

@property(assign,nonatomic)id<alertProtocol> delegate;

@end

//
//  collectModel.h
//  ziyige
//
//  Created by daimangkeji on 16/7/4.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "rootModel.h"
#import "WebService+index.h"

@interface collectModel : rootModel

@property(strong,nonatomic)NSMutableArray* goodsSource;
@property(nonatomic,assign)NSInteger pages;




@end

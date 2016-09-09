//
//  withDrawlModel.h
//  ziyige
//
//  Created by daimangkeji on 16/8/12.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "rootModel.h"

@interface withDrawlModel : rootModel

@property(assign,nonatomic)NSInteger pages;
@property(strong,nonatomic)NSMutableArray* tableSource;

-(void)userWithDrawl:(NSString*)money
                type:(NSString*)type;

-(void)setPayment:(NSString*)payment
             type:(NSString*)type
         realName:(NSString*)realName;

-(void)getPayment:(NSString*)type;


-(void)getCashList:(NSString*)pages;


@end

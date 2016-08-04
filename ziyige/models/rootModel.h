//
//  rootModel.h
//  ziyige
//
//  Created by daimangkeji on 16/6/20.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebService.h"

@interface rootModel : NSObject

@property (nonatomic,strong) WebService *webService;

-(void)setValue:(id)value forUndefinedKey:(NSString *)key;

@end

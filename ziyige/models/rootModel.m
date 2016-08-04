//
//  rootModel.m
//  ziyige
//
//  Created by daimangkeji on 16/6/20.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "rootModel.h"

@implementation rootModel


-(WebService *)webService
{
    if (!_webService) {
        _webService = [WebService service];
    }
    return _webService;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end

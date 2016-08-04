//
//  detailEntity.m
//  ziyige
//
//  Created by daimangkeji on 16/6/22.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "detailEntity.h"

@implementation detailEntity

-(NSMutableArray*)imageSource
{
    if (!_imageSource) {
        _imageSource = [NSMutableArray array];
    }
    return _imageSource;
}

@end

//
//  feedBackModel.h
//  ziyige
//
//  Created by daimangkeji on 16/7/6.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "rootModel.h"
#import "WebService+index.h"

@interface feedBackModel : rootModel

-(void)addMessage:(NSString *)content;

@end

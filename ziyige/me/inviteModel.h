//
//  inviteModel.h
//  ziyige
//
//  Created by daimangkeji on 16/8/16.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "rootModel.h"

@interface inviteModel : rootModel

@property(assign,nonatomic)NSInteger pages;
@property(strong,nonatomic)NSMutableArray* tableSource;


-(void)getInviteCode;

-(void)getInviteList:(NSString*)inviteCode;

@end

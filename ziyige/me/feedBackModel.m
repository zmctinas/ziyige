//
//  feedBackModel.m
//  ziyige
//
//  Created by daimangkeji on 16/7/6.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "feedBackModel.h"

@implementation feedBackModel

-(void)addMessage:(NSString *)content
{
    [self.webService addMessage:[UserInfo info].currentUser.userId content:content completion:^(BOOL isSuccess, NSString *message, id result) {
        if (isSuccess&&!message) {
            [[NSNotificationCenter defaultCenter]postNotificationName:ADD_MESSAGE_NOTIFICATION object:result];
        }else
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:WebServiceErrorNotification object:message];
        }
    }];
}

@end

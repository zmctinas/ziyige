//
//  WebService+money.h
//  ziyige
//
//  Created by daimangkeji on 16/8/12.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "WebService.h"

@interface WebService (money)

/**
 *  获取用户余额信息
 *
 *  @param userId     uid
 *  @param completion
 */
-(void)getUserMoney:(NSString*)userId
         completion:(DMCompletionBlock)completion;


/**
 *  用户提现接口
 *
 *  @param userId     uid
 *  @param money      钱数
 *  @param type       微信/支付宝
 *  @param completion
 */
-(void)userWithdrawl:(NSString*)userId
               money:(NSString*)money
                type:(NSString*)type
          completion:(DMCompletionBlock)completion;


/**
 *  设置收款账号
 *
 *  @param userId     uid
 *  @param payment    账号
 *  @param type       类型
 *  @param realName   支付宝实名
 *  @param completion 
 */
-(void)setPayment:(NSString*)userId
          payment:(NSString*)payment
             type:(NSString*)type
         realName:(NSString*)realName
       completion:(DMCompletionBlock)completion;

/**
 *  获取收款账号
 *
 *  @param userId     uid
 *  @param type       类型
 *  @param completion
 */
-(void)getPayment:(NSString*)userId
             type:(NSString*)type
       completion:(DMCompletionBlock)completion;

/**
 *  获取提现列表
 *
 *  @param userId      uid
 *  @param pages       分页
 *  @param cocmpletion 
 */
-(void)getCashList:(NSString*)userId
              page:(NSString*)pages
        completion:(DMCompletionBlock)completion;

@end

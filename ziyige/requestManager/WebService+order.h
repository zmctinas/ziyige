//
//  WebService+order.h
//  ziyige
//
//  Created by daimangkeji on 16/6/24.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "WebService.h"
#import "goodsEntity.h"
#import "addressEntity.h"

@interface WebService (order)

/**
 *  生成订单
 *
 *  @param dic        相应数据集合
 *  @param completion
 */
- (void)addTrade:(NSDictionary*)dic
      completion:(DMCompletionBlock)completion;


/**
 *  获取地址列表
 *
 *  @param completion
 */
- (void)getAddressList:(DMCompletionBlock)completion;


/**
 *  添加地址
 *
 *  @param entity     地址类
 *  @param completion
 */
- (void)addAddress:(addressEntity*)entity
        completion:(DMCompletionBlock)completion;


/**
 *  删除地址
 *
 *  @param addid      地址id
 *  @param completion
 */
- (void)delAddress:(NSString*)addid
        completion:(DMCompletionBlock)completion;


/**
 *  设置默认地址
 *
 *  @param userid     uid
 *  @param addid      地址id
 *  @param completion
 */
- (void)setDefault:(NSString*)userid
             addid:(NSString*)addid
        completion:(DMCompletionBlock)completion;


/**
 *  修改地址
 *
 *  @param entity     地址类
 *  @param completion
 */
- (void)editAddress:(addressEntity*)entity
         completion:(DMCompletionBlock)completion;

/**
 *  获取默认地址
 *
 *  @param userid     uid
 *  @param completion
 */
- (void)getDefaultAddress:(NSString*)userid
               completion:(DMCompletionBlock)completion;


/**
 *  获取订单列表
 *
 *  @param userid     uid
 *  @param status     订单状态
 *  @param pages      页数
 *  @param completion
 */
- (void)getOrderListuserid:(NSString*)userid
                    Status:(NSString*)status
                     pages:(NSString*)pages
                completion:(DMCompletionBlock)completion;


/**
 *  获取订单详情
 *
 *  @param trade_no   订单号
 *  @param completion 
 */
- (void)getOrderDetail:(NSString*)trade_no
            completion:(DMCompletionBlock)completion;


/**
 *  支付下单
 *
 *  @param userId     uid
 *  @param tradeNo    订单号
 *  @param payment    支付方式
 *  @param completion 
 */
-(void)createPayTypeOrder:(NSString*)userId
                  tradeNo:(NSString*)tradeNo
                  payMent:(NSString*)payment
               completion:(DMCompletionBlock)completion;


/**
 *  确认收货
 *
 *  @param tradeNo    订单号
 *  @param completion 
 */
-(void)comfirmOrder:(NSString*)tradeNo
         completion:(DMCompletionBlock)completion;


/**
 *  申请回购
 *
 *  @param tradeNo    订单号
 *  @param completion 
 */
-(void)buyBackOrder:(NSString*)tradeNo
         completion:(DMCompletionBlock)completion;


@end

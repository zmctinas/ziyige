//
//  WebService+index.h
//  ziyige
//
//  Created by daimangkeji on 16/6/20.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "WebService.h"

@interface WebService (index)

/**
 *  请求首页商品列表
 *
 *  @param actid      商品种类id
 *  @param completion 
 */
-(void)requestGoodsWithAct:(NSString*)actid pages:(NSString*)pages completion:(DMCompletionBlock)completion;

/**
 *   请求商品列表
 *
 *  @param userId  uid
 *  @param goodsId 商品id
 */
- (void)getGoodsDetail:(NSString*)userId
               goodsID:(NSString*)goodsId
            completion:(DMCompletionBlock)completion;

/**
 *  添加收藏
 *
 *  @param userId     uid
 *  @param goodsId    商品id
 *  @param completion
 */
- (void)addCollect:(NSString*)userId
           goodsID:(NSString*)goodsId
        completion:(DMCompletionBlock)completion;

/**
 *  删除收藏
 *
 *  @param userId     uid
 *  @param goodsId    商品id
 *  @param completion 
 */
- (void)delCollect:(NSString*)userId
           goodsID:(NSString*)goodsId
        completion:(DMCompletionBlock)completion;


/**
 *  获取收藏列表
 *
 *  @param userid     uid
 *  @param pages      分页
 *  @param completion
 */
- (void)getCollectList:(NSString*)userid
                 pages:(NSString*)pages
            completion:(DMCompletionBlock)completion;


/**
 *  添加反馈
 *
 *  @param userid     uid
 *  @param content    内容
 *  @param completion 
 */
- (void)addMessage:(NSString*)userid
           content:(NSString*)content
        completion:(DMCompletionBlock)completion;


/**
 *  搜索
 *
 *  @param keywords   关键词
 *  @param pages      页数
 *  @param type       价格顺序
 *  @param cost       价格筛选
 *  @param completion
 */
- (void)searchGoods:(NSString*)keywords
              pages:(NSString*)pages
               type:(NSString*)type
               cost:(NSString*)cost
         completion:(DMCompletionBlock)completion;

@end

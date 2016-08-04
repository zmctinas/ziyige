//
//  WebService+index.m
//  ziyige
//
//  Created by daimangkeji on 16/6/20.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "WebService+index.h"
#import "goodsEntity.h"
#import "goodsResponseEntity.h"

@implementation WebService (index)

-(void)requestGoodsWithAct:(NSString *)actid completion:(DMCompletionBlock)completion
{
    NSDictionary *postData = @{@"pages":@"1",@"act_id":actid};
    
    [self postWithMethodName:GOODS_LIST data:postData success:^(id JSON) {
        
        if ([JSON isKindOfClass:[NSDictionary class]])
        {
            
            NSDictionary *dataDic = [JSON objectForKey:DATA];
            int status = [[dataDic objectForKey:STATUS] intValue];
            
            if (status == ResponseStatusSuccess)
            {
                NSArray* dataArr = [dataDic objectForKey:DATA];
                if (![dataArr isEqual:[NSNull null]])
                {
                    NSLog(@"=== = ===%@",dataDic);
                    [goodsResponseEntity mj_setupObjectClassInArray:^NSDictionary *{
                        return @{@"data" : NSStringFromClass([goodsEntity class]),};
                    }];
                    
                    goodsResponseEntity* response = [goodsResponseEntity mj_objectWithKeyValues:dataDic];
                    
                    completion(YES,nil,response);
                }
            }
            else if (status == ResponseStatusFailed)
            {
                NSString *message = SERVER_ERROE_MESSAGE;
                if (![dataDic isEqual:[NSNull null]])
                {
                    message = [dataDic objectForKey:RESULT_MESSAGE];
                }
                completion(YES,message,nil);
            }
        }
    } failure:^(NSError *error, id JSON) {
        completion(NO,[error.userInfo objectForKey:NSLocalizedFailureReasonErrorKey],nil);
    }];
}

-(void)getGoodsDetail:(NSString *)userId goodsID:(NSString *)goodsId completion:(DMCompletionBlock)completion
{
    NSDictionary* dic = @{
                          @"goods_id":goodsId,
                          @"user_id":userId
                          };
    [self postWithMethodName:GOODS_DETAIL data:dic success:^(id JSON) {
        if ([JSON isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *dataDic = [JSON objectForKey:DATA];
            int status = [[dataDic objectForKey:STATUS] intValue];
            if (status == ResponseStatusSuccess)
            {
                NSDictionary *objDict = [dataDic objectForKey:DATA];
                if (![objDict isEqual:[NSNull null]])
                {
                    completion(YES,nil,objDict);
                }
            }else if (status == ResponseStatusFailed)
            {
                NSDictionary *objDict = [JSON objectForKey:DATA];
                NSString *message = SERVER_ERROE_MESSAGE;
                if (![objDict isEqual:[NSNull null]])
                {
                    message = [objDict objectForKey:RESULT_MESSAGE];
                }
                completion(YES,message,nil);
            }
        }
    } failure:^(NSError *error, id JSON) {
        completion(NO,[error.userInfo objectForKey:NSLocalizedFailureReasonErrorKey],nil);
    }];
}

- (void)addCollect:(NSString *)userId goodsID:(NSString *)goodsId completion:(DMCompletionBlock)completion
{
    NSDictionary* dic = @{
                          @"user_id":userId,
                          @"goods_id":goodsId
                          };
    [self postWithMethodName:ADD_COLLECT data:dic success:^(id JSON) {
        if ([JSON isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *dataDic = [JSON objectForKey:DATA];
            int status = [[dataDic objectForKey:STATUS] intValue];
            if (status == ResponseStatusSuccess)
            {
                NSDictionary *objDict = [dataDic objectForKey:DATA];
                if (![objDict isEqual:[NSNull null]])
                {
                    completion(YES,nil,nil);
                }
            }else if (status == ResponseStatusFailed)
            {
                NSDictionary *objDict = [JSON objectForKey:DATA];
                NSString *message = SERVER_ERROE_MESSAGE;
                if (![objDict isEqual:[NSNull null]])
                {
                    message = [objDict objectForKey:RESULT_MESSAGE];
                }
                completion(YES,message,nil);
            }
        }
    } failure:^(NSError *error, id JSON) {
        completion(NO,[error.userInfo objectForKey:NSLocalizedFailureReasonErrorKey],nil);
    }];
}

-(void)delCollect:(NSString *)userId goodsID:(NSString *)goodsId completion:(DMCompletionBlock)completion
{
    NSDictionary* dic = @{
                          @"user_id":userId,
                          @"goods_id":goodsId
                          };
    [self postWithMethodName:DEL_COLLECT data:dic success:^(id JSON) {
        if ([JSON isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *dataDic = [JSON objectForKey:DATA];
            int status = [[dataDic objectForKey:STATUS] intValue];
            if (status == ResponseStatusSuccess)
            {
                NSDictionary *objDict = [dataDic objectForKey:DATA];
                if (![objDict isEqual:[NSNull null]])
                {
                    completion(YES,nil,nil);
                }
            }else if (status == ResponseStatusFailed)
            {
                NSDictionary *objDict = [JSON objectForKey:DATA];
                NSString *message = SERVER_ERROE_MESSAGE;
                if (![objDict isEqual:[NSNull null]])
                {
                    message = [objDict objectForKey:RESULT_MESSAGE];
                }
                completion(YES,message,nil);
            }
        }
    } failure:^(NSError *error, id JSON) {
        completion(NO,[error.userInfo objectForKey:NSLocalizedFailureReasonErrorKey],nil);
    }];
}

-(void)getCollectList:(NSString *)userid pages:(NSString *)pages completion:(DMCompletionBlock)completion
{
    NSDictionary* dic = @{
                          @"user_id":userid,
                          @"pages":pages,
                          };
    [self postWithMethodName:GET_COLLECT_LIST data:dic success:^(id JSON) {
        if ([JSON isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *dataDic = [JSON objectForKey:DATA];
            int status = [[dataDic objectForKey:STATUS] intValue];
            if (status == ResponseStatusSuccess)
            {
                NSDictionary *objDict = [dataDic objectForKey:DATA];
                if (![objDict isEqual:[NSNull null]])
                {
                    [goodsResponseEntity mj_setupObjectClassInArray:^NSDictionary *{
                        return @{@"data" : NSStringFromClass([goodsEntity class]),};
                    }];
                    
                    goodsResponseEntity* response = [goodsResponseEntity mj_objectWithKeyValues:dataDic];
                    
                    completion(YES,nil,response);
                }
            }else if (status == ResponseStatusFailed)
            {
                NSDictionary *objDict = [JSON objectForKey:DATA];
                NSString *message = SERVER_ERROE_MESSAGE;
                if (![objDict isEqual:[NSNull null]])
                {
                    message = [objDict objectForKey:RESULT_MESSAGE];
                }
                completion(YES,message,nil);
            }
        }
    } failure:^(NSError *error, id JSON) {
        completion(NO,[error.userInfo objectForKey:NSLocalizedFailureReasonErrorKey],nil);
    }];
}

-(void)addMessage:(NSString *)userid content:(NSString *)content completion:(DMCompletionBlock)completion
{
    
    NSDictionary* dic = @{
                          @"user_id":userid,
                          @"content":content,
                          };
    
    [self postWithMethodName:ADD_MESSAGE data:dic success:^(id JSON) {
        if ([JSON isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *dataDic = [JSON objectForKey:DATA];
            int status = [[dataDic objectForKey:STATUS] intValue];
            if (status == ResponseStatusSuccess)
            {
                NSDictionary *objDict = [dataDic objectForKey:DATA];
                if (![objDict isEqual:[NSNull null]])
                {
                    completion(YES,nil,nil);
                }
            }else if (status == ResponseStatusFailed)
            {
                NSDictionary *objDict = [JSON objectForKey:DATA];
                NSString *message = SERVER_ERROE_MESSAGE;
                if (![objDict isEqual:[NSNull null]])
                {
                    message = [objDict objectForKey:RESULT_MESSAGE];
                }
                completion(YES,message,nil);
            }
        }
    } failure:^(NSError *error, id JSON) {
        completion(NO,[error.userInfo objectForKey:NSLocalizedFailureReasonErrorKey],nil);
    }];
    
}


@end

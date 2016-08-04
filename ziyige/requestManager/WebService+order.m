//
//  WebService+order.m
//  ziyige
//
//  Created by daimangkeji on 16/6/24.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "WebService+order.h"
#import "goodsResponseEntity.h"

@implementation WebService (order)


-(void)addTrade:(NSDictionary *)dic completion:(DMCompletionBlock)completion
{
    [self postWithMethodName:CREATE_ORDER data:dic success:^(id JSON) {
        if ([JSON isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *dataDic = [JSON objectForKey:DATA];
            int status = [[dataDic objectForKey:STATUS] intValue];
            if (status == ResponseStatusSuccess)
            {
                NSDictionary *objDict = [dataDic objectForKey:DATA];
                if (![objDict isEqual:[NSNull null]])
                {
                    NSLog(@"%@",dataDic);
                    completion(YES,nil,dataDic);
                    
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

-(void)addAddress:(addressEntity *)entity completion:(DMCompletionBlock)completion
{
    
    NSDictionary* dic = [entity mj_keyValues];
    
    NSLog(@"%@",dic);
    [self postWithMethodName:ADD_ADDRESS data:dic success:^(id JSON) {
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

-(void)getAddressList:(DMCompletionBlock)completion
{
    UserEntity* entity = [UserInfo info].currentUser;
    NSDictionary* dic = @{
                          @"user_id":entity.userId
                          };
    [self postWithMethodName:ADDRESS_LIST data:dic success:^(id JSON) {
        if ([JSON isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *dataDic = [JSON objectForKey:DATA];
            int status = [[dataDic objectForKey:STATUS] intValue];
            if (status == ResponseStatusSuccess)
            {
                NSDictionary *objDict = [dataDic objectForKey:DATA];
                if (![objDict isEqual:[NSNull null]])
                {
                    
                    [addressEntity mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
                        return @{@"addid":@"id"};
                    }];
                    
                    NSMutableArray* arr = [addressEntity mj_objectArrayWithKeyValuesArray:objDict];
                    
                    completion(YES,nil,arr);
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

-(void)delAddress:(NSString *)addid completion:(DMCompletionBlock)completion
{
    NSDictionary* dic = @{
                          @"id":addid
                          };
    [self postWithMethodName:DEL_ADDRESS data:dic success:^(id JSON) {
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

-(void)setDefault:(NSString *)userid addid:(NSString *)addid completion:(DMCompletionBlock)completion
{
    NSDictionary* dic = @{
                          
                          @"id":addid,
                          @"user_id":userid,
                          
                          };
    
    [self postWithMethodName:SET_DEFAULT_ADDRESS data:dic success:^(id JSON) {
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

-(void)editAddress:(addressEntity *)entity completion:(DMCompletionBlock)completion
{
//    NSDictionary* dic = @{
//                          @"id":entity.addid,
//                          @"link_name":entity.link_name,
//                          @"tel_num":entity.tel_num,
//                          @"province":entity.province,
//                          @"city":entity.city,
//                          @"district":entity.district,
//                          @"address":entity.address,
//                          
//                          };
    
    NSDictionary* dic = [entity mj_keyValues];
    
    [self postWithMethodName:UPDATE_ADDRESS data:dic success:^(id JSON) {
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

-(void)getDefaultAddress:(NSString *)userid completion:(DMCompletionBlock)completion
{
    
    NSDictionary* dic = @{
                          @"user_id":userid,
                          
                          };
    
    [self postWithMethodName:GET_DEFAULT_ADDRESS data:dic success:^(id JSON) {
        if ([JSON isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *dataDic = [JSON objectForKey:DATA];
            int status = [[dataDic objectForKey:STATUS] intValue];
            if (status == ResponseStatusSuccess)
            {
                NSDictionary *objDict = [dataDic objectForKey:DATA];
                if (![objDict isEqual:[NSNull null]])
                {
                    NSLog(@"%@",objDict);
                    
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

-(void)getOrderListuserid:(NSString *)userid Status:(NSString *)status pages:(NSString *)pages completion:(DMCompletionBlock)completion
{
    NSDictionary* dic = @{
                          @"user_id":userid,
                          @"status":status,
                          @"pages":pages,
                          };
    
    [self postWithMethodName:GET_ORDER_LIST data:dic success:^(id JSON) {
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
                    [goodsEntity mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
                        return @{
                                 @"goods_price":@"total_fee",
                                 };
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

-(void)getOrderDetail:(NSString *)trade_no completion:(DMCompletionBlock)completion
{
    
    NSDictionary* dic = @{
                          @"out_trade_no":trade_no,
                          };
    
    [self postWithMethodName:GET_ORDER_DETAIL data:dic success:^(id JSON) {
        if ([JSON isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *dataDic = [JSON objectForKey:DATA];
            int status = [[dataDic objectForKey:STATUS] intValue];
            if (status == ResponseStatusSuccess)
            {
                NSDictionary *objDict = [dataDic objectForKey:DATA];
                if (![objDict isEqual:[NSNull null]])
                {
                    NSLog(@"%@",objDict);
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


@end

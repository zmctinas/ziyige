//
//  WebService+money.m
//  ziyige
//
//  Created by daimangkeji on 16/8/12.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "WebService+money.h"
#import "goodsResponseEntity.h"
#import "withDrawlEntity.h"

@implementation WebService (money)

-(void)getUserMoney:(NSString *)userId completion:(DMCompletionBlock)completion
{
    NSDictionary* dic = @{
                          
                          @"user_id":userId,
                          
                          };
    
     [self postWithMethodName:GET_MONEY_MESSAGE data:dic success:^(id JSON) {
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

-(void)userWithdrawl:(NSString *)userId money:(NSString *)money type:(NSString *)type completion:(DMCompletionBlock)completion
{
    NSDictionary* dic = @{
                          
                          @"user_id":userId,
                          @"money":money,
                          @"type":type
                          };
    
     [self postWithMethodName:USER_WITHDRAWL data:dic success:^(id JSON) {
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

-(void)setPayment:(NSString *)userId payment:(NSString *)payment type:(NSString *)type realName:(NSString *)realName completion:(DMCompletionBlock)completion
{
    NSDictionary* dic;
    if ([type isEqualToString:@"ali_pay"]) {
        dic = @{
                
                @"id":userId,
                @"payment":payment,
                @"type":type,
                @"real_name":realName,
                };
    }else
    {
        dic = @{
                @"id":userId,
                @"payment":payment,
                @"type":type
                };
    }
    
    [self postWithMethodName:USER_SETPAYMENT data:dic success:^(id JSON) {
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

-(void)getPayment:(NSString *)userId type:(NSString *)type completion:(DMCompletionBlock)completion
{
    NSDictionary* dic = @{
                      
                          @"id":userId,
                          @"type":type
                          };
    [self postWithMethodName:GET_USER_PAYMENT data:dic success:^(id JSON) {
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

-(void)getCashList:(NSString *)userId page:(NSString *)pages completion:(DMCompletionBlock)completion
{
    NSDictionary* dic = @{
                      
                      @"user_id":userId,
                      @"pages":pages
                      };
    [self postWithMethodName:GET_CASH_LIST data:dic success:^(id JSON) {
        if ([JSON isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *dataDic = [JSON objectForKey:DATA];
            int status = [[dataDic objectForKey:STATUS] intValue];
            if (status == ResponseStatusSuccess)
            {
//                NSDictionary *objDict = [dataDic objectForKey:DATA];
                [goodsResponseEntity mj_setupObjectClassInArray:^NSDictionary *{
                    return @{@"data" : NSStringFromClass([withDrawlEntity class]),};
                }];
                
                goodsResponseEntity* response = [goodsResponseEntity mj_objectWithKeyValues:dataDic];
                
                completion(YES,nil,response);
//                if (![objDict isEqual:[NSNull null]])
//                {
//                    completion(YES,nil,response);
//                }
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

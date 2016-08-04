//
//  WebService+userManager.m
//  ziyige
//
//  Created by daimangkeji on 16/6/21.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "WebService+userManager.h"
#import "registerEntity.h"
#import "UserEntity.h"

@implementation WebService (userManager)

-(void)userRegister:(NSString *)phone  password:(NSString *)password completion:(DMCompletionBlock)completion
{
    NSString *passwordEny = [Util md5:password];
    
    NSDictionary* dic = @{@"phone_number":phone,@"password":passwordEny};
    [self postWithMethodName:USER_REGISTER data:dic success:^(id JSON) {
        if ([JSON isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *dataDic = [JSON objectForKey:DATA];
            int status = [[dataDic objectForKey:STATUS] intValue];
            
            if (status == ResponseStatusSuccess)
            {
                NSDictionary *objDict = [dataDic objectForKey:DATA];
                
                if (![objDict isEqual:[NSNull null]])
                {
                    
//                    [registerEntity map];
                    [UserEntity mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
                        return @{
                                 @"userId":@"id"
                                 };
                    }];
                    UserEntity *entity = [UserEntity mj_objectWithKeyValues:objDict];
                    entity.phoneNumber = phone;
                    entity.password = password;
                    completion(YES,nil,entity);
                }
            }
            else if (status == ResponseStatusFailed)
            {
                NSDictionary *objDict = [JSON objectForKey:DATA];
                NSString *message = SERVER_ERROE_MESSAGE;
                if (![objDict isEqual:[NSNull null]])
                {
                    message = [objDict objectForKey:RESULT_MESSAGE];
                }
                completion(YES,message,nil);            }
        }
    } failure:^(NSError *error, id JSON) {
        completion(NO,[error.userInfo objectForKey:NSLocalizedFailureReasonErrorKey],nil);
    }];
}

-(void)userLogin:(NSString *)phone password:(NSString *)password completion:(DMCompletionBlock)completion
{
    
    NSString *passwordEny = [Util md5:password];
    
    NSDictionary* dic = @{@"phone_number":phone,@"password":passwordEny};
    
    [self postWithMethodName:USER_LOGIN data:dic success:^(id JSON) {
        if ([JSON isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *dataDic = [JSON objectForKey:DATA];
            int status = [[dataDic objectForKey:STATUS] intValue];
            
            if (status == ResponseStatusSuccess)
            {
                NSDictionary *objDict = [dataDic objectForKey:DATA];
                
                if (![objDict isEqual:[NSNull null]])
                {
                    NSLog(@"%@",objDict);
                    [UserEntity mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
                        return @{
                                 @"userId":@"id"
                                 };
                    }];
                    UserEntity *entity = [UserEntity mj_objectWithKeyValues:objDict];
                    entity.phoneNumber = phone;
                    entity.password = password;
                    completion(YES,nil,entity);
                    
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

-(void)getVCode:(NSString *)phone completion:(DMCompletionBlock)completion
{
    NSDictionary* dic = @{@"phone_number":phone};
    [self postWithMethodName:SEND_CODE data:dic success:^(id JSON) {
        if ([JSON isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *dataDic = [JSON objectForKey:DATA];
            int status = [[dataDic objectForKey:STATUS] intValue];
            if (status == ResponseStatusSuccess)
            {
                NSDictionary *objDict = [dataDic objectForKey:DATA];
                if (![objDict isEqual:[NSNull null]])
                {
                    NSString* code = objDict[@"code"];
                    completion(YES,nil,code);
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

-(void)changeNickNameWithNewName:(NSString *)nickName completion:(DMCompletionBlock)completion
{
    UserEntity* user = [UserInfo info].currentUser;
    
    NSDictionary* dic = @{
                          @"user_name":nickName,
                          @"id":user.userId
                          };
    [self postWithMethodName:CHANGE_NICKNAME data:dic success:^(id JSON) {
        if ([JSON isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *dataDic = [JSON objectForKey:DATA];
            int status = [[dataDic objectForKey:STATUS] intValue];
            if (status == ResponseStatusSuccess)
            {
                NSDictionary *objDict = [dataDic objectForKey:DATA];
                if (![objDict isEqual:[NSNull null]])
                {
                    NSLog(@"%@",dataDic);
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

-(void)changePasswordWithphone:(NSString *)phone password:(NSString *)password completion:(DMCompletionBlock)completion
{
    NSDictionary* dic = @{
                          @"phone_number":phone,
                          @"password":password,
                          };
    [self postWithMethodName:CHANGE_PASSWORD data:dic success:^(id JSON) {
        if ([JSON isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *dataDic = [JSON objectForKey:DATA];
            int status = [[dataDic objectForKey:STATUS] intValue];
            if (status == ResponseStatusSuccess)
            {
                NSDictionary *objDict = [dataDic objectForKey:DATA];
                if (![objDict isEqual:[NSNull null]])
                {
                    NSLog(@"%@",dataDic);
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

-(void)changePhoto:(UIImage *)photo completion:(DMCompletionBlock)completion
{
    
    NSDictionary* dic = @{
                          @"photo":@"photo",
                          @"id":[UserInfo info].currentUser.userId
                          };
    [self postPhotoWithMethodName:CHANGE_PHOTO data:dic photo:photo success:^(id JSON) {
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

@end

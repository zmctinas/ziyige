//
//  WebService.m
//  DrivingOrder
//
//  Created by Pan on 15/5/19.
//  Copyright (c) 2015年 Pan. All rights reserved.
//

#import "WebService.h"
#import "Reachability.h"
#import "Util.h"

NSString *const METHOD_NAME     = @"service";
NSString *const DATA            = @"data";
NSString *const RESULT_MESSAGE  = @"msg";
NSString *const STATUS          = @"code";

@implementation WebService

+ (instancetype)service
{
    return [[[self class]alloc] initWithBaseURL:[NSURL URLWithString:BASEURL]];
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self)
    {
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer.timeoutInterval = 15;
        self.securityPolicy.allowInvalidCertificates = YES;
    }
    return self;
}


- (void)postWithMethodName:(NSString *)methodName data:(id)data success:(void (^)(id))success failure:(void (^)(NSError *, id))failure
{
    if (!data)
    {
        data = [NSDictionary dictionary];
    }
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:data];
    //methodName,METHOD_NAME,
    [parameters setObject:methodName forKey:METHOD_NAME];
//    [self postWithPath:PATH parameters:parameters token:nil success:success failure:failure];
    [self getWithPath:PATH parameters:parameters token:nil success:success failure:failure];
    NSLog(@" ==== %@",PATH);
}

-(void)postPhotoWithMethodName:(NSString *)methodName data:(id)data photo:(UIImage*)photo success:(void (^)(id))success failure:(void (^)(NSError *, id))failure
{
    if (!data)
    {
        data = [NSDictionary dictionary];
    }
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:data];
    //methodName,METHOD_NAME,
    [parameters setObject:methodName forKey:METHOD_NAME];
    //    [self postWithPath:PATH parameters:parameters token:nil success:success failure:failure];
    [self postPhotoWithPath:PATH parameters:parameters photo:photo success:success failure:failure];
}

-(void)postPhotoWithPath:(NSString *)path
              parameters:(NSDictionary *)parameters
                   photo:(UIImage *)image
                 success:(void (^)(id JSON))success
                 failure:(void (^)(NSError *error, id JSON))failure
{
    if ([self isReachable])
    {
        [self POST:path parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            NSData *imageData= UIImageJPEGRepresentation(image, 0.3);
            
            [formData appendPartWithFileData:imageData name:@"photo" fileName:@"photo.jpg"  mimeType:@"image/jpg"];
            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
            if (httpResponse.statusCode == 200) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"Received: %@ \n all above data received from method %@", [Util replaceUnicode:[responseObject description]],[parameters objectForKeyedSubscript:METHOD_NAME]);
                    
                    success(responseObject);
                });
            }else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"服务器出错了,稍后试试" forKey:NSLocalizedFailureReasonErrorKey];
                    NSError *error = [NSError errorWithDomain:[NSString stringWithFormat:@"%@%@",BASEURL,PATH] code:6000 userInfo:userInfo];
                    
                    failure(error, responseObject);
                    
                });
                NSLog(@"Received: %@ \n all above data received from method %@", [Util replaceUnicode:[responseObject description]],[parameters objectForKeyedSubscript:@"transCode"]);
                NSLog(@"Received HTTP %ld", (long)httpResponse.statusCode);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error.localizedFailureReason);
            NSLog(@"%@",error.localizedRecoverySuggestion);
            dispatch_async(dispatch_get_main_queue(), ^{
                NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:error.userInfo];
                if (![userInfo objectForKey:NSLocalizedFailureReasonErrorKey])
                {
                    [userInfo setObject:@"服务器出错了,稍后试试" forKey:NSLocalizedFailureReasonErrorKey];
                }
                failure(error, nil);
            });
            
        }];
    }
    else
    {
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:@"没有连接网络" forKey:NSLocalizedFailureReasonErrorKey];
        NSError *newError = [NSError errorWithDomain:@"Network" code:1001 userInfo:userInfo];
        failure(newError, nil);
    }
}

-(void)getWithPath:(NSString *)path
         parameters:(NSDictionary *)parameters
              token:(NSString *)token
            success:(void (^)(id JSON))success
            failure:(void (^)(NSError *error, id JSON))failure
{
    if ([self isReachable])
    {
        if (token)
        {
            [self.requestSerializer setValue:token forHTTPHeaderField:@"Authentication-Token"];
        }
        
        NSLog(@"POST DATA: %@", [Util replaceUnicode:[parameters description]]);
        
        
        
        //        [self POST:path parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //
        //        }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //
        //        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //
        //        }]
        
        [self GET:path parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
            if (httpResponse.statusCode == 200) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"Received: %@ \n all above data received from method %@", [Util replaceUnicode:[responseObject description]],[parameters objectForKeyedSubscript:METHOD_NAME]);
                    
                    //
                    //                    NSData *data = responseObject;
                    //                    NSString *baocuo = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                    //                    DLog(@"ERROR DATA:%@  \n all above data received from method %@",baocuo,[parameters objectForKeyedSubscript:@"transCode"]);
                    
                    success(responseObject);
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"服务器出错了,稍后试试" forKey:NSLocalizedFailureReasonErrorKey];
                    NSError *error = [NSError errorWithDomain:[NSString stringWithFormat:@"%@%@",BASEURL,PATH] code:6000 userInfo:userInfo];
                    
                    
                    failure(error, responseObject);
                    
                });
                NSLog(@"Received: %@ \n all above data received from method %@", [Util replaceUnicode:[responseObject description]],[parameters objectForKeyedSubscript:@"transCode"]);
                NSLog(@"Received HTTP %ld", (long)httpResponse.statusCode);
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            NSLog(@"%@",error.localizedFailureReason);
            dispatch_async(dispatch_get_main_queue(), ^{
                NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:error.userInfo];
                if (![userInfo objectForKey:NSLocalizedFailureReasonErrorKey])
                {
                    [userInfo setObject:@"服务器出错了,稍后试试" forKey:NSLocalizedFailureReasonErrorKey];
                }
                failure(error, nil);
            });
            
        }];
    }
    else
    {    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:@"没有连接网络" forKey:NSLocalizedFailureReasonErrorKey];
        NSError *newError = [NSError errorWithDomain:@"Network" code:1001 userInfo:userInfo];
        failure(newError, nil);
    }
}

- (void)postWithPath:(NSString *)path
         parameters:(NSDictionary *)parameters
              token:(NSString *)token
            success:(void (^)(id JSON))success
            failure:(void (^)(NSError *error, id JSON))failure
{
    if ([self isReachable])
    {
        if (token)
        {
            [self.requestSerializer setValue:token forHTTPHeaderField:@"Authentication-Token"];
        }
        
        NSLog(@"POST DATA: %@", [Util replaceUnicode:[parameters description]]);
        
        
        
//        [self POST:path parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
//            
//        }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//        }]

        
        [self POST:path parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
            if (httpResponse.statusCode == 200) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"Received: %@ \n all above data received from method %@", [Util replaceUnicode:[responseObject description]],[parameters objectForKeyedSubscript:@"transCode"]);
                    
//                    
//                    NSData *data = responseObject;
//                    NSString *baocuo = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//                    DLog(@"ERROR DATA:%@  \n all above data received from method %@",baocuo,[parameters objectForKeyedSubscript:@"transCode"]);
                    
                        success(responseObject);
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"服务器出错了,稍后试试" forKey:NSLocalizedFailureReasonErrorKey];
                    NSError *error = [NSError errorWithDomain:[NSString stringWithFormat:@"%@%@",BASEURL,PATH] code:6000 userInfo:userInfo];
                    
                    
                    failure(error, responseObject);
                    
                });
                NSLog(@"Received: %@ \n all above data received from method %@", [Util replaceUnicode:[responseObject description]],[parameters objectForKeyedSubscript:@"transCode"]);
                NSLog(@"Received HTTP %ld", (long)httpResponse.statusCode);
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:error.userInfo];
                if (![userInfo objectForKey:NSLocalizedFailureReasonErrorKey])
                {
                    [userInfo setObject:@"服务器出错了,稍后试试" forKey:NSLocalizedFailureReasonErrorKey];
                }
                failure(error, nil);
            });
            
        }];
    }
    else
    {    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:@"没有连接网络" forKey:NSLocalizedFailureReasonErrorKey];
        NSError *newError = [NSError errorWithDomain:@"Network" code:1001 userInfo:userInfo];
        failure(newError, nil);
    }
}



- (BOOL)isReachable
{
    BOOL isReachable = [WebService service].reachabilityManager.reachable;
    if (!isReachable) {
        Reachability *reachability = [Reachability reachabilityForInternetConnection];
        NetworkStatus networkStatus = [reachability currentReachabilityStatus];
        if (networkStatus != NotReachable) {
            isReachable = YES;
        }
        else {
            isReachable = NO;
        }
    }
    return isReachable;
}
@end

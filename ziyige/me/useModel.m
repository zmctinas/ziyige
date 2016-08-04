//
//  useModel.m
//  ziyige
//
//  Created by daimangkeji on 16/6/21.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "useModel.h"
#import "WebService+userManager.h"
#import "UserEntity.h"
#import "AppDelegate.h"


@implementation useModel

- (void)registerAccountWithUsername:(NSString *)username password:(NSString *)password
{
    //异步注册账号
    [self.webService userRegister:username password:password completion:^(BOOL isSuccess, NSString *message, id result) {
        if (isSuccess && message.length<1)
        {
            [self handleLoginSuccess:result];
            [[NSNotificationCenter defaultCenter] postNotificationName:REGISTER_NOTIFICATION object:result];
        }
        else
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:WebServiceErrorNotification object:message];
        }
    }];
}

-(void)loginAcountWithUsername:(NSString *)userName password:(NSString *)password
{
    [self.webService userLogin:userName password:password completion:^(BOOL isSuccess, NSString *message, id result) {
        if (isSuccess && message.length<1)
        {
            [self handleLoginSuccess:result];
            [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_NOTIFICATION object:result];
        }
        else
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:WebServiceErrorNotification object:message];
        }
    }];
}

-(void)getVCodeWithPhone:(NSString *)phone
{
    [self.webService getVCode:phone completion:^(BOOL isSuccess, NSString *message, id result) {
        if (isSuccess && message.length<1)
        {
            NSLog(@"%@",result);
            [[NSNotificationCenter defaultCenter] postNotificationName:SEND_CODE_NOTIFICATION object:result];
        }
        else
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:WebServiceErrorNotification object:message];
        }
    }];
}

- (void)changeNickName:(NSString *)nickName
{
    [self.webService changeNickNameWithNewName:nickName completion:^(BOOL isSuccess, NSString *message, id result) {
        if (isSuccess && message.length<1)
        {
            UserEntity* entity = [UserInfo info].currentUser;
            entity.user_name = nickName;
            [UserInfo info].currentUser = entity;
            [[NSNotificationCenter defaultCenter] postNotificationName:CHANGE_NICKNAME_NOTIFICATION object:result];
        }
        else
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:WebServiceErrorNotification object:message];
        }
    }];
}

- (void)changePassWord:(NSString *)phone password:(NSString *)password
{
    [self.webService changePasswordWithphone:phone password:password completion:^(BOOL isSuccess, NSString *message, id result) {
        if (isSuccess && message.length<1)
        {
            NSLog(@"%@",result);
            [[NSNotificationCenter defaultCenter] postNotificationName:CHANGE_PASSWORD_NOTIFICATION object:result];
        }
        else
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:WebServiceErrorNotification object:message];
        }
    }];
}

- (void)uploadPhoto:(UIImage *)image
{
    [self.webService changePhoto:image completion:^(BOOL isSuccess, NSString *message, id result) {
        if (isSuccess && message.length<1)
        {
            NSDictionary* dic = result;
            UserEntity* entity = [UserInfo info].currentUser;
            entity.photo = dic[@"photo"];
            [UserInfo info].currentUser = entity;
            [[NSNotificationCenter defaultCenter] postNotificationName:HEAD_PHOTO_GETTED_NOTIFICATION object:result];
        }
        else
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:WebServiceErrorNotification object:message];
        }
    }];
}

- (void)handleLoginSuccess:(id)result
{
    UserEntity *user = result;
    [UserInfo info].currentUser = user;//持久化用户
    //为Jpush注册别名
//    AppDelegate *appdelegete = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    [appdelegete registerJpushAlias];
    [ValidationManager setLoginStatus:YES];
}

@end

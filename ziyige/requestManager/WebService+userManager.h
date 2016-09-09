//
//  WebService+userManager.h
//  ziyige
//
//  Created by daimangkeji on 16/6/21.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "WebService.h"

@interface WebService (userManager)

/**
 *  用户注册
 *
 *  @param phone        手机号
 *  @param password     密码
 *  @param image        头像
 */
- (void)userRegister:(NSString *)phone
            password:(NSString *)password
              invite:(NSString*)inviteCode
          completion:(DMCompletionBlock)completion;

/**
 *  用户登录
 *
 *  @param phone      手机号
 *  @param password   密码
 *  @param completion
 */
- (void)userLogin:(NSString *)phone
         password:(NSString *)password
       completion:(DMCompletionBlock)completion;

/**
 *  获取验证码
 *
 *  @param phone      手机号
 *  @param completion
 */
- (void)getVCode:(NSString*)phone
      completion:(DMCompletionBlock)completion;

/**
 *  修改用户名
 *
 *  @param nickName   用户名
 *  @param completion
 */
-(void)changeNickNameWithNewName:(NSString*)nickName
                      completion:(DMCompletionBlock)completion;

/**
 *  修改密码
 *
 *  @param phone      电话号
 *  @param password   密码
 *  @param completion
 */
-(void)changePasswordWithphone:(NSString*)phone
                      password:(NSString*)password
                    completion:(DMCompletionBlock)completion;

/**
 *  上传头像
 *
 *  @param photo      头像
 *  @param completion
 */
-(void)changePhoto:(UIImage*)photo
        completion:(DMCompletionBlock)completion;


/**
 *  获取邀请码
 *
 *  @param userId     uid
 *  @param completion
 */
-(void)getInviteCode:(NSString*)userId
          completion:(DMCompletionBlock)completion;

/**
 *  获取邀请列表
 *
 *  @param inviteCode 邀请码
 *  @param pages      分页
 *  @param completion 
 */
-(void)getInviteList:(NSString*)inviteCode
                page:(NSString*)pages
          completion:(DMCompletionBlock)completion;


@end

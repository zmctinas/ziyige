//
//  useModel.h
//  ziyige
//
//  Created by daimangkeji on 16/6/21.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "rootModel.h"


@interface useModel : rootModel

/**
 *  注册账号
 *
 *  @param username 用户名
 *  @param password 密码
 */
- (void)registerAccountWithUsername:(NSString *)username password:(NSString *)password;

/**
 *  登录账号
 *
 *  @param userName 用户名
 *  @param password 密码
 */
- (void)loginAcountWithUsername:(NSString*)userName
                       password:(NSString*)password;

/**
 *  获取验证码
 *
 *  @param phone 电话号
 */
- (void)getVCodeWithPhone:(NSString*)phone;

/**
 *  修改昵称
 *
 *  @param nickName 新昵称
 */
- (void)changeNickName:(NSString*)nickName;

/**
 *  修改密码
 *
 *  @param phone    手机号
 *  @param password 密码
 */
- (void)changePassWord:(NSString*)phone
              password:(NSString*)password;

/**
 *  上传头像
 *
 *  @param image 新头像
 */
- (void)uploadPhoto:(UIImage*)image;


@end

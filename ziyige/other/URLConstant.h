//
//  URLConstant.h
//  ziyige
//
//  Created by daimangkeji on 16/6/17.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#ifndef URLConstant_h
#define URLConstant_h


static NSString * const BASEURL = @"http://www.daimang.net.cn/"; //BaseURL

#if DEBUG
static NSString * const PATH    = @"Public/ziyige/index.php";//只有一个接口
static NSString * const DAIMANG = @"daimang_test/";//如果图片路径是半截的，需要在BaseUrl和图片路径之间加上这个
static NSString * const ALIPAY_CALLBACK = @"http://123.59.56.108/daimang_test/pay/alipay/notify_url.php";
#else
static NSString * const PATH    = @"Public/ziyige/index.php";//只有一个接口
static NSString * const DAIMANG = @"daimang/";//如果图片路径是半截的，需要在BaseUrl和图片路径之间加上这个
static NSString * const ALIPAY_CALLBACK = @"http://123.59.56.108/daimang/pay/alipay/notify_url.php";

#endif

static NSString * const IMAGE_BASEURL = @"http://www.daimang.net.cn/";

//由于后台没有返回STATUS为Failure时候的原因，所以固定描述一下失败原因
static NSString * const SERVER_ERROE_MESSAGE = @"服务器出错了，请稍后再试";

//分享的网页URL前缀
static NSString * const SHARE_URL = @"http://share.daimang.com/share.php?shop_id=";

#pragma mark - Method name

static NSString * const USER_LOGIN                    = @"User.UserLogin";/**< 用户登陆*/
static NSString * const USER_LOGOUT                   = @"userLogout";/**< 用户登出*/

static NSString * const USER_REGISTER                 = @"User.UserReg";/**< 用户注册*/

static NSString * const CHANGE_PASSWORD               = @"User.UpdatePassword";/**< 修改密码*/

static NSString * const CHANGE_PHOTO                  = @"User.UpdatePhoto";/**< 修改头像*/

static NSString * const CHANGE_NICKNAME               = @"User.UpdateUserName";/**< 修改用户名*/

static NSString * const GOODS_LIST                    = @"Goods.Index";/**< 商品列表*/

static NSString * const GOODS_DETAIL                  = @"Goods.GetGoodsInfo";/**< 商品详情*/

static NSString * const SEND_CODE                     = @"User.SendCode";/**< 发送验证码*/

static NSString * const ADD_COLLECT                   = @"Collect.AddCollect";/**< 添加收藏*/

static NSString * const DEL_COLLECT                   = @"Collect.DelCollect";/**< 删除收藏*/

static NSString * const ADD_ADDRESS                   = @"Address.AddAddr";/**< 添加收货地址*/
static NSString * const DEL_ADDRESS                   = @"Address.DelAddr";/**< 删除收货地址*/
static NSString * const ADDRESS_LIST                  = @"Address.GetAddrList";/**< 获取收货地址列表*/
static NSString * const UPDATE_ADDRESS                = @"Address.UpdateAddr";/**< 编辑收货地址*/
static NSString * const SET_DEFAULT_ADDRESS           = @"Address.SetDef";/**< 设置默认收货地址*/
static NSString * const GET_DEFAULT_ADDRESS           = @"Address.GetDef";/**< 获取默认收货地址*/

static NSString * const CREATE_ORDER                  = @"Trade.AddTrade";/**< 添加订单*/

static NSString * const GET_ORDER_LIST                = @"Trade.GetTradeList";/**< 获取订单列表*/

static NSString * const GET_ORDER_DETAIL              = @"Trade.GetTradeInfo";/**< 获取订单详情*/

static NSString * const REQUEST_BACK                  = @"Trade.ApplicationBack";/**< 申请回购*/

static NSString * const SEND_GOODS                    = @"Trade.ConfirmOrder";/**< 发货*/

static NSString * const PAY_ORDER                     = @"pay.Unifiedorder";/**< 订单支付*/

static NSString * const GET_COLLECT_LIST              = @"Collect.GetCollectList";/**< 获取收藏列表*/

static NSString * const ADD_MESSAGE                   = @"Message.AddMessage";/**< 获取收藏列表*/

#endif /* URLConstant_h */

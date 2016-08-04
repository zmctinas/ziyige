//
//  fatherViewController.h
//  ziyige
//
//  Created by daimangkeji on 16/6/7.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface fatherViewController : UIViewController

/**
 *  @required
 *  收到请求时的响应方法，所有继承BaseViewController的子类都应该实现这个方法来响应通知。
 *
 *  @param notification NSNotification
 */
- (void)receivedNotification:(NSNotification *)notification;


/**
 *  为Controller添加通知。
 *  可选的，子类不一定非要实现这个行为。
 *
 *  @param notificationNames 通知名称数组
 */
- (void)addObserverForNotifications:(NSArray *)notificationNames;

@end

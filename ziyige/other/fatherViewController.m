//
//  fatherViewController.m
//  ziyige
//
//  Created by daimangkeji on 16/6/7.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "fatherViewController.h"

@interface fatherViewController ()

@end

@implementation fatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton* backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setFrame:CGRectMake(0, 0, 25, 30)];
    [backBtn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
    backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    //    backBtn.backgroundColor = [UIColor blackColor];
    [backBtn setImage:[UIImage imageNamed:@"icon_arrowleft"] forState:UIControlStateNormal];
    UIBarButtonItem* im = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    //    self.navigationItem.leftItemsSupplementBackButton = YES;
    
    self.navigationItem.leftBarButtonItem = im;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(webServiceError:) name:WebServiceErrorNotification object:nil];
    
    // Do any additional setup after loading the view.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webServiceError:(NSNotification *)notification
{
    for (UIView* view in self.view.subviews) {
        if ([view isKindOfClass:[UITableView class]]) {
            UITableView* tableView = (UITableView*)view;
//            if (tableView.header||tableView.footer) {
//                
//            }
        }
    }
//    if (self.tableView.header)
//    {
//        [self.tableView.header endRefreshing];
//    }
    
    if ([notification.object isKindOfClass:[NSString class]])
    {
        [self.view makeToast:notification.object];
    }
    else
    {
        [self.view makeToast:@"网络出错，请重试"];
    }
}

-(void)backBtn:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)addObserverForNotifications:(NSArray *)notificationNames
{
    for (NSString *name in notificationNames)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedNotification:) name:name object:nil];
    }
}


- (void)receivedNotification:(NSNotification *)notification
{
    //Override Point,收到通知的响应方法。
}
@end

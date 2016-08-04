//
//  setViewController.m
//  ziyige
//
//  Created by daimangkeji on 16/6/13.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "setViewController.h"
#import "feedBackViewController.h"

@interface setViewController ()



- (IBAction)feedBackBtn:(UIButton *)sender;

@end

@implementation setViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    
    self.hidesBottomBarWhenPushed = YES;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    self.tabBarController.tabBar.hidden = YES;
//    
//}
//
//-(void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    self.tabBarController.tabBar.hidden = NO;
//}

#pragma mark - xib

- (IBAction)feedBackBtn:(UIButton *)sender {
    
    feedBackViewController* feedBack = [[feedBackViewController alloc]init];
    [self.navigationController pushViewController:feedBack animated:YES];
    
}
@end

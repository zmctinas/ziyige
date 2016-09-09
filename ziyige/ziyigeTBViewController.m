//
//  ziyigeTBViewController.m
//  ziyige
//
//  Created by daimangkeji on 16/6/7.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "ziyigeTBViewController.h"
#import "mainViewController.h"
#import "meViewController.h"
#import "newsViewController.h"

@interface ziyigeTBViewController ()

@end

@implementation ziyigeTBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray* controlArr = @[@"main",@"me"];
    NSArray* titleArr = @[@"首页",@"我的"];
    NSArray* imageArr = @[@"icon_home",@"icon_me"];
    NSArray* selectImageArr = @[@"icon_home_pressed",@"icon_me_pressed"];
    NSMutableArray* controls = [NSMutableArray array];
    
    for (int i = 0 ; i < controlArr.count ; i++) {
        NSString* name = controlArr[i];
        NSString* controlName = [NSString stringWithFormat:@"%@ViewController",name];
        Class controlClass = NSClassFromString(controlName);
        UIViewController* VC = [[controlClass alloc]init];
        VC.title = name;
        UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:VC];
        [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"icon_bg_nav"]  forBarMetrics:UIBarMetricsDefault];
        
        UITabBarItem* tabBarItem = [[UITabBarItem alloc]initWithTitle:titleArr[i] image:[[UIImage imageNamed:imageArr[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:selectImageArr[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        [tabBarItem.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        nav.tabBarItem = tabBarItem;
        [controls addObject:nav];
    }
    self.tabBar.backgroundImage = [UIImage imageNamed:@"icon_bg_tabbar"];
    self.viewControllers = controls;
    
    UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 2)];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.image = [UIImage imageNamed:@"icon_line"];
    [self.tabBar addSubview:imageView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

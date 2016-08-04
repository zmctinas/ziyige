//
//  mainViewController.m
//  ziyige
//
//  Created by daimangkeji on 16/6/7.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "mainViewController.h"

#import "paintingsViewController.h"
#import "playthingViewController.h"
#import "potteryViewController.h"
#import "DCNavTabBarController.h"
#import "searchViewController.h"

@interface mainViewController ()

@property(strong,nonatomic)UIBarButtonItem* rightItem;

@end

@implementation mainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"子宜阁";
    
    [self addChilds];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    self.navigationItem.rightBarButtonItem = self.rightItem;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)addChilds
{
    NSArray* childArr = @[@"paintings",@"plaything",@"pottery",@"pottery",@"pottery",@"pottery"];
    NSArray* childtitle = @[@"字画",@"文玩",@"瓷器",@"瓷器",@"瓷器",@"瓷器"];
    NSMutableArray* childs = [NSMutableArray array];
    
    for (int i = 0 ; i < childArr.count ; i++) {
        NSString* str = childArr[i];
        NSString* childString = [NSString stringWithFormat:@"%@ViewController",str];
        Class childClass = NSClassFromString(childString);
        UIViewController* childVC = [[childClass alloc]init];
        childVC.title = childtitle[i];
        
        [childs addObject:childVC];
    }
    
    DCNavTabBarController *tabBarVC = [[DCNavTabBarController alloc]initWithSubViewControllers:childs];
    tabBarVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    
    [self.view addSubview:tabBarVC.view];
    [self addChildViewController:tabBarVC];
    
}

-(UIBarButtonItem*)rightItem
{
    if (!_rightItem) {
        UIButton* btn = [UIButton buttonWithType:0];
        btn.frame = CGRectMake(0, 0, 25, 25);
        [btn setTitleColor:[UIColor colorWithHexString:@"#1d252e"] forState:UIControlStateNormal];
//        [btn setTitle:@"提现记录" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn setImage:[UIImage imageNamed:@"icon_search"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(searchBtn:) forControlEvents:UIControlEventTouchUpInside];
        _rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    }
    return  _rightItem;
}

-(void)searchBtn:(UIButton*)sender
{
    searchViewController* search = [[searchViewController alloc]init];
    search.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:search animated:YES];
}

@end

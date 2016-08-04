//
//  searchViewController.m
//  ziyige
//
//  Created by daimangkeji on 16/8/4.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "searchViewController.h"

@interface searchViewController ()

- (IBAction)goBackBtn:(UIButton *)sender;

@end

@implementation searchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
}

#pragma mark - xib

- (IBAction)goBackBtn:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end

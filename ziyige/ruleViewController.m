//
//  ruleViewController.m
//  ziyige
//
//  Created by daimangkeji on 16/8/17.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "ruleViewController.h"

@interface ruleViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation ruleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"规则详情";
    //http://www.daimang.net.cn/rule/index.html
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.daimang.net.cn/rule/index.html"]]];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

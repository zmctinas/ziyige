//
//  aboutMeViewController.m
//  ziyige
//
//  Created by daimangkeji on 16/7/6.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "aboutMeViewController.h"

@interface aboutMeViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation aboutMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"关于我们";
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.0.140/ziyige/about/about.html"]]];
    
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

//
//  loginViewController.m
//  ziyige
//
//  Created by daimangkeji on 16/6/15.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "loginViewController.h"
#import "forgetViewController.h"
#import "registerViewController.h"
#import "useModel.h"

@interface loginViewController ()<UITextFieldDelegate>

@property(strong,nonatomic)useModel* model;
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;


- (IBAction)loginBtn:(UIButton *)sender;

- (IBAction)forgetBtn:(UIButton *)sender;
- (IBAction)regesterBtn:(UIButton *)sender;

- (IBAction)goBackBtn:(UIButton *)sender;

@end

@implementation loginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addObserverForNotifications:@[LOGIN_NOTIFICATION]];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

#pragma mark - getter

-(useModel*)model
{
    if (!_model) {
        _model = [[useModel alloc]init];
    }
    return _model;
}

#pragma mark - private

-(void)receivedNotification:(NSNotification *)notification
{
    if ([notification.name isEqualToString:LOGIN_NOTIFICATION]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/**
 *  账号密码是否为空
 */
- (BOOL)isEmpty
{
    BOOL ret = NO;
    NSString *mobile = self.userNameField.text;
    
    if (mobile.length<1)
    {
        ret = YES;
        //        DLog(@"手机号不能为空");
    }
    else if (mobile.length < 11)
    {
        ret = YES;
        //        DLog(@"手机号不正确");
    }
    
    return ret;
}

#pragma mark - xib

- (IBAction)loginBtn:(UIButton *)sender {
    
    if (![self isEmpty]) {
        if (_passwordField.text.length>0) {
            [self.model loginAcountWithUsername:_userNameField.text password:_passwordField.text];
        }else
        {
            [self.view makeToast:@"密码不能为空"];
        }
        
    }else
    {
        [self.view makeToast:@"请输入正确的手机号"];
    }
    
}

- (IBAction)forgetBtn:(UIButton *)sender {
    
    forgetViewController* forget = [[forgetViewController alloc]init];
    [self.navigationController pushViewController:forget animated:YES];
    
}

- (IBAction)regesterBtn:(UIButton *)sender {
    
    registerViewController* forget = [[registerViewController alloc]init];
    [self.navigationController pushViewController:forget animated:YES];
    
}

- (IBAction)goBackBtn:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end

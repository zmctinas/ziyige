//
//  registerViewController.m
//  ziyige
//
//  Created by daimangkeji on 16/6/15.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "registerViewController.h"
#import "useModel.h"

@interface registerViewController ()
{
    NSNumber* code;
    NSInteger Dnum;
}

@property(strong,nonatomic)useModel* model;

@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UITextField *userNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *VCodeLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordLabel;
@property (weak, nonatomic) IBOutlet UITextField *inviteLabel;
- (IBAction)getCodeBtn:(UIButton *)sender;
- (IBAction)registerBtn:(UIButton *)sender;

@end

@implementation registerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"注册";
    
    [self addObserverForNotifications:@[SEND_CODE_NOTIFICATION,REGISTER_NOTIFICATION]];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)receivedNotification:(NSNotification *)notification
{
    if ([notification.name isEqualToString:SEND_CODE_NOTIFICATION]) {
        NSLog(@"成功");
        code = notification.object;
    }else if([notification.name isEqualToString:REGISTER_NOTIFICATION])
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

#pragma Mark- private

/**
 *  账号密码是否为空
 */
- (BOOL)isEmpty
{
    BOOL ret = NO;
    NSString *mobile = self.userNameLabel.text;
    
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

-(void)timeDownBtn
{
    self.codeBtn.enabled = NO;
    if (Dnum) {
        [self.codeBtn setTitle:[NSString stringWithFormat:@"%lds",Dnum--] forState:UIControlStateDisabled];
        [self performSelector:@selector(timeDownBtn) withObject:nil afterDelay:1];
    }else
    {
        self.codeBtn.enabled = YES;
        [self.codeBtn setTitle:@"获取" forState:UIControlStateNormal];
    }
    
    
}

#pragma mark - getter

-(useModel*)model
{
    if (!_model) {
        _model = [[useModel alloc]init];
    }
    return _model;
}

#pragma mark - xib

- (IBAction)getCodeBtn:(UIButton *)sender {
    
    if (![self isEmpty]) {
        [self.model getVCodeWithPhone:_userNameLabel.text];
        Dnum = 60;
        [self timeDownBtn];
    }else
    {
        [self.view makeToast:@"手机号不正确"];
    }
    
}

- (IBAction)registerBtn:(UIButton *)sender {
    
    if (_VCodeLabel.text.integerValue == code.integerValue) {
        if (_passwordLabel.text.length>=6) {
            [self.model registerAccountWithUsername:_userNameLabel.text password:_passwordLabel.text invite:self.inviteLabel.text];
        }else
        {
            [self.view makeToast:@"密码至少6位"];
        }
        
    }else
    {
        [self.view makeToast:@"验证码不正确"];
    }
    
    
}
@end

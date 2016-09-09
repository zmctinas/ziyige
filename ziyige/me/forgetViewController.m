//
//  forgetViewController.m
//  ziyige
//
//  Created by daimangkeji on 16/6/15.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "forgetViewController.h"
#import "useModel.h"

@interface forgetViewController ()
{
    NSInteger Dnum;
    NSString* code;
}
@property(strong,nonatomic)useModel* model;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UITextField *mobileField;
@property (weak, nonatomic) IBOutlet UITextField *codeField;
@property (weak, nonatomic) IBOutlet UITextField *passWordField;


- (IBAction)codeBtn:(UIButton *)sender;

- (IBAction)tijiaoBtn:(UIButton *)sender;

@end

@implementation forgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"忘记密码";
    
    [self addObserverForNotifications:@[SEND_CODE_NOTIFICATION,CHANGE_PASSWORD_NOTIFICATION]];
    
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
    }else if([notification.name isEqualToString:CHANGE_PASSWORD_NOTIFICATION])
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
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

/**
 *  账号密码是否为空
 */
- (BOOL)isEmpty
{
    BOOL ret = NO;
    NSString *mobile = self.mobileField.text;
    
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

#pragma mark - getter

-(useModel*)model
{
    if (!_model) {
        _model = [[useModel alloc]init];
    }
    return _model;
}

- (IBAction)codeBtn:(UIButton *)sender {
    
    if (![self isEmpty]) {
        [self.model getVCodeWithPhone:_mobileField.text];
        Dnum = 60;
        [self timeDownBtn];
    }else
    {
        [self.view makeToast:@"手机号不正确"];
    }
    
}

- (IBAction)tijiaoBtn:(UIButton *)sender {
    
    if (_codeField.text.integerValue == code.integerValue) {
        if (_passWordField.text.length>=6) {
            [self.model changePassWord:self.mobileField.text password:self.passWordField.text];
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

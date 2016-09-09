//
//  aliAcountViewController.m
//  yuanli
//
//  Created by 代忙 on 16/4/6.
//  Copyright © 2016年 wxw. All rights reserved.
//

#import "aliAcountViewController.h"
#import "withRecordViewController.h"


@interface aliAcountViewController ()

@property (strong, nonatomic) IBOutlet UITextField *aliAcoutnField;

- (IBAction)withdrawalBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UITextField *realNameField;


@end

@implementation aliAcountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"支付宝账号";
    
//    [FrameSize MLBFrameSize:self.view];
    
    
    [self addObserverForNotifications:@[USER_PAYMENT_NOTIFICATION,USER_WITHDRAWL_NOTIFICATION]];
    
    // Do any additional setup after loading the view from its nib.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)receivedNotification:(NSNotification *)notification
{
    if ([notification.name isEqualToString:USER_PAYMENT_NOTIFICATION]) {
        [self requestMessage];
    }else if ([notification.name isEqualToString:USER_WITHDRAWL_NOTIFICATION])
    {
        withRecordViewController* record = [[withRecordViewController alloc]init];
        record.isRootPush = YES;
        [self.navigationController pushViewController:record animated:YES];
    }
}

-(void)addAli_pay
{
    
    [self.model setPayment:self.aliAcoutnField.text type:@"ali_pay" realName:self.realNameField.text];
    
}
-(void)requestMessage
{
    
    [self.model userWithDrawl:self.money type:@"ali_pay"];
    
}

- (IBAction)withdrawalBtn:(UIButton *)sender {
    
    if (![self.aliAcoutnField.text isEqualToString:[USERDefaults objectForKey:@"ali_pay"]]) {
        if (self.realNameField.text.length>0) {
            [self addAli_pay];
        }else
        {
            UIAlertAction* action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入真实姓名" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:action];
            [self presentViewController:alertController animated:YES completion:^{
                
            }];

        }
        
    }else
    {
        UIAlertAction* action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"账号已添加" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:action];
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
    }
    
    
    
}


@end

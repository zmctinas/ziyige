//
//  aliWithdrawalViewController.m
//  yuanli
//
//  Created by 代忙 on 16/3/26.
//  Copyright © 2016年 wxw. All rights reserved.
//

#import "aliWithdrawalViewController.h"
#import "withRecordViewController.h"
#import "aliAcountViewController.h"
#import "withDrawlModel.h"
#import "tipsViewController.h"

@interface aliWithdrawalViewController ()<alertDelegate>

@property(strong,nonatomic)withDrawlModel* model;
@property (strong, nonatomic) IBOutlet UITextField *acountField;
@property (strong, nonatomic) IBOutlet UITextField *reAliAcountField;
@property (strong, nonatomic) IBOutlet UIView *reView;
@property (strong, nonatomic) IBOutlet UIButton *changeBtn;
@property (weak, nonatomic) IBOutlet UIButton *withdrawalBtn;


- (IBAction)changeBtn:(UIButton *)sender;

- (IBAction)withDrawalBtn:(UIButton *)sender;

@end

@implementation aliWithdrawalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"支付宝账号";
    
//    [FrameSize MLBFrameSize:self.view];
    
    [self setUpUI];
    
//    if ([[USERDefaults objectForKey:@"ali_pay"] length]>0) {
//        self.acountField.text = [USERDefaults objectForKey:@"ali_pay"];
////        [self.changeBtn setTitle:@"修改" forState:UIControlStateNormal];
//    }
    
    [self.model getPayment:@"ali_pay"];
    
    [self addObserverForNotifications:@[USER_GET_PAYMENT_NOTIFICATION,USER_WITHDRAWL_NOTIFICATION]];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter

-(withDrawlModel*)model
{
    if (!_model) {
        _model = [[withDrawlModel alloc]init];
    }
    return _model;
}

#pragma mark - private

-(void)viewWillDissmiss
{
    withRecordViewController* record = [[withRecordViewController alloc]init];
    record.isRootPush = YES;
    [self.navigationController pushViewController:record animated:YES];
}

-(void)receivedNotification:(NSNotification *)notification
{
    if ([notification.name isEqualToString:USER_GET_PAYMENT_NOTIFICATION]) {
        NSLog(@"%@",notification.object);
        NSDictionary* dic = (NSDictionary*)notification.object;
        self.acountField.text = dic[@"ali_pay"];
    }else if ([notification.name isEqualToString:USER_WITHDRAWL_NOTIFICATION])
    {
        tipsViewController* alert = [[tipsViewController alloc]init];
        alert.delegate = self;
        alert.modalPresentationStyle = UIModalPresentationOverFullScreen;
        alert.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:alert animated:YES completion:^{
            
        }];
    }
}

-(void)setUpUI
{
//    self.changeBtn.layer.masksToBounds = YES;
//    self.changeBtn.layer.cornerRadius = 2;
//    self.changeBtn.layer.borderWidth = 1;
//    self.changeBtn.layer.borderColor = [UIColor colorWithHexString:@"#d82b2b"].CGColor;
//    
//    self.withdrawalBtn.layer.masksToBounds = YES;
//    self.withdrawalBtn.layer.cornerRadius = 2;
    
}

-(void)addAli_pay
{
    
//    NSDictionary* dic = @{@"service":AddAliPay_IF,
//                          
//                          @"user_id":UID,
//                          @"ali_pay":self.acountField.text,
//                          
//                          };
//    NSLog(@"%@",dic);
//    [HTTPRequest requestWitUrl:@"" andArgument:dic andType:WXHTTPRequestGet Finished:^(NSURLResponse *response, NSDictionary *requestDic) {
//        NSLog(@"%@",requestDic);
//        NSLog(@"%@",requestDic[@"msg"]);
//        
//        
//        if ([requestDic[@"data"][@"code"] isEqualToNumber:@1]) {
//            [USERDefaults setObject:self.acountField.text forKey:@"ali_pay"];
//            [USERDefaults synchronize];
//            [self requestMessage];
//        }else if ([requestDic[@"data"][@"code"] isEqualToNumber:@0])
//        {
//            NSLog(@"%@",requestDic[@"msg"]);
//            NSLog(@"%@",requestDic[@"data"][@"msg"]);
//        }
//        
//    } Falsed:^(NSError *error) {
//        
//    }];
}
-(void)requestMessage
{
    
    
//    [HTTPRequest requestWitUrl:@"" andArgument:_messageDic andType:WXHTTPRequestGet Finished:^(NSURLResponse *response, NSDictionary *requestDic) {
//        NSLog(@"%@",requestDic);
//        
//        if ([requestDic[@"data"][@"code"] isEqualToNumber:@0]) {
//            NSLog(@"%@",requestDic[@"data"][@"msg"]);
//            NSLog(@"%@",requestDic[@"msg"]);
//        }else if ([requestDic[@"data"][@"code"] isEqualToNumber:@1])
//        {
//            UIAlertAction* action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                withdrawalRecordViewController* record = [[withdrawalRecordViewController alloc]init];
//                record.isRootPush = YES;
//                [self.navigationController pushViewController:record animated:YES];
//            }];
//            UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"领取" message:@"领取信息已提交,请注意查收\n(预计72小时内到账，节假日顺延)" preferredStyle:UIAlertControllerStyleAlert];
//            [alertController addAction:action];
//            [self presentViewController:alertController animated:YES completion:^{
//                
//            }];
//            
//        }
//        
//    } Falsed:^(NSError *error) {
//        
//    }];
}

- (IBAction)changeBtn:(UIButton *)sender {
    
    aliAcountViewController* aliAcount = [[aliAcountViewController alloc]init];
    aliAcount.model = self.model;
    aliAcount.money = self.money;
    [self.navigationController pushViewController:aliAcount animated:YES];
    
}

- (IBAction)withDrawalBtn:(UIButton *)sender {
    
    if (self.acountField.text.length>0) {
        [self.model userWithDrawl:self.money type:@"ali_pay"];
    }else
    {
        UIAlertAction* action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入支付宝账号" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:action];
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
    }
    
}
@end

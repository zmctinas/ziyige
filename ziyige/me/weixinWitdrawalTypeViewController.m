//
//  weixinWitdrawalTypeViewController.m
//  yuanli
//
//  Created by 代忙 on 16/3/26.
//  Copyright © 2016年 wxw. All rights reserved.
//

#import "weixinWitdrawalTypeViewController.h"
#import "withRecordViewController.h"
#import "withDrawlModel.h"
#import "tipsViewController.h"

@interface weixinWitdrawalTypeViewController ()<alertDelegate>
{
    NSDictionary* codeDic;
}

@property(strong,nonatomic)withDrawlModel* model;
@property (strong, nonatomic) IBOutlet UITextField *acountField;

@property (weak, nonatomic) IBOutlet UIButton *clickBtn;
@property (weak, nonatomic) IBOutlet UIButton *withdrawalBtn;


- (IBAction)getAcountBtn:(UIButton *)sender;

- (IBAction)withDrawalBtn:(UIButton *)sender;


@end

@implementation weixinWitdrawalTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"微信账号";
    
//    [FrameSize MLBFrameSize:self.view];
    
//    if ([[USERDefaults objectForKey:@"wei_pay"] length]>0) {
//        self.acountField.text = [USERDefaults objectForKey:@"wei_pay"];
//    }
    
    [self setUpUI];
    
    [self.model getPayment:@"wei_pay"];
    
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
        
        NSDictionary* dic = (NSDictionary*)notification.object;
        self.acountField.text = dic[@"wei_pay"];
        self.withdrawalBtn.enabled = YES;
    }else if ([notification.name isEqualToString:USER_WITHDRAWL_NOTIFICATION])
    {
        tipsViewController* alert = [[tipsViewController alloc]init];
        alert.delegate = self;
        alert.modalPresentationStyle = UIModalPresentationOverFullScreen;
        alert.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:alert animated:YES completion:^{
            
        }];
    }else if ([notification.name isEqualToString:USER_PAYMENT_NOTIFICATION])
    {
        self.withdrawalBtn.enabled = YES;
    }
}

-(void)setUpUI
{
//    self.clickBtn.layer.masksToBounds = YES;
//    self.clickBtn.layer.cornerRadius = 2;
//    self.clickBtn.layer.borderWidth = 1;
//    self.clickBtn.layer.borderColor = [UIColor colorWithHexString:@"#d82b2b"].CGColor;
//    
//    self.withdrawalBtn.layer.masksToBounds = YES;
//    self.withdrawalBtn.layer.cornerRadius = 2;
    
}

-(void)requestdate
{
    
    
//    [HTTPRequest requestWitUrl:@"" andArgument:_messageDic andType:WXHTTPRequestGet Finished:^(NSURLResponse *response, NSDictionary *requestDic) {
//        NSLog(@"%@",requestDic);
//        
//        if ([requestDic[@"data"][@"code"] isEqualToNumber:@0]) {
//            NSLog(@"%@",requestDic[@"data"][@"msg"]);
//            NSLog(@"%@",requestDic[@"msg"]);
//        }else if ([requestDic[@"data"][@"code"] isEqualToNumber:@1])
//        {
//            withdrawalRecordViewController* record = [[withdrawalRecordViewController alloc]init];
//            record.isRootPush = YES;
//            [self.navigationController pushViewController:record animated:YES];
//        }
//        
//    } Falsed:^(NSError *error) {
//        
//    }];
}

-(void)requestMessage
{
    
//    NSDictionary* dic = @{@"service":GetOpenId_IF,
//                          
//                          @"user_id":UID,
//                          @"code":codeDic[@"code"],
//                          
//                          };
//    [HTTPRequest requestWitUrl:@"" andArgument:dic andType:WXHTTPRequestGet Finished:^(NSURLResponse *response, NSDictionary *requestDic) {
//        NSLog(@"%@",requestDic);
//        NSLog(@"%@",requestDic[@"msg"]);
//        
//        if ([requestDic[@"data"][@"code"] isEqualToNumber:@1]) {
//            self.acountField.text = requestDic[@"data"][@"data"][@"openid"];
//            [USERDefaults setObject:requestDic[@"data"][@"data"][@"openid"] forKey:@"wei_pay"];
//            [USERDefaults synchronize];
//        }
//        
//    } Falsed:^(NSError *error) {
//        
//    }];
}

-(void)sendAuthRequest
{
    
    [weixinObject getOpenid:^(NSDictionary *dic) {
        NSLog(@"%@",dic);
        
        codeDic = dic;
        
        self.acountField.text = dic[@"code"];
        [self.model setPayment:dic[@"code"] type:@"wei_pay" realName:@""];
    }];
}

#pragma mark - xib

- (IBAction)getAcountBtn:(UIButton *)sender {
    
    [self sendAuthRequest];
    
}

- (IBAction)withDrawalBtn:(UIButton *)sender {
    
    [self.model userWithDrawl:self.money type:@"wei_pay"];
    
}
@end

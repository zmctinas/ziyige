//
//  withDrawlViewController.m
//  yuanli
//
//  Created by 代忙 on 16/3/25.
//  Copyright © 2016年 wxw. All rights reserved.
//

#import "withDrawlViewController.h"
//#import "selectViewController.h"
//#import "withdrawalRecordViewController.h"
#import "aliWithdrawalViewController.h"
#import "weixinWitdrawalTypeViewController.h"
//#import "productListViewController.h"
//#import "tipsViewController.h"
//#import "productListViewController.h"
#import "withRecordViewController.h"

@interface withDrawlViewController ()
//<tipsDelegate>
{
    NSInteger selectIndex;
}

//@property(strong,nonatomic)UIBarButtonItem* rightItem;

@property(strong,nonatomic)UIBarButtonItem* rightItem;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@property (strong, nonatomic) IBOutlet UITextField *moneyField;

@property (strong, nonatomic) IBOutlet UILabel *crashLabel;

@property (weak, nonatomic) IBOutlet UIButton *gobuyBtn;

- (IBAction)gobuyBtn:(UIButton *)sender;

- (IBAction)nextBtn:(UIButton *)sender;
- (IBAction)selectBtn:(UIButton *)sender;

@end

@implementation withDrawlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"提现";
    
//    [FrameSize MLBFrameSize:self.view];
    
    selectIndex = 10;
    
    self.navigationItem.rightBarButtonItem = self.rightItem;
    
    [self refreshUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIBarButtonItem*)rightItem
{
    if (!_rightItem) {
        UIButton* btn = [UIButton buttonWithType:0];
        btn.frame = CGRectMake(0, 0, 80, 30);
        [btn setTitleColor:[UIColor colorWithHexString:@"#1d252e"] forState:UIControlStateNormal];
        [btn setTitle:@"提现记录" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn addTarget:self action:@selector(recordBtn:) forControlEvents:UIControlEventTouchUpInside];
        _rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    }
    return  _rightItem;
}

-(void)recordBtn:(UIButton*)sender
{
    withRecordViewController* with = [[withRecordViewController alloc]init];
    [self.navigationController pushViewController:with animated:YES];
}

-(void)refreshUI
{
    
    NSString* attStr = [NSString stringWithFormat:@"可领取余额%@元",_remainderMoney];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:attStr];
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#808080"] range:NSMakeRange(0, 5)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#d82b2b"] range:NSMakeRange(5,attStr.length - 5)];
    self.crashLabel.attributedText = str;
    
    self.nextBtn.layer.cornerRadius = 4;
    self.nextBtn.layer.masksToBounds = YES;
    self.gobuyBtn.layer.cornerRadius = 4;
    self.gobuyBtn.layer.masksToBounds = YES;
}

-(void)pushController:(NSNumber *)type
{
    if ([type isEqualToNumber:@2]) {
//        selectViewController* select = [[selectViewController alloc]init];
//        
//        select.money = self.moneyField.text;
//        
//        [self.navigationController pushViewController:select animated:YES];
    }else
    {
//        productListViewController* product = [[productListViewController alloc]init];
//        [USERDefaults setBool:YES forKey:@"isList"];
//        [USERDefaults synchronize];
//        [self.navigationController pushViewController:product animated:YES];
    }
    
}

- (IBAction)gobuyBtn:(UIButton *)sender {
    
//    productListViewController* list = [[productListViewController alloc]init];
//    [self.navigationController pushViewController:list animated:YES];
    
}

- (IBAction)nextBtn:(UIButton *)sender {
    
    
    
//    NSLog(@"---%@  ===%@ ",_moneyField.text,_remainderMoney);
//    if ([_moneyField.text floatValue]>0&&[_moneyField.text floatValue]<=[_remainderMoney floatValue]) {
//        
//        tipsViewController* sign = [[tipsViewController alloc]init];
//        
//        sign.delegate = self;
//        sign.modalPresentationStyle = UIModalPresentationOverFullScreen;
//        sign.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//        [self presentViewController:sign animated:YES completion:^{
//            
//        }];
//        NSDictionary* dic = @{@"service":Withdrawal_IF,
//                              
//                              @"user_id":UID,
//                              @"money":[NSNumber numberWithFloat:self.moneyField.text.floatValue],
//                              @"type":selectIndex==10?@"ali_pay":@"wei_pay",
//                              
//                              };
        switch (selectIndex) {
            case 10:
            {
                aliWithdrawalViewController* ali = [[aliWithdrawalViewController alloc]init];
//                ali.messageDic = dic;
                [self.navigationController pushViewController:ali animated:YES];
            }
                break;
            case 11:
            {
                weixinWitdrawalTypeViewController* ali = [[weixinWitdrawalTypeViewController alloc]init];
//                ali.messageDic = dic;
                [self.navigationController pushViewController:ali animated:YES];
            }
                break;
                
            default:
                break;
        }
//    }else
//    {
//        [self.view makeToast:@"请输入正确的金额"];
//    }
    
    

}

- (IBAction)selectBtn:(UIButton *)sender {
    
    sender.selected = YES;
    selectIndex = sender.tag;
    for (int i = 0 ; i < 2; i++) {
        UIButton* btn = (UIButton*)[self.view viewWithTag:10+i];
        if (btn.tag != sender.tag) {
            btn.selected = NO;
        }
    }
    
}

@end


//
//  inviteViewController.m
//  yuanli
//
//  Created by daimangkeji on 16/7/13.
//  Copyright © 2016年 wxw. All rights reserved.
//

#import "inviteViewController.h"
//#import "detailRuleViewController.h"
#import "inviteShareViewController.h"
#import "PSCopyLabel.h"
#import "inviteFriendViewController.h"


@interface inviteViewController ()

@property (weak, nonatomic) IBOutlet UIButton *inviteFriend;
@property (weak, nonatomic) IBOutlet UILabel *atteLabel;
@property (weak, nonatomic) IBOutlet PSCopyLabel *invitationLabel;



- (IBAction)detailRuleBtn:(UIButton *)sender;

- (IBAction)inviteFriend:(UIButton *)sender;


@end

@implementation inviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"邀请好友";
    
    
//    [FrameSize MLBFrameSize:self.view];
    
    
    self.inviteFriend.layer.masksToBounds = YES;
    self.inviteFriend.layer.cornerRadius = self.inviteFriend.frame.size.height/2;
    
    [self requsetData];
    
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private

-(void)requsetData
{
//    NSDictionary* dic = @{
//                          @"service":GetInvitation_IF,
//                          @"user_id":UID,
//                          };
//    NSLog(@"%@",dic);
//    [HTTPRequest requestWitUrl:GetInvitation_IF andArgument:dic andType:WXHTTPRequestGet Finished:^(NSURLResponse *response, NSDictionary *requestDic) {
//        NSDictionary* data = requestDic[@"data"];
//        NSNumber* code = data[@"code"];
//        
//        NSLog(@"%@",data);
//        if ([code isEqualToNumber:@1]) {
//            NSDictionary* dic = data[@"data"];
//            self.invitationLabel.text = dic[@"invitation_code"];
//        }
//        
//    } Falsed:^(NSError *error) {
//        
//    }];
}

#pragma mark - xib

- (IBAction)detailRuleBtn:(UIButton *)sender {
    
    inviteFriendViewController* friend = [[inviteFriendViewController alloc]init];
    [self.navigationController pushViewController:friend animated:YES];
    
}

- (IBAction)inviteFriend:(UIButton *)sender {
    
    inviteShareViewController* alert = [[inviteShareViewController alloc]init];
    alert.yaoqingma = self.invitationLabel.text;
    alert.modalPresentationStyle = UIModalPresentationOverFullScreen;
    alert.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
}
@end

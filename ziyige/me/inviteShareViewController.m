//
//  inviteShareViewController.m
//  yuanli
//
//  Created by daimangkeji on 16/7/14.
//  Copyright © 2016年 wxw. All rights reserved.
//

#import "inviteShareViewController.h"
#import "FrameSize.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <MessageUI/MFMessageComposeViewController.h>

@interface inviteShareViewController ()<MFMessageComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *animotionView;

- (IBAction)shareBtn:(UIButton *)sender;
- (IBAction)disBtn:(UIButton *)sender;

@end

@implementation inviteShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [FrameSize MLBFrameSize:self.view];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self addAnimotion];
}

-(void)addAnimotion
{
    CABasicAnimation *animation =
    [CABasicAnimation animationWithKeyPath:@"position"];
    
    animation.duration = 1; // 动画持续时间
    animation.repeatCount = 1; // 不重复
    animation.beginTime = CACurrentMediaTime(); // 2秒后执行
    animation.autoreverses = NO; // 结束后执行逆动画
    animation.speed = 2.0;
    
    // 动画先加速后减速
    animation.timingFunction =
    [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
    
    // 设定动画起始帧和结束帧
    //    animation.fromValue = [NSValue valueWithCGRect:CGRectMake(0, 568*[FrameSize proportionWidth], 320*[FrameSize proportionWidth], 319*[FrameSize proportionWidth])]; // 起始点
    //    animation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 249*[FrameSize proportionWidth], 320*[FrameSize proportionWidth], 319*[FrameSize proportionWidth])]; // 终了点
    
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(_animotionView.layer.position.x, _animotionView.frame.size.height + _animotionView.layer.position.y)];
    animation.toValue = [NSValue valueWithCGPoint:_animotionView.layer.position];
    [_animotionView.layer addAnimation:animation forKey:@"move-layer"];
}

-(void)share:(SSDKPlatformType)type
{
    //1、创建分享参数（必要）
    
//        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
//        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//        NSString* curentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    //
    //    NSArray* time = [curentDateStr componentsSeparatedByString:@"-"];
    //    NSString* day = [time lastObject];
    
    NSString* content = [NSString stringWithFormat:@"边运动，边赚钱的app，赶快来试用吧，邀请他人有奖金！"];
//    NSLog(@"%@",[NSString stringWithFormat:@"%@?user_id=%@&date=%@",SHAREURL,UID,@""]);
    NSString* urlStr = @"http://api.daimang.com/Public/admin/index.php?service=User.share&invitation_code=";
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:content
                                     images:[UIImage imageNamed:@"1024X1024.png"]
                                        url:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",urlStr,self.yaoqingma]]
                                      title:@"原力分享"
                                       type:SSDKContentTypeWebPage];
    
    
    switch (type) {
        case SSDKPlatformSubTypeQZone:
        {
            [shareParams SSDKSetupQQParamsByText:content title:@"原力分享" url:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",urlStr,self.yaoqingma]] thumbImage:nil image:[UIImage imageNamed:@"1024X1024.png"] type:SSDKContentTypeAuto forPlatformSubType:SSDKPlatformSubTypeQZone];
        }
            break;
        case SSDKPlatformSubTypeWechatSession:
        {
            [shareParams SSDKSetupWeChatParamsByText:content title:@"原力分享" url:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",urlStr,self.yaoqingma]]thumbImage:nil image:[UIImage imageNamed:@"1024X1024.png"] musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil type:SSDKContentTypeAuto forPlatformSubType:SSDKPlatformSubTypeWechatSession];
        }
            break;
        case SSDKPlatformSubTypeWechatTimeline:
        {
            
            [shareParams SSDKSetupWeChatParamsByText:content title:@"原力分享" url:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",urlStr,self.yaoqingma]] thumbImage:[UIImage imageNamed:@"1024X1024"] image:[UIImage imageNamed:@"1024X1024"] musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil type:SSDKContentTypeAuto forPlatformSubType:SSDKPlatformSubTypeWechatTimeline];
        }
            break;
        case SSDKPlatformTypeSinaWeibo:
        {
            
            [shareParams SSDKEnableUseClientShare];
            [shareParams SSDKSetupSinaWeiboShareParamsByText:content title:@"原力分享" image:[UIImage imageNamed:@"1024X1024.png"] url:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",urlStr,self.yaoqingma]] latitude:0 longitude:0 objectID:nil type:SSDKContentTypeWebPage];
        }
            break;
        case SSDKPlatformTypeQQ:
        {
            [shareParams SSDKSetupQQParamsByText:content title:@"原力分享" url:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",urlStr,self.yaoqingma]] thumbImage:nil image:[UIImage imageNamed:@"1024X1024.png"] type:SSDKContentTypeAuto forPlatformSubType:SSDKPlatformTypeQQ];
        }
            break;
            
        default:
            break;
    }
    
    
    //
    //    // 定制微信好友的分享内容
    //    // 微信好友子平台
    //
    //
    
    //
    
    //2、分享
    [ShareSDK share:type parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
        switch (state) {
            case SSDKResponseStateSuccess:
            {
                NSLog(@"fenxiangchenggong");
                
                
                break;
            }
            case SSDKResponseStateFail:
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                message:[NSString stringWithFormat:@"%@",error]
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
                [alert show];
                break;
            }
            default:
                break;
        }
    }];
}

- (void)sendSMS:(NSString *)bodyOfMessage recipientList:(NSArray *)recipients
{
    
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init] ;
    
    if([MFMessageComposeViewController canSendText])
        
    {
        
        controller.body = bodyOfMessage;
        
        controller.recipients = recipients;
        
        controller.messageComposeDelegate = self;
        
        [self presentViewController:controller animated:YES completion:^{
            
        }];
        
    }
    
}

// 处理发送完的响应结果
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    if (result == MessageComposeResultCancelled)
        NSLog(@"Message cancelled");
    else if (result == MessageComposeResultSent)
    {
        NSLog(@"Message sent");
        [self.view makeToast:@"短信发送成功!"];
        
    }
    else
    {
        NSLog(@"Message failed")  ;
        
    }
}

- (IBAction)shareBtn:(UIButton *)sender {
    
    SSDKPlatformType type ;
    
    switch (sender.tag) {
        case 10:
        {
            type = SSDKPlatformSubTypeQZone;
        }
            break;
        case 11:
        {
            type = SSDKPlatformSubTypeWechatSession;
        }
            break;
        case 12:
        {
            type = SSDKPlatformSubTypeWechatTimeline;
        }
            break;
        case 13:
        {
            type = SSDKPlatformTypeSinaWeibo;
        }
            break;
        case 14:
        {
            type = SSDKPlatformTypeQQ;
        }
            break;
        case 15:
        {
            //            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"sms://10000"]];
            //            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"sms://原力app：边运动边赚钱！快来下载吧！ 请戳-> https://appsto.re/cn/ZrcObb.i"]];
            [self sendSMS:@"边运动，边赚钱的app，赶快来试用吧，邀请他人有奖金！请戳-> https://appsto.re/cn/ZrcObb.i" recipientList:@[]];
            return;
        }
            break;
            
        default:
            break;
    }
    
    //    SSDKPlatformTypeSinaWeibo
    //    SSDKPlatformSubTypeWechatTimeline
    //    SSDKPlatformSubTypeWechatSession
    //    SSDKPlatformSubTypeQZone
    //    SSDKPlatformTypeQQ
    [self share:type];
    
}

- (IBAction)disBtn:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}
@end

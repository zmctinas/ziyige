
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
#import "inviteModel.h"
#import <CoreImage/CoreImage.h>


@interface inviteViewController ()

@property(strong,nonatomic)inviteModel* model;
@property (weak, nonatomic) IBOutlet UIButton *inviteFriend;
@property (weak, nonatomic) IBOutlet UILabel *atteLabel;
@property (weak, nonatomic) IBOutlet PSCopyLabel *invitationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *qcodeView;



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
    
    [self.model getInviteCode];
    
    [self addObserverForNotifications:@[USER_INVITE_NOTIFICATION]];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private

-(void)createQcodeImageView:(NSString*)invitecode
{
    // 1.创建过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2.恢复默认
    [filter setDefaults];
    // 3.给过滤器添加数据
    NSString *dataString = [NSString stringWithFormat:@"%@%@",@"http://www.daimang.net.cn/share/invite.php?invite_code=",invitecode];
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    // 4.通过KVO设置滤镜inputMessage数据
    [filter setValue:data forKeyPath:@"inputMessage"];
    // 4.获取输出的二维码
    CIImage *outputImage = [filter outputImage];
    // 5.将CIImage转换成UIImage，并放大显示
    self.qcodeView.image = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:200];
}

-(void)receivedNotification:(NSNotification *)notification
{
    if ([notification.name isEqualToString:USER_INVITE_NOTIFICATION]) {
        
        NSDictionary* dic = (NSDictionary*)notification.object;
        NSLog(@"%@",dic);
        self.invitationLabel.text = dic[@"invite_code"];
        [self createQcodeImageView:dic[@"invite_code"]];
    }
}

- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}


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

#pragma mark - getter

-(inviteModel*)model
{
    if (!_model) {
        _model = [[inviteModel alloc]init];
    }
    return _model;
}

#pragma mark - xib

- (IBAction)detailRuleBtn:(UIButton *)sender {
    
    inviteFriendViewController* friend = [[inviteFriendViewController alloc]init];
    friend.inviteCode = self.invitationLabel.text;
    [self.navigationController pushViewController:friend animated:YES];
    
}

- (IBAction)inviteFriend:(UIButton *)sender {
    
    if (self.invitationLabel.text.length>0) {
        inviteShareViewController* alert = [[inviteShareViewController alloc]init];
        alert.yaoqingma = self.invitationLabel.text;
        alert.modalPresentationStyle = UIModalPresentationOverFullScreen;
        alert.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:alert animated:YES completion:^{
            
        }];
    }
    
    
    
}
@end

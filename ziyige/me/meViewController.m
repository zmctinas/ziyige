//
//  meViewController.m
//  ziyige
//
//  Created by daimangkeji on 16/6/7.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "meViewController.h"
#import "myCountViewController.h"
#import "setViewController.h"
#import "loginViewController.h"
#import "nickNameViewController.h"
#import "useModel.h"
#import "aboutMeViewController.h"
#import "albumViewController.h"
#import "inviteViewController.h"

@interface meViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(strong,nonatomic)useModel* model;
@property(strong,nonatomic)UserEntity* user;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property(strong,nonatomic) UIImagePickerController* imagePicker;

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
- (IBAction)loginBtn:(UIButton *)sender;

- (IBAction)myCountBtn:(UIButton *)sender;
- (IBAction)setBtn:(UIButton *)sender;
- (IBAction)asMeBtn:(UIButton *)sender;
- (IBAction)inviteCodeBtn:(UIButton *)sender;


@end

@implementation meViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addImageAction];
    [self setUpUI];
    
    [self addObserverForNotifications:@[HEAD_PHOTO_GETTED_NOTIFICATION]];
    
//    [ValidationManager setLoginStatus:NO];
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
    
    if ([ValidationManager isLogin]) {
        [self setUI];
    }
    
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

- (UIImagePickerController *)imagePicker
{
    if (_imagePicker == nil) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.modalPresentationStyle= UIModalPresentationOverFullScreen;
        _imagePicker.allowsEditing = YES;
        _imagePicker.delegate = self;
    }
    
    return _imagePicker;
}

#pragma mark - private

-(void)receivedNotification:(NSNotification *)notification
{
    if ([notification.name isEqualToString:HEAD_PHOTO_GETTED_NOTIFICATION]) {
        
    }
}

-(void)setUI
{
    self.user = [UserInfo info].currentUser;
//    self.loginBtn.selected = YES;
    if (self.user.user_name.length) {
        [self.loginBtn setTitle:self.user.user_name forState:UIControlStateNormal];
    }else
    {
        [self.loginBtn setTitle:@"藏友" forState:UIControlStateNormal];
    }
    [self.loginBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    
    if (self.user.photo.length>0) {
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_BASEURL,self.user.photo]] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRefreshCached];
    }
    
}

-(void)setUpUI
{
    _iconView.layer.masksToBounds = YES;
    _iconView.layer.cornerRadius = _iconView.frame.size.width/2;
}

-(void)changephoto:(UIImage*)image
{
    _iconView.image = image;
    [self.model uploadPhoto:image];
}

-(void)addImageAction
{
    UITapGestureRecognizer* tap= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchHeadImage:)];
    [_iconView addGestureRecognizer:tap];
}

-(void)touchHeadImage:(UITapGestureRecognizer*)tap
{
    
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"请选择方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"手机相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        
        [self presentViewController:self.imagePicker animated:YES completion:NULL];
    }];
    UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        //    self.imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
        [self presentViewController:self.imagePicker animated:YES completion:NULL];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:deleteAction];
    [alertController addAction:archiveAction];
    [self presentViewController:alertController animated:YES completion:^{
        
    }];

//    albumViewController* album = [[albumViewController alloc]init];
//    album.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:album animated:YES];
    
}

#pragma mark - xib



- (IBAction)loginBtn:(UIButton *)sender {

    if (![ValidationManager isLogin]) {
        loginViewController* login = [[loginViewController alloc]init];
        login.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:login animated:YES];
    }else
    {
        nickNameViewController* nickName = [[nickNameViewController alloc]init];
        nickName.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nickName animated:YES];
    }
    
    
}

- (IBAction)myCountBtn:(UIButton *)sender {
    
    myCountViewController* mycount = [[myCountViewController alloc]init];
    mycount.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mycount animated:YES];
    
}

- (IBAction)setBtn:(UIButton *)sender {
    
    setViewController* set = [[setViewController alloc]init];
    set.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:set animated:YES];
    
}

- (IBAction)asMeBtn:(UIButton *)sender {
    
    aboutMeViewController* about = [[aboutMeViewController alloc]init];
    about.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:about animated:YES];
    
}

- (IBAction)inviteCodeBtn:(UIButton *)sender {
    
    inviteViewController* invite = [[inviteViewController alloc]init];
    [self.navigationController pushViewController:invite animated:YES];
    
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *orgImage = info[UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self performSelector:@selector(changephoto:) withObject:orgImage afterDelay:0.1];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
}
@end

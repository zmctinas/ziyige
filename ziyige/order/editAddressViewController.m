//
//  editAddressViewController.m
//  ziyige
//
//  Created by daimangkeji on 16/6/24.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "editAddressViewController.h"
#import "addressPickerViewController.h"

#import "addressModel.h"

@interface editAddressViewController ()<UITextViewDelegate>


@property(strong,nonatomic)addressModel* model;


@property(strong,nonatomic)UIBarButtonItem* reightItem;

@property (weak, nonatomic) IBOutlet UITextField *addressNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *addressPhoneLabel;

@property (weak, nonatomic) IBOutlet UITextView *addtessDetialView;



@property (weak, nonatomic) IBOutlet UIButton *addressBtn;

- (IBAction)addressBtn:(UIButton *)sender;


@end

@implementation editAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"编辑地址";
    
    self.navigationItem.rightBarButtonItem = self.reightItem;
    
    if (_entity) {
        [self setUpUI];
        _isCreate = YES;
    }
    
    [self addObserverForNotifications:@[SELECT_AREA_NOTIFICATION,ADD_AREA_NOTIFICATION,EDIT_AREA_NOTIFICATION]];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private

-(void)setUpUI
{
    _addressNameLabel.text = self.entity.link_name;
    _addressPhoneLabel.text = self.entity.tel_num;
    _addtessDetialView.text = self.entity.address;
    [_addressBtn setTitle:[NSString stringWithFormat:@"%@/%@/%@",self.entity.province,self.entity.city,self.entity.district] forState:UIControlStateNormal];
}

-(void)receivedNotification:(NSNotification *)notification
{
    if ([notification.name isEqualToString:SELECT_AREA_NOTIFICATION]) {
        [self changeBtnTitle];
    }else if([notification.name isEqualToString:ADD_AREA_NOTIFICATION])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }else if ([notification.name isEqualToString:EDIT_AREA_NOTIFICATION])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)changeBtnTitle
{
    [self.addressBtn setTitle:[NSString stringWithFormat:@"%@/%@/%@",self.entity.province,self.entity.city,self.entity.district] forState:UIControlStateNormal];
}

-(void)touchRightItem:(UIButton*)sender
{
    UserEntity* entity = [UserInfo info].currentUser;
    if (_isCreate) {
        
        self.entity.user_id = entity.userId;
        self.entity.link_name = _addressNameLabel.text;
        self.entity.tel_num = _addressPhoneLabel.text;
        self.entity.address = _addtessDetialView.text;
        
        [self.model editAddress:self.entity];
    }else
    {
        if (_addtessDetialView.text.integerValue) {
            NSLog(@"fawe");
        }
        if (_addressPhoneLabel.text.integerValue) {
            NSLog(@"1231");
        }
        if (_addressNameLabel.text.integerValue) {
            NSLog(@"we332");
        }
        
        self.entity.user_id = entity.userId;
        if (_addressNameLabel.text.length>0&&_addressPhoneLabel.text.length>0&&_addtessDetialView.text.length>0) {
            self.entity.link_name = _addressNameLabel.text;
            self.entity.tel_num = _addressPhoneLabel.text;
            self.entity.address = _addtessDetialView.text;
            
            [self.model addAddress:self.entity];
        }else{
            [self.view makeToast:@"请输入地址信息"];
        }
        
    }
    
}

#pragma mark - getter

-(UIBarButtonItem*)reightItem
{
    if (!_reightItem) {
        UIButton* btn = [UIButton buttonWithType:0];
        btn.frame = CGRectMake(0, 0, 40, 30);
        [btn setTitle:@"完成" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#1d252e"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(touchRightItem:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        _reightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    }
    return _reightItem;
}

-(addressModel*)model
{
    if (!_model) {
        _model = [[addressModel alloc]init];
    }
    return _model;
}

-(addressEntity*)entity
{
    if (!_entity) {
        _entity = [[addressEntity alloc]init];
    }
    return _entity;
}

#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
    if ([textView.text isEqualToString:@"请输入详情地址"]) {
        textView.text = @"";
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"请输入详情地址";
    }
}

#pragma mark - xib

- (IBAction)addressBtn:(UIButton *)sender {
    
    addressPickerViewController* alert = [[addressPickerViewController alloc]init];
    alert.entity = self.entity;
    alert.modalPresentationStyle = UIModalPresentationOverFullScreen;
    alert.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
}
@end

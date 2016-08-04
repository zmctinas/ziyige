//
//  nickNameViewController.m
//  ziyige
//
//  Created by daimangkeji on 16/6/21.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "nickNameViewController.h"
#import "useModel.h"

@interface nickNameViewController ()

@property(strong,nonatomic)useModel* model;
@property(strong,nonatomic)UIBarButtonItem* rightItem;
@property (weak, nonatomic) IBOutlet UITextField *nickNameField;

@end

@implementation nickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改昵称";
    self.navigationItem.rightBarButtonItem = self.rightItem;
    
    [self addObserverForNotifications:@[CHANGE_NICKNAME_NOTIFICATION]];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private

-(void)receivedNotification:(NSNotification *)notification
{
    if ([notification.name isEqualToString:CHANGE_NICKNAME_NOTIFICATION]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)touchRightItem:(UIButton*)sender
{
    if (_nickNameField.text.length>0) {
        [self.model changeNickName:_nickNameField.text];
    }
}

#pragma mark - getter

-(useModel*)model
{
    if (!_model) {
        _model = [[useModel alloc]init];
    }
    return _model;
}

-(UIBarButtonItem*)rightItem
{
    if (!_rightItem) {
        
        UIButton* btn = [UIButton buttonWithType:0];
        btn.frame = CGRectMake(0, 0, 50, 30);
        [btn setTitle:@"确定" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#1d252e"] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn addTarget:self action:@selector(touchRightItem:) forControlEvents:UIControlEventTouchUpInside];
        _rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
        
    }
    return _rightItem;
}

@end

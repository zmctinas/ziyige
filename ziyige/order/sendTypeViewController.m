//
//  sendTypeViewController.m
//  ziyige
//
//  Created by daimangkeji on 16/6/24.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "sendTypeViewController.h"
#import "preOrderViewController.h"

@interface sendTypeViewController ()

@property (weak, nonatomic) IBOutlet UIView *backView;

- (IBAction)sendBtn:(UIButton *)sender;
- (IBAction)touchBackView:(id)sender;


@end

@implementation sendTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    [self addBackAction];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private

-(void)addBackAction
{
    
}

#pragma mark - xib

- (IBAction)sendBtn:(UIButton *)sender {
    
    if (sender.tag == 10) {
        self.entity.distribution = @"express";
    }else
    {
        self.entity.distribution = @"self_take";
    }
    NSLog(@"%@",self.entity.distribution);
    
    [self.delegate changeUI];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)touchBackView:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}
@end

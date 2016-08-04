//
//  feedBackViewController.m
//  ziyige
//
//  Created by daimangkeji on 16/6/14.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "feedBackViewController.h"
#import "feedBackModel.h"

@interface feedBackViewController ()<UITextViewDelegate>

@property(strong,nonatomic)feedBackModel* model;

@property(strong,nonatomic)UIBarButtonItem* rightItem;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeight;

@property (weak, nonatomic) IBOutlet UITextView *textView;


@end

@implementation feedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"意见反馈";
    self.navigationItem.rightBarButtonItem = self.rightItem;
    
    [self addNotification];
    
    [self addObserverForNotifications:@[ADD_MESSAGE_NOTIFICATION]];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - getter

-(UIBarButtonItem*)rightItem
{
    if (!_rightItem) {
        
        UIButton* btn = [UIButton buttonWithType:0];
        btn.frame = CGRectMake(0, 0, 40, 30);
        [btn setTitle:@"提交" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#1d252e"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(touchRightItem:) forControlEvents:UIControlEventTouchUpInside];
        
        _rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    }
    return _rightItem;
}

-(feedBackModel*)model
{
    if (!_model) {
        _model = [[feedBackModel alloc]init];
    }
    return _model;
}

#pragma mark - private

-(void)receivedNotification:(NSNotification *)notification
{
    if ([notification.name isEqualToString:ADD_MESSAGE_NOTIFICATION]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)touchRightItem:(UIButton*)sender
{
    [self.model addMessage:_textView.text];
}

-(void)addNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name: UITextViewTextDidChangeNotification object:nil];
}

-(void)textChanged
{
    NSLog(@"%f",_textView.contentSize.height);
    _textViewHeight.constant = _textView.contentSize.height;
}

#pragma mark - UITextViewDelegate



@end

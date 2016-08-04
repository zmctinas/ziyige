//
//  PSCopyLabel.m
//  Diamond
//
//  Created by Pan on 16/1/11.
//  Copyright © 2016年 Pan. All rights reserved.
//

#import "PSCopyLabel.h"

@implementation PSCopyLabel

//绑定事件
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self attachTapHandler];
    }
    return self;
}
//同上
-(void)awakeFromNib
{
    [super awakeFromNib];
    [self attachTapHandler];
}

// default is NO
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

//"反馈"关心的功能
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return (action == @selector(copy:));
}
//针对于copy的实现
-(void)copy:(id)sender
{
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = self.text;
}

//UILabel默认是不接收事件的，我们需要自己添加touch事件
-(void)attachTapHandler
{
    self.userInteractionEnabled = YES;  //用户交互的总开关
//    UITapGestureRecognizer *touch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
//    touch.numberOfTapsRequired = 2;
//    [self addGestureRecognizer:touch];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:longPress];
}

-(void)handleTap:(UIGestureRecognizer *)recognizer
{
    [self becomeFirstResponder];
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setTargetRect:self.frame inView:self.superview];
    if (!menu.isMenuVisible)
    {
        [menu setMenuVisible:YES animated:YES];
    }
}

@end

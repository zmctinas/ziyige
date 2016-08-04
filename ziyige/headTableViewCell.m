//
//  headTableViewCell.m
//  ziyige
//
//  Created by daimangkeji on 16/6/22.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "headTableViewCell.h"
#import "imageDisplayView.h"

@implementation headTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setEntity:(detailEntity *)entity
{
    _entity = entity;
    
    
    for (int i = 0; i < _entity.imageSource.count ;i++) {
    NSString* str = _entity.imageSource[i];
        imageDisplayView* displayView = [[imageDisplayView alloc]initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_WIDTH) andImageUrl:str];
        [self.scrollView addSubview:displayView];
    }
    self.pageControl.numberOfPages = _entity.imageSource.count;
    [self.scrollView setContentSize:CGSizeMake(SCREEN_WIDTH*_entity.imageSource.count, 0)];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int offset = scrollView.contentOffset.x/SCREEN_WIDTH;
    self.pageControl.currentPage = offset;
}

@end

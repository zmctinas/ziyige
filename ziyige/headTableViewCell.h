//
//  headTableViewCell.h
//  ziyige
//
//  Created by daimangkeji on 16/6/22.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "detailEntity.h"

@interface headTableViewCell : UITableViewCell<UIScrollViewDelegate>

@property(strong,nonatomic)detailEntity* entity;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

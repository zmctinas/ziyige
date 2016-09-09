//
//  collectionViewCell.h
//  ziyige
//
//  Created by daimangkeji on 16/6/20.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "goodsEntity.h"
#import "collectEntity.h"

@interface collectionViewCell : UICollectionViewCell
@property (strong,nonatomic)goodsEntity* Gentity;
@property (strong,nonatomic)collectEntity* Centity;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeight;

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelHeight;

@end

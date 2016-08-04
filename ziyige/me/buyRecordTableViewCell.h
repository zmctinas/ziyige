//
//  buyRecordTableViewCell.h
//  ziyige
//
//  Created by daimangkeji on 16/6/16.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "goodsEntity.h"


@interface buyRecordTableViewCell : UITableViewCell

@property(strong,nonatomic)goodsEntity* entity;

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *guigeLabel;
@property (weak, nonatomic) IBOutlet UIButton *statusBtn;





- (IBAction)tyoeBtn:(UIButton *)sender;

@end

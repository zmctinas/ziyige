//
//  addressTableViewCell.h
//  ziyige
//
//  Created by daimangkeji on 16/6/28.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "addressEntity.h"
#import "addressModel.h"

@interface addressTableViewCell : UITableViewCell

@property(strong,nonatomic)addressEntity* entity;

@property(strong,nonatomic)addressModel* model;

@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UILabel *detialMessageLabel;
@property (weak, nonatomic) IBOutlet UIButton *defaultBtn;

- (IBAction)defaultBtn:(UIButton *)sender;

- (IBAction)editBtn:(UIButton *)sender;


@end

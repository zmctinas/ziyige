//
//  middleTwoTableViewCell.h
//  ziyige
//
//  Created by daimangkeji on 16/8/17.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "detailEntity.h"

@interface middleTwoTableViewCell : UITableViewCell

@property(strong,nonatomic)detailEntity* entity;

@property (weak, nonatomic) IBOutlet UILabel *promiseLabel;
@property (weak, nonatomic) IBOutlet UILabel *insureLabel;

- (IBAction)ruleBtn:(UIButton *)sender;

@end

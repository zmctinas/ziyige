//
//  inviteTableViewCell.h
//  ziyige
//
//  Created by daimangkeji on 16/8/4.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "rootTableViewCell.h"
#import "inviteEntity.h"

@interface inviteTableViewCell : rootTableViewCell

@property(strong,nonatomic)inviteEntity* entity;

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *photoLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

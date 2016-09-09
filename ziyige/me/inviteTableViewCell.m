//
//  inviteTableViewCell.m
//  ziyige
//
//  Created by daimangkeji on 16/8/4.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "inviteTableViewCell.h"

@implementation inviteTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setEntity:(inviteEntity *)entity
{
    _entity = entity;
    
    _nameLabel.text = entity.user_name;
    _photoLabel.text = entity.phone_number;
    
    _iconView.layer.masksToBounds = YES;
    _iconView.layer.cornerRadius = _iconView.frame.size.width/2;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_BASEURL,entity.photo]] placeholderImage:[UIImage imageNamed:@"icon_avator_default"]];
    
}

@end

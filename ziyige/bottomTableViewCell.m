//
//  bottomTableViewCell.m
//  ziyige
//
//  Created by daimangkeji on 16/6/22.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "bottomTableViewCell.h"

@implementation bottomTableViewCell

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
    
    self.messageLabel.text = [NSString stringWithFormat:@"%@：%@",_entity.auth,_entity.descriptions];
}

@end

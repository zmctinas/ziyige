//
//  middleTwoTableViewCell.m
//  ziyige
//
//  Created by daimangkeji on 16/8/17.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "middleTwoTableViewCell.h"

@implementation middleTwoTableViewCell

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
    
    self.promiseLabel.text = entity.promise;
    self.insureLabel.text = entity.ensure;
    
}

- (IBAction)ruleBtn:(UIButton *)sender {
    
    [[NSNotificationCenter defaultCenter]postNotificationName:RULE_DETAIL_NOTIFICATION object:nil];
    
}
@end

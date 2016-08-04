//
//  addressTableViewCell.m
//  ziyige
//
//  Created by daimangkeji on 16/6/28.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "addressTableViewCell.h"

@implementation addressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setEntity:(addressEntity *)entity
{
    _entity = entity;
    
    if (self.tag%2) {
        self.backImageView.backgroundColor = [UIColor colorWithHexString:@"#1d252e"];
        self.backImageView.alpha = 0.2;
        [self.defaultBtn setBackgroundImage:[UIImage imageNamed:@"icon_btn_location_white"] forState:UIControlStateNormal];
        [self.defaultBtn setBackgroundImage:[UIImage imageNamed:@"icon_btn_location_whitepressed"] forState:UIControlStateHighlighted];
        [self.defaultBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        self.nameLabel.textColor = [UIColor whiteColor];
        self.phoneLabel.textColor = [UIColor whiteColor];
        self.areaLabel.textColor = [UIColor whiteColor];
        self.detialMessageLabel.textColor = [UIColor whiteColor];
        
    }else
    {
        self.backImageView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        self.backImageView.alpha = 0.5;
        [self.defaultBtn setBackgroundImage:[UIImage imageNamed:@"icon_btn_location_black"] forState:UIControlStateNormal];
        [self.defaultBtn setBackgroundImage:[UIImage imageNamed:@"icon_btn_location_blackpressed"] forState:UIControlStateHighlighted];
        [self.defaultBtn setTitleColor:[UIColor colorWithHexString:@"#1d252e"] forState:UIControlStateNormal];
        
        self.nameLabel.textColor = [UIColor colorWithHexString:@"#1d252e"];
        self.phoneLabel.textColor = [UIColor colorWithHexString:@"#1d252e"];
        self.areaLabel.textColor = [UIColor colorWithHexString:@"#939e9f"];
        self.detialMessageLabel.textColor = [UIColor colorWithHexString:@"#939e9f"];
    }
    
    _nameLabel.text = _entity.link_name;
    _phoneLabel.text = _entity.tel_num;
    _areaLabel.text = [NSString stringWithFormat:@"%@/%@/%@",_entity.province,_entity.city,_entity.district];
    _detialMessageLabel.text = _entity.address;
    
    if (_entity.is_def.integerValue == 0) {
        [self.defaultBtn setTitle:@"设为默认" forState:UIControlStateNormal];
    }else
    {
        [self.defaultBtn setTitle:@"默认" forState:UIControlStateNormal];
    }
    
    
}

- (IBAction)defaultBtn:(UIButton *)sender {
    
    [self.model setDefault:_entity.addid];
    
}

- (IBAction)editBtn:(UIButton *)sender {
    
    [[NSNotificationCenter defaultCenter]postNotificationName:START_EDIT_AREA_NOTIFICATION object:_entity];
    
}
@end

//
//  withDrawlTableViewCell.m
//  ziyige
//
//  Created by daimangkeji on 16/8/4.
//  Copyright © 2016年 daimangkeji. All rights reserved.
//

#import "withDrawlTableViewCell.h"

@implementation withDrawlTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setEntity:(withDrawlEntity *)entity
{
    _entity = entity;
    
    self.cashLabel.text = [NSString stringWithFormat:@"%@元",entity.cash];
    self.dateLabel.text = entity.date;
    switch (_entity.status.integerValue) {
        case 0:
        {
            _statusLabel.text = @"正在审核";
        }
            break;
        case 1:
        {
            _statusLabel.text = @"正在操作";
        }
            break;
        case 2:
        {
            _statusLabel.text = @"已完成";
        }
            break;
        case 3:
        {
            _statusLabel.text = @"操作失败";
        }
            break;
            
        default:
            break;
    }
    
    self.paymentLabel.text = [NSString stringWithFormat:@"%@",[_entity.type isEqualToString:@"ali_pay"]?@"转入支付宝":@"转入微信"];
    
}

@end

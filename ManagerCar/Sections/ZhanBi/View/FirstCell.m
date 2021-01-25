//
//  FirstCell.m
//  ManagerCar
//
//  Created by wanshaoyong on 2019/10/17.
//  Copyright © 2019 Henanhld. All rights reserved.
//

#import "FirstCell.h"

@implementation FirstCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.leftLab = [[UILabel alloc] initWithFrame:CGRectMake(10*CWidth, 10*CHeight, 100*CWidth, 20*CHeight)];
        _leftLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_leftLab];
        
        self.rightLab = [[UILabel alloc] initWithFrame:CGRectMake(110*CWidth, 10*CHeight, WIDTH-120*CWidth, 20*CHeight)];
        _rightLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_rightLab];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

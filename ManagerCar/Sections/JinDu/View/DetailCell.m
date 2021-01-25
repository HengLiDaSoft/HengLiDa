//
//  DetailCell.m
//  ManagerCar
//
//  Created by wanshaoyong on 2019/10/15.
//  Copyright © 2019 Henanhld. All rights reserved.
//

#import "DetailCell.h"

@implementation DetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.numberLab = [[UILabel alloc] initWithFrame:CGRectMake(10*CWidth, 10*CHeight, 25*CWidth, 25*CWidth)];
        _numberLab.textColor = [UIColor colorWithHexString:@"#48bc73" alpha:1.0];
        _numberLab.textAlignment = NSTextAlignmentCenter;
        _numberLab.layer.cornerRadius = 12.5*CWidth;
        _numberLab.layer.masksToBounds = YES;
        _numberLab.layer.borderWidth = 1*CWidth;
        _numberLab.layer.borderColor = [UIColor colorWithHexString:@"#48bc73" alpha:1.0].CGColor;
        [self.contentView addSubview:_numberLab];
        
        self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(40*CWidth, 10*CHeight, WIDTH-80*CWidth, 25*CHeight)];
        [self.contentView addSubview:_titleLab];
        
        self.upView = [[UIView alloc] initWithFrame:CGRectMake(10*CWidth, 50*CHeight, WIDTH-20*CWidth, 15*CHeight)];
        _upView.layer.cornerRadius = 7*CWidth;
        _upView.layer.masksToBounds = YES;
        _upView.backgroundColor = [UIColor colorWithHexString:@"#b2eac9" alpha:1.0];
        [self.contentView addSubview:_upView];
        
        self.downView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _upView.frame.size.width/2, 15*CHeight)];
        _downView.backgroundColor = [UIColor colorWithHexString:@"#48bc73" alpha:1.0];
        [_upView addSubview:_downView];
        
        self.detailPerLab = [[UILabel alloc] initWithFrame:CGRectMake(self.upView.frame.size.width/2-50*CWidth, 0, 35*CWidth, 15*CHeight)];
        _detailPerLab.textColor = [UIColor whiteColor];
        _detailPerLab.font = [UIFont systemFontOfSize:14*CHeight];
        _detailPerLab.textColor = [UIColor colorWithHexString:@"#ff5a00" alpha:1.0];
        [_upView addSubview:_detailPerLab];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  JinDuCell.m
//  ManagerCar
//
//  Created by wanshaoyong on 2019/10/14.
//  Copyright © 2019 Henanhld. All rights reserved.
//

#import "JinDuCell.h"

@implementation JinDuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.numbLab = [[UILabel alloc] initWithFrame:CGRectMake(10*CWidth, 10*CHeight, 25*CWidth, 25*CWidth)];
        _numbLab.textColor = [UIColor colorWithHexString:@"#48bc73" alpha:1.0];
        _numbLab.textAlignment = NSTextAlignmentCenter;
        _numbLab.layer.cornerRadius = 12.5*CWidth;
        _numbLab.layer.masksToBounds = YES;
        _numbLab.layer.borderWidth = 1*CWidth;
        _numbLab.layer.borderColor = [UIColor colorWithHexString:@"#48bc73" alpha:1.0].CGColor;
        [self.contentView addSubview:_numbLab];
        
        self.nameLab = [[UILabel alloc] initWithFrame:CGRectMake(40*CWidth, 10*CHeight, 60*CWidth, 25*CHeight)];
        [self.contentView addSubview:_nameLab];
        
        self.numLab = [[UILabel alloc] initWithFrame:CGRectMake(110*CWidth, 10*CHeight, 100*CWidth, 25*CHeight)];
        _numLab.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_numLab];
        
        self.finishLab = [[UILabel alloc] initWithFrame:CGRectMake(210*CWidth, 10*CHeight, WIDTH-220*CWidth, 25*CHeight)];
        _finishLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_finishLab];
        
        self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(10*CWidth, 50*CHeight, WIDTH-20*CWidth, 15*CHeight)];
        _bottomView.layer.cornerRadius = 7*CWidth;
        _bottomView.layer.masksToBounds = YES;
        _bottomView.backgroundColor = [UIColor colorWithHexString:@"#b2eac9" alpha:1.0];
        [self.contentView addSubview:_bottomView];
        
        self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _bottomView.frame.size.width/2, 15*CHeight)];
        _topView.backgroundColor = [UIColor colorWithHexString:@"#48bc73" alpha:1.0];
        [_bottomView addSubview:_topView];
        
        self.percentLab = [[UILabel alloc] initWithFrame:CGRectMake(self.topView.frame.size.width, 0, 35*CWidth, 15*CHeight)];
        _percentLab.textColor = [UIColor whiteColor];
        _percentLab.font = [UIFont systemFontOfSize:14*CHeight];
        _percentLab.textColor = [UIColor colorWithHexString:@"#ff5a00" alpha:1.0];
        [_bottomView addSubview:_percentLab];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

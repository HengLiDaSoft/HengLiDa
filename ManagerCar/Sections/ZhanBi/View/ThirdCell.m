//
//  ThirdCell.m
//  ManagerCar
//
//  Created by wanshaoyong on 2019/10/18.
//  Copyright © 2019 Henanhld. All rights reserved.
//

#import "ThirdCell.h"

@implementation ThirdCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.thirdNameLab = [[UILabel alloc] initWithFrame:CGRectMake(10*CWidth, 10*CHeight, WIDTH/3-20*CWidth/3, 20*CHeight)];
        _thirdNameLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_thirdNameLab];
        
        self.thirdFinishLab = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH/3-20*CWidth/3, 10*CHeight, WIDTH/3-20*CWidth/3, 20*CHeight)];
        _thirdFinishLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_thirdFinishLab];
        
        self.thirdPlanLab = [[UILabel alloc] initWithFrame:CGRectMake(2*WIDTH/3-2*20*CWidth/3, 10*CHeight, WIDTH/3-20*CWidth/3, 20*CHeight)];
        _thirdPlanLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_thirdPlanLab];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

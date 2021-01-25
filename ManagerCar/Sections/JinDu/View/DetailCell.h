//
//  DetailCell.h
//  ManagerCar
//
//  Created by wanshaoyong on 2019/10/15.
//  Copyright © 2019 Henanhld. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailCell : UITableViewCell

@property (nonatomic, strong)UILabel *numberLab;
@property (nonatomic, strong)UILabel *titleLab;
@property (nonatomic, strong)UIView *upView;
@property (nonatomic, strong)UIView *downView;
@property (nonatomic, strong)UILabel *detailPerLab;

@end

NS_ASSUME_NONNULL_END

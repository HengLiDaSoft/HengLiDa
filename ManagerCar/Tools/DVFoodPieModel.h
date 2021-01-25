//
//  DVFoodPieModel.h
//  ManagerCar
//
//  Created by wanshaoyong on 2019/10/23.
//  Copyright © 2019 Henanhld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DVFoodPieModel : NSObject

/**
 名称
 */
@property (copy, nonatomic) NSString *name;

/**
 数值
 */
@property (assign, nonatomic) CGFloat value;

/**
 比例
 */
@property (assign, nonatomic) CGFloat rate;

@end

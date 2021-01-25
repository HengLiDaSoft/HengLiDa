//
//  DVPieChart.h
//  ManagerCar
//
//  Created by wanshaoyong on 2019/10/23.
//  Copyright © 2019 Henanhld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DVPieChart : UIView

/**
 数据数组
 */
@property (strong, nonatomic) NSArray *dataArray;

/**
 标题
 */
@property (copy, nonatomic) NSString *title;

/**
 绘制方法
 */
- (void)draw;

@end

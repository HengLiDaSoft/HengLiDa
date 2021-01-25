//
//  QFDatePickerView.h
//  ManagerCar
//
//  Created by wanshaoyong on 2019/10/15.
//  Copyright © 2019 Henanhld. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QFDatePickerView : UIView

/**
 初始化方法，只带年月的日期选择
 
 @param block 返回选中的日期
 @return QFDatePickerView对象
 */
-(instancetype)initDatePackerWithResponse:(void(^)(NSString*))block;


/**
 初始化方法，只带年月的日期选择
 
 @param superView picker的载体View
 @param block 返回选中的日期
 @return QFDatePickerView对象
 */
- (instancetype)initDatePackerWithSUperView:(UIView *)superView response:(void(^)(NSString*))block;


/**
 初始化方法，只带年份的日期选择
 
 @param block 返回选中的年份
 @return QFDatePickerView对象
 */
- (instancetype)initYearPickerViewWithResponse:(void(^)(NSString*))block;

/**
 初始化方法，只带年份的日期选择
 
 @param block 返回选中的年份
 @return QFDatePickerView对象
 */
- (instancetype)initYearPickerWithView:(UIView *)superView response:(void(^)(NSString*))block;

/**
 显示方法
 */
- (void)show;

@end

NS_ASSUME_NONNULL_END

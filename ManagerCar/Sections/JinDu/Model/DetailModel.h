//
//  DetailModel.h
//  ManagerCar
//
//  Created by wanshaoyong on 2019/10/24.
//  Copyright © 2019 Henanhld. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailModel : NSObject

//课件名称
@property (nonatomic, copy)NSString *CourseName;
//课件总学时
@property (nonatomic, copy)NSString *TotalPeriod;
//课件已完成学时
@property (nonatomic, copy)NSString *FinishPeriod;

- (instancetype)initWithDictionary:(NSDictionary *)otherDictionary;

@end

NS_ASSUME_NONNULL_END

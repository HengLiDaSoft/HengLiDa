//
//  JinduModel.h
//  ManagerCar
//
//  Created by wanshaoyong on 2019/10/24.
//  Copyright © 2019 Henanhld. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JinduModel : NSObject

@property (nonatomic, copy)NSString *BasePeriod;
@property (nonatomic, copy)NSString *CertType;
@property (nonatomic, copy)NSString *License;
@property (nonatomic, copy)NSString *PeriodRate;
@property (nonatomic, copy)NSString *Phone;
@property (nonatomic, copy)NSString *RealName;
@property (nonatomic, copy)NSString *StuNum;
@property (nonatomic, copy)NSString *TrainedPeriod;

- (instancetype)initWithDictionary:(NSDictionary *)otherDictionary;

@end

NS_ASSUME_NONNULL_END

//
//  PeriodModel.h
//  ManagerCar
//
//  Created by wanshaoyong on 2019/10/25.
//  Copyright © 2019 Henanhld. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PeriodModel : NSObject

@property (nonatomic, copy)NSString *BasePeriod;
@property (nonatomic, copy)NSString *CertType;
@property (nonatomic, copy)NSString *PlanDate;


- (instancetype)initWithDictionary:(NSDictionary *)otherDictionary;

@end

NS_ASSUME_NONNULL_END

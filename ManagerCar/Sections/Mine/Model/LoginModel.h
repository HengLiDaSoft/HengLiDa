//
//  LoginModel.h
//  ManagerCar
//
//  Created by wanshaoyong on 2019/10/24.
//  Copyright © 2019 Henanhld. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginModel : NSObject

@property (nonatomic, copy)NSString *Account;
@property (nonatomic, copy)NSString *RealName;
@property (nonatomic, copy)NSString *AreaName;
@property (nonatomic, copy)NSString *OrganizeName;
@property (nonatomic, copy)NSString *Token;

- (instancetype)initWithDictionary:(NSDictionary *)otherDictionary;

@end

NS_ASSUME_NONNULL_END

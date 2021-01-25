//
//  LoginModel.m
//  ManagerCar
//
//  Created by wanshaoyong on 2019/10/24.
//  Copyright © 2019 Henanhld. All rights reserved.
//

#import "LoginModel.h"

@implementation LoginModel

- (instancetype)initWithDictionary:(NSDictionary *)otherDictionary{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:otherDictionary];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end

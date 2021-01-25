//
//  PeriodModel.m
//  ManagerCar
//
//  Created by wanshaoyong on 2019/10/25.
//  Copyright © 2019 Henanhld. All rights reserved.
//

#import "PeriodModel.h"

@implementation PeriodModel

- (instancetype)initWithDictionary:(NSDictionary *)otherDictionary{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:otherDictionary];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end

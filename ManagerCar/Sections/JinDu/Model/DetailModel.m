//
//  DetailModel.m
//  ManagerCar
//
//  Created by wanshaoyong on 2019/10/24.
//  Copyright © 2019 Henanhld. All rights reserved.
//

#import "DetailModel.h"

@implementation DetailModel

- (instancetype)initWithDictionary:(NSDictionary *)otherDictionary{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:otherDictionary];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end

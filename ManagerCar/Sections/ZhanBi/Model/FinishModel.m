//
//  FinishModel.m
//  ManagerCar
//
//  Created by wanshaoyong on 2019/10/25.
//  Copyright © 2019 Henanhld. All rights reserved.
//

#import "FinishModel.h"

@implementation FinishModel

- (instancetype)initWithDictionary:(NSDictionary *)otherDictionary{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:otherDictionary];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end

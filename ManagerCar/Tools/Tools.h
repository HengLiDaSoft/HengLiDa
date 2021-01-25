//
//  Tools.h
//  ManagerCar
//
//  Created by wanshaoyong on 2019/10/23.
//  Copyright © 2019 Henanhld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Tools : NSObject

//是否是第一次启动
+ (BOOL)isFirstLoad;
//本地保存string，int，Char等类型，forkey为键，value为要保存的值
+ (void)UserDefaultSetValue:(id)Value forKey:(NSString *)keyString;
//取出本地保存的string,int,Char,等值，keyString为键
+ (id)UserDefaultObjectForKey:(NSString *)keyString;
//本地保存bool类型值
+ (void)userDefaultSetBool:(BOOL)VBool forKey:(NSString *)keyString;
//本地取出Bool类型值
+ (BOOL)userDefaultBoolForKey:(NSString *)keyString;
//移除单例保存的某个值
+ (void)userDefaultRemoveObjectForKey:(NSString *)keyString;

//自定义警示框
+(void)alterViewShow:(NSString *)message viewcontroller:(UIViewController *)controller;
//正则判断手机号
+ (BOOL)validateMobile:(NSString *)mobile;
//正则判断身份证
+ (BOOL)validateIdentityCard:(NSString *)identityCard;
//正则判断密码(密码是由数字，大小写英文字母和下划线组成)
+ (BOOL)validatePassword:(NSString *)password;
//获取当前手机的版本号
+ (NSString *)getPhoneVersion;

//获取当前手机的型号
+ (NSString *)deviceModelName;

//字典转JSON字符串
+ (NSString *)convertToJsonData:(NSDictionary *)dict;

//把图片处理到指定尺寸
+ (UIImage *)compressOriginalImage:(UIImage *)image toSize:(CGSize)size;

//判断字符串是否为空
+ (BOOL)isBlankString:(NSString *)aStr;

@end

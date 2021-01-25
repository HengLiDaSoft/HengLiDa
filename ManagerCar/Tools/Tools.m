//
//  Tools.m
//  ManagerCar
//
//  Created by wanshaoyong on 2019/10/23.
//  Copyright © 2019 Henanhld. All rights reserved.
//

#import "Tools.h"
#import <sys/utsname.h>

@implementation Tools

static NSString *WLastVersion = @"last_run_version_of_application";

+ (BOOL)isFirstLoad{
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastRunVersion = [defaults objectForKey:WLastVersion];
    if (!lastRunVersion) {
        [defaults setObject:currentVersion forKey:WLastVersion];
        return YES;
    }else if (![lastRunVersion isEqualToString:currentVersion]){
        [defaults setObject:currentVersion forKey:WLastVersion];
        return YES;
    }
    return NO;
}

+ (void)UserDefaultSetValue:(id)Value forKey:(NSString *)keyString{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if (![Value isKindOfClass:[NSNull class]]) {
        [userDefault setValue:Value forKey:keyString];
    }else {
        [userDefault setValue:@"" forKey:keyString];
    }
    [userDefault synchronize];
}

+ (id)UserDefaultObjectForKey:(NSString *)keyString{
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    NSString * string = [userDefault objectForKey:keyString];
    [userDefault synchronize];
    return string;
}

+ (void)userDefaultSetBool:(BOOL)VBool forKey:(NSString *)keyString{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:VBool forKey:keyString];
    [userDefaults synchronize];
}

+ (BOOL)userDefaultBoolForKey:(NSString *)keyString{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    BOOL Bool = [userDefault boolForKey:keyString];
    [userDefault synchronize];
    return Bool;
}

+ (void)userDefaultRemoveObjectForKey:(NSString *)keyString{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault removeObjectForKey:keyString];
    [userDefault synchronize];
}

+ (void)alterViewShow:(NSString *)message viewcontroller:(id)controller{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [controller presentViewController:alert animated:YES completion:^{
        //延迟1秒自动消失
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alert dismissViewControllerAnimated:YES completion:nil];
        });
    }];
}

+ (BOOL)validateMobile:(NSString *)mobile{
    //手机号以13,14,15,18,17开头，八个 \d 数字字符
    NSString *phoneRegex = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-345-9]|7[013678])\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

+ (BOOL)validateIdentityCard:(NSString *)identityCard{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate  predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

+ (BOOL)validatePassword:(NSString *)password{
    /**
     /^    匹配输入字符串的开始位置
     (
     [A-Za-z0-9_]     大小写字母和数字任选
     {6,15}    长度大于6小于20
     )
     $/    匹配输入字符串的结束位置
     */
    NSString *passWordRegex = @"^[A-Za-z0-9_]{6,15}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:password];
    
}

+ (NSString *)getPhoneVersion{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CFShow((__bridge CFTypeRef)(infoDictionary));
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return app_Version;
}

+ (NSString *)deviceModelName{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if ([deviceString isEqualToString:@"iPhone1,1"]) {
        return @"iPhone";
    }else if ([deviceString isEqualToString:@"iPhone1,2"]){
        return @"iPhone 3G";
    }else if ([deviceString isEqualToString:@"iPhone2,1"]){
        return @"iPhone 3GS";
    }else if ([deviceString isEqualToString:@"iPhone3,1"]){
        return @"iPhone 4";
    }else if ([deviceString isEqualToString:@"iPhone3,2"]){
        return @"iPhone 4";
    }else if ([deviceString isEqualToString:@"iPhone3,3"]){
        return @"iPhone 4";
    }else if ([deviceString isEqualToString:@"iPhone4,1"]){
        return @"iPhone 4S";
    }else if ([deviceString isEqualToString:@"iPhone5,1"]){
        return @"iPhone 5";
    }else if ([deviceString isEqualToString:@"iPhone5,2"]){
        return @"iPhone 5";
    }else if ([deviceString isEqualToString:@"iPhone5,3"]){
        return @"iPhone 5c";
    }else if ([deviceString isEqualToString:@"iPhone5,4"]){
        return @"iPhone 5c";
    }else if ([deviceString isEqualToString:@"iPhone6,1"]){
        return @"iPhone 5s";
    }else if ([deviceString isEqualToString:@"iPhone6,2"]){
        return @"iPhone 5s";
    }else if ([deviceString isEqualToString:@"iPhone7,2"]){
        return @"iPhone 6";
    }else if ([deviceString isEqualToString:@"iPhone7,1"]){
        return @"iPhone 6Plus";
    }else if ([deviceString isEqualToString:@"iPhone8,1"]){
        return @"iPhone 6s";
    }else if ([deviceString isEqualToString:@"iPhone8,2"]){
        return @"iPhone 6s Plus";
    }else if ([deviceString isEqualToString:@"iPhone8,4"]){
        return @"iPhone SE";
    }else if ([deviceString isEqualToString:@"iPhone9,1"]){
        return @"iPhone 7";
    }else if ([deviceString isEqualToString:@"iPhone9,3"]){
        return @"iPhone 7";
    }else if ([deviceString isEqualToString:@"iPhone9,2"]){
        return @"iPhone 7Plus";
    }else if ([deviceString isEqualToString:@"iPhone9,4"]){
        return @"iPhone 7Plus";
    }else if ([deviceString isEqualToString:@"iPhone10,1"]){
        return @"iPhone 8";
    }else if ([deviceString isEqualToString:@"iPhone10,4"]){
        return @"iPhone 8";
    }else if ([deviceString isEqualToString:@"iPhone10,2"]){
        return @"iPhone 8Plus";
    }else if ([deviceString isEqualToString:@"iPhone10,5"]){
        return @"iPhone 8Plus";
    }else if ([deviceString isEqualToString:@"iPhone10,3"]){
        return @"iPhone X";
    }else if ([deviceString isEqualToString:@"iPhone10,6"]){
        return @"iPhone X";
    }else if ([deviceString isEqualToString:@"iPhone11,8"]){
        return @"iPhone XR";
    }else if ([deviceString isEqualToString:@"iPhone11,2"]){
        return @"iPhone XS";
    }else if ([deviceString isEqualToString:@"iPhone11,6"]){
        return @"iPhone XS Max";
    }else if ([deviceString isEqualToString:@"iPhone11,4"]){
        return @"iPhone XS Max";
    }else{
        return nil;
    }
    
}

+ (NSString *)convertToJsonData:(NSDictionary *)dict{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"Json数据错误:%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}

//把图片处理到指定大小
+ (UIImage *)compressOriginalImage:(UIImage *)image toSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}


//判断字符串是否为空
+ (BOOL)isBlankString:(NSString *)aStr {
    if (!aStr) {
        return YES;
    }
    if ([aStr isKindOfClass:[NSNull class]]) {
        return YES;
    }
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedStr = [aStr stringByTrimmingCharactersInSet:set];
    if (!trimmedStr.length) {
        return YES;
    }
    return NO;
}



@end

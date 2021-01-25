//
//  LoginViewController.m
//  ManagerCar
//
//  Created by wanshaoyong on 2019/10/23.
//  Copyright © 2019 Henanhld. All rights reserved.
//

#import "LoginViewController.h"
#import <AFNetworking.h>
#import "LoginModel.h"

@interface LoginViewController ()

@property (nonatomic, strong)UITextField *cardTF;
@property (nonatomic, strong)UITextField *passwordTF;
@property (nonatomic, strong)UIButton *loginBt;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self LoginView];
    
}

- (void)LoginView{
    //图片
    UIImageView *photo = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH/2 - 61*CWidth, 90*CHeight, 122*CWidth, 120*CHeight)];
    photo.image = [UIImage imageNamed:@"120"];
    [self.view addSubview:photo];
    
    //版本号
    NSString *app_Version = [Tools getPhoneVersion];
    UILabel *versionLab = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH/2 - 50*CWidth, 215*CHeight, 100*CWidth, 20*CHeight)];
    versionLab.text = [NSString stringWithFormat:@"当前版本:%@", app_Version];;
    versionLab.textColor = [UIColor colorWithHexString:@"#e0e0e0" alpha:1.0];
    versionLab.adjustsFontSizeToFitWidth = YES;
    versionLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:versionLab];
    
    //账号小图标
    UIImageView *cardPhoto = [[UIImageView alloc] initWithFrame:CGRectMake(50*CWidth, 270*CHeight, 30*CWidth, 30*CWidth)];
    cardPhoto.image = [UIImage imageNamed:@"user"];
    [self.view addSubview:cardPhoto];
    //账号
    self.cardTF = [[UITextField alloc] initWithFrame:CGRectMake(85*CWidth, 275*CHeight, WIDTH - 160*CWidth, 20*CHeight)];
    _cardTF.placeholder = @"请输入账号";
    //_cardTF.text = @"412224199512074502";
    _cardTF.clearsOnBeginEditing = NO;
    [self.view addSubview:_cardTF];
    
    //账号线条
    UIView *cardLine = [[UIView alloc] initWithFrame:CGRectMake(50*CWidth, 305*CHeight, WIDTH - 100*CWidth, 1*CHeight)];
    cardLine.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:cardLine];
    
    
    //密码小图标
    UIImageView *passwordPhoto = [[UIImageView alloc] initWithFrame:CGRectMake(50*CWidth, 341*CHeight, 30*CWidth, 30*CWidth)];
    passwordPhoto.image = [UIImage imageNamed:@"mima"];
    [self.view addSubview:passwordPhoto];
    //密码
    self.passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(85*CWidth, 346*CHeight, WIDTH - 160*CWidth, 20*CHeight)];
    _passwordTF.placeholder = @"请输入密码";
    _passwordTF.clearsOnBeginEditing = NO;
    _passwordTF.secureTextEntry = YES;
    [self.view addSubview:_passwordTF];
    
    //密码线条
    UIView *passwordLine = [[UIView alloc] initWithFrame:CGRectMake(50*CWidth, 376*CHeight, WIDTH - 100*CWidth, 1*CHeight)];
    passwordLine.backgroundColor = [UIColor colorWithHexString:@"#d1d1d1" alpha:1.0];
    [self.view addSubview:passwordLine];
    
    //登录按钮
    self.loginBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginBt.backgroundColor = [UIColor colorWithHexString:@"#39B54A" alpha:1.0];
    _loginBt.frame = CGRectMake(50*CWidth, 427*CHeight, WIDTH - 100*CWidth, 40*CHeight);
    _loginBt.layer.cornerRadius = 5;
    _loginBt.layer.masksToBounds = YES;
    [_loginBt setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBt addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBt];
    
    
}

#pragma mark ------------------------- 登录
- (void)login{
    [SVProgressHUD showWithStatus:@"正在登录"];
    //设置请求参数
    NSDictionary *dictonary = @{
                                @"Account":self.cardTF.text,
                                @"StrPwd":self.passwordTF.text,
                                };
    
    NSString *loginStr = [Tools convertToJsonData:dictonary];
    NSString *loginAES = [AESCrypt encrypt:loginStr password:AESKey];
    NSDictionary *dic = @{@"":loginAES};
    
    AFHTTPSessionManager *manager  = [AFHTTPSessionManager manager];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //申明请求的数据是json类型
    AFHTTPRequestSerializer *request = [AFHTTPRequestSerializer serializer];
    //实例:Content-Type: application/x-www-form-urlencoded
    //[request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    
    //保存token   只有result返回-2时登录
    if (![Tools isBlankString:self.cardTF.text] && [Tools validatePassword:self.passwordTF.text]) {
        [manager POST:[Str stringByAppendingString:@"User/Login"] parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [SVProgressHUD dismiss];
            //NSLog(@"_____msg:%@", responseObject);
            
            if ([responseObject[@"result"] integerValue] == 0) {
                if ([responseObject[@"data"] isKindOfClass:[NSString class]]) {
                
                    NSData *jsonData = [responseObject[@"data"] dataUsingEncoding:NSUTF8StringEncoding];
                    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                    
                    LoginModel *model = [[LoginModel alloc] initWithDictionary:dic];
                    //[self.loginArr addObject:model];
                    //NSLog(@"%@ %@ %@ %@ %@", model.Account, model.RealName, model.OrganizeName, model.AreaName, model.Token);
                    //存储为登录
                    [Tools userDefaultSetBool:YES forKey:@"Login"];
                    //账号
                    [Tools UserDefaultSetValue:model.Account forKey:@"Account"];
                    //账号名
                    [Tools UserDefaultSetValue:model.RealName forKey:@"RealName"];
                    //企业名称
                    [Tools UserDefaultSetValue:model.OrganizeName forKey:@"OrganizeName"];
                    //区域名称
                    [Tools UserDefaultSetValue:model.AreaName forKey:@"AreaName"];
                    //Token
                    [Tools UserDefaultSetValue:model.Token forKey:@"Token"];
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
            }else{
                [Tools alterViewShow:responseObject[@"msg"] viewcontroller:self];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD dismiss];
            [Tools alterViewShow:@"请重新登录" viewcontroller:self];
        }];
    }
}

@end

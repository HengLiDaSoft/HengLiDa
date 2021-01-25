//
//  MineViewController.m
//  ManagerCar
//
//  Created by wanshaoyong on 2019/10/14.
//  Copyright © 2019 Henanhld. All rights reserved.
//

#import "MineViewController.h"
#import "LoginViewController.h"

@interface MineViewController ()

@end


@implementation MineViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (![Tools UserDefaultObjectForKey:@"Login"]) {
        
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [self presentViewController:loginVC animated:YES completion:nil];
    }else{
        
        [self creatMineUI];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f1f1f1" alpha:1.0];
    self.navigationItem.title = @"我的";
    //[self creatMineUI];
}

- (void)creatMineUI{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 5*CHeight, WIDTH, 140*CHeight)];
    headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headView];
    
    UIImageView *headImg = [[UIImageView alloc] initWithFrame:CGRectMake(10*CWidth, 30*CHeight, 80*CWidth, 80*CWidth)];
    headImg.backgroundColor = [UIColor orangeColor];
    headImg.layer.cornerRadius = 40*CWidth;
    headImg.layer.masksToBounds = YES;
    headImg.image = [UIImage imageNamed:@"head"];
    [headView addSubview:headImg];
    
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(100*CWidth, 45*CHeight, 100*CWidth, 25*CHeight)];
    nameLab.text = [Tools UserDefaultObjectForKey:@"RealName"];
    nameLab.font = [UIFont systemFontOfSize:19*CHeight];
    [headView addSubview:nameLab];
    
    UILabel *accountLab = [[UILabel alloc] initWithFrame:CGRectMake(100*CWidth, 80*CHeight, WIDTH-100*CWidth, 20*CHeight)];
    accountLab.font = [UIFont systemFontOfSize:15*CHeight];
    //accountLab.text = @"账号:156328965";
    accountLab.text = [NSString stringWithFormat:@"账号：%@", [Tools UserDefaultObjectForKey:@"Account"]];
    accountLab.textColor = [UIColor grayColor];
    [headView addSubview:accountLab];
    
    
    UIView *areaView = [[UIView alloc] initWithFrame:CGRectMake(0, 150*CHeight, WIDTH, 180*CHeight)];
    areaView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:areaView];
    
    UIImageView *companyImg = [[UIImageView alloc] initWithFrame:CGRectMake(10*CWidth, 10*CHeight, 30*CWidth, 30*CHeight)];
    companyImg.image = [UIImage imageNamed:@"company"];
    [areaView addSubview:companyImg];
    
    UILabel *companyLab = [[UILabel alloc] initWithFrame:CGRectMake(50*CWidth, 10*CHeight, 150*CWidth, 30*CHeight)];
    companyLab.textColor = [UIColor grayColor];
    companyLab.text = @"我的公司";
    [areaView addSubview:companyLab];
    
    UILabel *companyNameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 55*CHeight, WIDTH, 25*CHeight)];
    companyNameLab.textAlignment = NSTextAlignmentCenter;
    companyNameLab.text = [Tools UserDefaultObjectForKey:@"OrganizeName"];
    companyNameLab.font = [UIFont systemFontOfSize:19*CHeight];
    [areaView addSubview:companyNameLab];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 90*CHeight, WIDTH, 1*CHeight)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#f1f1f1" alpha:1.0];
    [areaView addSubview:lineView];
    
    UIImageView *areaImg = [[UIImageView alloc] initWithFrame:CGRectMake(10*CWidth, 100*CHeight, 30*CWidth, 30*CHeight)];
    areaImg.image = [UIImage imageNamed:@"quyu"];
    [areaView addSubview:areaImg];
    
    UILabel *areaLab = [[UILabel alloc] initWithFrame:CGRectMake(50*CWidth, 100*CHeight, 150*CWidth, 30*CHeight)];
    areaLab.textColor = [UIColor grayColor];
    areaLab.text = @"所属区域";
    [areaView addSubview:areaLab];
    
    UILabel *areaNameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 145*CHeight, WIDTH, 25*CHeight)];
    areaNameLab.textAlignment = NSTextAlignmentCenter;
    areaNameLab.text = [Tools UserDefaultObjectForKey:@"AreaName"];
    areaNameLab.font = [UIFont systemFontOfSize:19*CHeight];
    [areaView addSubview:areaNameLab];
    
    UIButton *quitBt = [UIButton buttonWithType:UIButtonTypeCustom];
    quitBt.frame = CGRectMake(15*CWidth, 340*CHeight, WIDTH-30*CWidth, 45*CHeight);
    quitBt.backgroundColor = [UIColor whiteColor];
    [quitBt setTitle:@"退出登录" forState:UIControlStateNormal];
    [quitBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [quitBt addTarget:self action:@selector(quitLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:quitBt];
    
}

#pragma mark ----------- 退出登录
- (void)quitLogin{
    [Tools userDefaultRemoveObjectForKey:@"Login"];
    [Tools userDefaultRemoveObjectForKey:@"Account"];
    [Tools userDefaultRemoveObjectForKey:@"RealName"];
    [Tools userDefaultRemoveObjectForKey:@"OrganizeName"];
    [Tools userDefaultRemoveObjectForKey:@"AreaName"];
    [Tools userDefaultRemoveObjectForKey:@"Token"];
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self presentViewController:loginVC animated:YES completion:nil];
}


@end

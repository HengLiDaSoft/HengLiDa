//
//  ZhanBiViewController.m
//  ManagerCar
//
//  Created by wanshaoyong on 2019/10/14.
//  Copyright © 2019 Henanhld. All rights reserved.
//

#import "ZhanBiViewController.h"
#import "QFDatePickerView.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourViewController.h"
#import "FiveViewController.h"
#import "SixViewController.h"
#import "LoginViewController.h"

@interface ZhanBiViewController ()

@property (nonatomic, strong)UIButton *dateBt;
@property (nonatomic, copy)NSString *dateStr;
@property (nonatomic, copy)NSString *dateString;

@property (nonatomic, copy)NSString *carType;
//总人数
@property (nonatomic, copy)NSString *PersonTotal;
//学时
@property (nonatomic, copy)NSString *BasePeriod;
//完成人数
@property (nonatomic, copy)NSString *FinishNum;
//未完成人数
@property (nonatomic, copy)NSString *TrainNum;
//从业人员完成率
@property (nonatomic, copy)NSString *CertRate;
//学时完成率
@property (nonatomic, copy)NSString *PeriodRate;


@property (nonatomic, strong)UILabel *numLab1;
@property (nonatomic, strong)UILabel *numLab2;
@property (nonatomic, strong)UILabel *numLab3;
@property (nonatomic, strong)UILabel *numLab4;
@property (nonatomic, strong)UILabel *numLab5;
@property (nonatomic, strong)UILabel *numLab6;

@end

@implementation ZhanBiViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self getNowDate];
    if (![Tools UserDefaultObjectForKey:@"Login"]) {
        
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [self presentViewController:loginVC animated:YES completion:nil];
    }else{
        [self getZhanBiData];
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f1f1f1" alpha:1.0];
    
    self.navigationItem.title = @"占比";
}

- (void)creatZhanBiUI{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 5*CHeight, WIDTH, 105*CHeight)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    UILabel *titLab = [[UILabel alloc] initWithFrame:CGRectMake(10*CWidth, 15*CHeight, 220*CWidth, 20*CHeight)];
    titLab.text = @"当月制定计划企业完成情况";
    titLab.textColor = [UIColor blackColor];
    [topView addSubview:titLab];
    
    
    self.dateBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _dateBt.frame = CGRectMake(WIDTH-85*CWidth, 15*CHeight, 75*CWidth, 20*CHeight);
    [_dateBt setTitle:self.dateStr forState:UIControlStateNormal];
    [_dateBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_dateBt addTarget:self action:@selector(selectDate) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:_dateBt];
    
    NSArray *arr = [[NSArray alloc] initWithObjects:@"总表", @"客运", @"危运", @"普货", nil];
    UISegmentedControl *segmentC = [[UISegmentedControl alloc] initWithItems:arr];
    segmentC.frame = CGRectMake(0, 50*CHeight, WIDTH, 55*CHeight);
    //设置Segment的字体
    NSDictionary *dic = @{
                          //1.设置字体样式:例如黑体,和字体大小
                          NSFontAttributeName:[UIFont fontWithName:nil size:18],
                          //2.字体颜色
                          NSForegroundColorAttributeName:[UIColor blackColor]
                          };
    
    [segmentC setTitleTextAttributes:dic forState:UIControlStateNormal];
    segmentC.selectedSegmentIndex = 0;
    [segmentC setTintColor:[UIColor colorWithHexString:@"#48bd72" alpha:1.0]];
    [segmentC addTarget:self action:@selector(selected:) forControlEvents:UIControlEventValueChanged];
    [topView addSubview:segmentC];
    
    UIButton *bt1 = [UIButton buttonWithType:UIButtonTypeCustom];
    bt1.frame = CGRectMake(0, 120*CHeight, WIDTH/2-0.5*CWidth, 130*CHeight);
    bt1.backgroundColor = [UIColor whiteColor];
    bt1.tag = 101;
    [bt1 addTarget:self action:@selector(toVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bt1];
    
    UIImageView *img1 = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH/4-0.5*CWidth/2-25*CWidth, 10*CHeight, 50*CWidth, 50*CWidth)];
    img1.image = [UIImage imageNamed:@"90+900001"];
    [bt1 addSubview:img1];
    
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 70*CHeight, WIDTH/2-0.5*CWidth, 20*CHeight)];
    lab1.textAlignment = NSTextAlignmentCenter;
    lab1.text = @"总/当月(总人数)";
    [bt1 addSubview:lab1];
    
    self.numLab1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 100*CHeight, WIDTH/2-0.5*CWidth, 20*CHeight)];
    _numLab1.textAlignment = NSTextAlignmentCenter;
    _numLab1.textColor = [UIColor orangeColor];
    _numLab1.text = self.PersonTotal;
    _numLab1.font = [UIFont systemFontOfSize:15*CHeight];
    [bt1 addSubview:_numLab1];
    
    UIView *vertical1 = [[UIView alloc] initWithFrame:CGRectMake(WIDTH/2-0.5*CWidth, 120*CHeight, 1*CWidth, 390*CHeight)];
    vertical1.backgroundColor = [UIColor colorWithHexString:@"#f1f1f1" alpha:1.0];
    [self.view addSubview:vertical1];
    
    
    UIButton *bt2 = [UIButton buttonWithType:UIButtonTypeCustom];
    bt2.frame = CGRectMake(WIDTH/2+0.5*CWidth, 120*CHeight, WIDTH/2-0.5*CWidth, 130*CHeight);
    bt2.backgroundColor = [UIColor whiteColor];
    bt2.tag = 102;
    [bt2 addTarget:self action:@selector(toVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bt2];
    
    UIImageView *img2 = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH/4-0.5*CWidth/2-25*CWidth, 10*CHeight, 50*CWidth, 50*CWidth)];
    img2.image = [UIImage imageNamed:@"90+900002"];
    [bt2 addSubview:img2];
    
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 70*CHeight, WIDTH/2-0.5*CWidth, 20*CHeight)];
    lab2.textAlignment = NSTextAlignmentCenter;
    lab2.text = @"总/当月(基础学时)";
    [bt2 addSubview:lab2];
    
    self.numLab2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 100*CHeight, WIDTH/2-0.5*CWidth, 20*CHeight)];
    _numLab2.textAlignment = NSTextAlignmentCenter;
    _numLab2.textColor = [UIColor orangeColor];
    _numLab2.text = self.BasePeriod;
    _numLab2.font = [UIFont systemFontOfSize:15*CHeight];
    [bt2 addSubview:_numLab2];
    
    UIView *level1 = [[UIView alloc] initWithFrame:CGRectMake(0, 249*CHeight, WIDTH, 1*CHeight)];
    level1.backgroundColor = [UIColor colorWithHexString:@"#f1f1f1" alpha:1.0];
    [self.view addSubview:level1];
    
    UIButton *bt3 = [UIButton buttonWithType:UIButtonTypeCustom];
    bt3.frame = CGRectMake(0, 250*CHeight, WIDTH/2-0.5*CWidth, 130*CHeight);
    bt3.backgroundColor = [UIColor whiteColor];
    bt3.tag = 103;
    [bt3 addTarget:self action:@selector(toVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bt3];
    
    UIImageView *img3 = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH/4-0.5*CWidth/2-25*CWidth, 10*CHeight, 50*CWidth, 50*CWidth)];
    img3.image = [UIImage imageNamed:@"90+900003"];
    [bt3 addSubview:img3];
    
    UILabel *lab3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 70*CHeight, WIDTH/2-0.5*CWidth, 20*CHeight)];
    lab3.textAlignment = NSTextAlignmentCenter;
    lab3.text = @"完成人数";
    [bt3 addSubview:lab3];
    
    self.numLab3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 100*CHeight, WIDTH/2-0.5*CWidth, 20*CHeight)];
    _numLab3.textAlignment = NSTextAlignmentCenter;
    _numLab3.textColor = [UIColor orangeColor];
    _numLab3.text = self.FinishNum;
    _numLab3.font = [UIFont systemFontOfSize:15*CHeight];
    [bt3 addSubview:_numLab3];
    
    
    
    UIButton *bt4 = [UIButton buttonWithType:UIButtonTypeCustom];
    bt4.frame = CGRectMake(WIDTH/2+0.5*CWidth, 250*CHeight, WIDTH/2, 130*CHeight);
    bt4.backgroundColor = [UIColor whiteColor];
    bt4.tag = 104;
    [bt4 addTarget:self action:@selector(toVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bt4];
    
    UIImageView *img4 = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH/4-0.5*CWidth-25*CWidth, 10*CHeight, 50*CWidth, 50*CWidth)];
    img4.image = [UIImage imageNamed:@"90+900004"];
    [bt4 addSubview:img4];
    
    UILabel *lab4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 70*CHeight, WIDTH/2-0.5*CWidth, 20*CHeight)];
    lab4.textAlignment = NSTextAlignmentCenter;
    lab4.text = @"未完成人数";
    [bt4 addSubview:lab4];
    
    self.numLab4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 100*CHeight, WIDTH/2-0.5*CWidth, 20*CHeight)];
    _numLab4.textAlignment = NSTextAlignmentCenter;
    _numLab4.textColor = [UIColor orangeColor];
    _numLab4.text = self.TrainNum;
    _numLab4.font = [UIFont systemFontOfSize:15*CHeight];
    [bt4 addSubview:_numLab4];
    
    UIView *level2 = [[UIView alloc] initWithFrame:CGRectMake(0, 379*CHeight, WIDTH, 1*CHeight)];
    level2.backgroundColor = [UIColor colorWithHexString:@"#f1f1f1" alpha:1.0];
    [self.view addSubview:level2];
    
    UIButton *bt5 = [UIButton buttonWithType:UIButtonTypeCustom];
    bt5.frame = CGRectMake(0, 380*CHeight, WIDTH/2-0.5*CWidth, 130*CHeight);
    bt5.backgroundColor = [UIColor whiteColor];
    bt5.tag = 105;
    [bt5 addTarget:self action:@selector(toVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bt5];
    
    UIImageView *img5 = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH/4-0.5*CWidth-25*CWidth, 10*CHeight, 50*CWidth, 50*CWidth)];
    img5.image = [UIImage imageNamed:@"90+900005"];
    [bt5 addSubview:img5];
    
    UILabel *lab5 = [[UILabel alloc] initWithFrame:CGRectMake(0, 70*CHeight, WIDTH/2-0.5*CWidth, 20*CHeight)];
    lab5.textAlignment = NSTextAlignmentCenter;
    lab5.text = @"从业人员完成率";
    [bt5 addSubview:lab5];
    
    self.numLab5 = [[UILabel alloc] initWithFrame:CGRectMake(0, 100*CHeight, WIDTH/2-0.5*CWidth, 20*CHeight)];
    _numLab5.textAlignment = NSTextAlignmentCenter;
    _numLab5.textColor = [UIColor orangeColor];
    _numLab5.text = self.CertRate;
    _numLab5.font = [UIFont systemFontOfSize:15*CHeight];
    [bt5 addSubview:_numLab5];
    
    UIButton *bt6 = [UIButton buttonWithType:UIButtonTypeCustom];
    bt6.frame = CGRectMake(WIDTH/2+0.5*CWidth, 380*CHeight, WIDTH/2, 130*CHeight);
    bt6.backgroundColor = [UIColor whiteColor];
    bt6.tag = 106;
    [bt6 addTarget:self action:@selector(toVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bt6];
    
    UIImageView *img6 = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH/4-0.5*CWidth-25*CWidth, 10*CHeight, 50*CWidth, 50*CWidth)];
    img6.image = [UIImage imageNamed:@"90+900006"];
    [bt6 addSubview:img6];
    
    UILabel *lab6 = [[UILabel alloc] initWithFrame:CGRectMake(0, 70*CHeight, WIDTH/2-0.5*CWidth, 20*CHeight)];
    lab6.textAlignment = NSTextAlignmentCenter;
    lab6.text = @"学时完成率";
    [bt6 addSubview:lab6];
    
    self.numLab6 = [[UILabel alloc] initWithFrame:CGRectMake(0, 100*CHeight, WIDTH/2-0.5*CWidth, 20*CHeight)];
    _numLab6.textAlignment = NSTextAlignmentCenter;
    _numLab6.textColor = [UIColor orangeColor];
    _numLab6.text = self.PeriodRate;
    _numLab6.font = [UIFont systemFontOfSize:15*CHeight];
    [bt6 addSubview:_numLab6];
}

#pragma mark ----------------- 选择日期
- (void)selectDate{
    __weak typeof(self) weakSelf = self;
    QFDatePickerView *datePickerView = [[QFDatePickerView alloc]initDatePackerWithSUperView:self.view response:^(NSString *str) {
        NSArray *strArr = [str componentsSeparatedByString:@"-"];
        if ([strArr[1] length] == 1) {
            weakSelf.dateStr = [NSString stringWithFormat:@"%@-0%@", strArr[0], strArr[1]];
            weakSelf.dateString = [NSString stringWithFormat:@"%@0%@", strArr[0], strArr[1]];
            
            [weakSelf.dateBt setTitle:weakSelf.dateStr forState:UIControlStateNormal];
        }else{
            weakSelf.dateStr = [NSString stringWithFormat:@"%@-%@", strArr[0], strArr[1]];
            weakSelf.dateString = [NSString stringWithFormat:@"%@%@", strArr[0], strArr[1]];
            
            [weakSelf.dateBt setTitle:weakSelf.dateStr forState:UIControlStateNormal];
        }
        
        [weakSelf getZhanBiData];
        
    }];
    [datePickerView show];
    
    
}

- (void)getNowDate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //[formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    [formatter setDateFormat:@"YYYY-MM"];
    //现在时间,你可以输出来看下是什么格式
    NSDate *datenow = [NSDate date];
    //----------将nsdate按formatter格式转成nsstring
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    self.dateStr = currentTimeString;
    NSArray *strArr = [self.dateStr componentsSeparatedByString:@"-"];
    if ([strArr[1] length] == 1) {
        self.dateStr = [NSString stringWithFormat:@"%@-0%@", strArr[0], strArr[1]];
        self.dateString = [NSString stringWithFormat:@"%@0%@", strArr[0], strArr[1]];
    }else{
        self.dateStr = [NSString stringWithFormat:@"%@-%@", strArr[0], strArr[1]];
        self.dateString = [NSString stringWithFormat:@"%@%@", strArr[0], strArr[1]];
    }
    
}

#pragma mark --------------- 跳进对应VC
- (void)toVC:(UIButton *)sender{
    
    if (sender.tag == 101) {
        FirstViewController *firstVC = [[FirstViewController alloc] init];
        self.hidesBottomBarWhenPushed = YES;
        firstVC.allNumType = self.carType;
        firstVC.allNumDate = self.dateString;
        [self.navigationController pushViewController:firstVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
    
    if (sender.tag == 102) {
        SecondViewController *secondVC = [[SecondViewController alloc] init];
        self.hidesBottomBarWhenPushed = YES;
        secondVC.periodType = self.carType;
        secondVC.periodDate = self.dateString;
        [self.navigationController pushViewController:secondVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
    
    if (sender.tag == 103) {
        ThirdViewController *thirdVC = [[ThirdViewController alloc] init];
        self.hidesBottomBarWhenPushed = YES;
        thirdVC.finishType = self.carType;
        thirdVC.finishDate = self.dateString;
        [self.navigationController pushViewController:thirdVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
    
    if (sender.tag == 104) {
        FourViewController *fourVC = [[FourViewController alloc] init];
        self.hidesBottomBarWhenPushed = YES;
        fourVC.unFinishType = self.carType;
        fourVC.unFinishDate = self.dateString;
        [self.navigationController pushViewController:fourVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
    
    if (sender.tag == 105) {
        FiveViewController *fiveVC = [[FiveViewController alloc] init];
        self.hidesBottomBarWhenPushed = YES;
        fiveVC.peopleType = self.carType;
        fiveVC.peopleDate = self.dateString;
        [self.navigationController pushViewController:fiveVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
    
    if (sender.tag == 106) {
        SixViewController *sixVC = [[SixViewController alloc] init];
        self.hidesBottomBarWhenPushed = YES;
        sixVC.learnType = self.carType;
        sixVC.learnDate = self.dateString;
        [self.navigationController pushViewController:sixVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
    
}

#pragma mark --------------- 分段控制器选取不同的值
- (void)selected:(id)sender{
    UISegmentedControl* control = (UISegmentedControl*)sender;
    switch (control.selectedSegmentIndex) {
        case 0:
            self.carType = @"";
            control.selectedSegmentIndex = 0;
            [self getDataAgain];
            break;
        case 1:
            self.carType = @"101";
            control.selectedSegmentIndex = 1;
            [self getDataAgain];
            
            break;
        case 2:
            self.carType = @"106";
            control.selectedSegmentIndex = 2;
            [self getDataAgain];
            
            break;
        case 3:
            self.carType = @"105";
            control.selectedSegmentIndex = 3;
            [self getDataAgain];
            break;
        default:
            break;
    }
}

#pragma mark -------- 获取占比页面数据
- (void)getZhanBiData{
    [SVProgressHUD showWithStatus:@"正在加载数据..."];
    //设置请求参数
    NSDictionary *dictonary;
    if ([Tools isBlankString:self.carType]) {
        dictonary = @{
                      @"CertType":@"",
                      @"PlanDate":self.dateString,
                      };
    }else{
        dictonary = @{
                      @"CertType":self.carType,
                      @"PlanDate":self.dateString,
                      };
    }
    NSString *loginStr = [Tools convertToJsonData:dictonary];
    NSString *loginAES = [AESCrypt encrypt:loginStr password:AESKey];
    NSDictionary *dic = @{@"":loginAES};
    
    [NetworkManager postWithURLString:[Str stringByAppendingString:@"Proportion/Info"] parameters:dic success:^(id responseObject) {
        [SVProgressHUD dismiss];
        if ([responseObject[@"result"] integerValue] == 0) {
            if ([responseObject[@"data"] isKindOfClass:[NSString class]]) {
                NSData *jsonData = [responseObject[@"data"] dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                
                self.PersonTotal = dic[@"PersonTotal"];
                self.BasePeriod = dic[@"BasePeriod"];
                self.FinishNum = dic[@"FinishNum"];
                self.TrainNum = dic[@"TrainNum"];
                self.CertRate = dic[@"CertRate"];
                self.PeriodRate = dic[@"PeriodRate"];
                
                [self creatZhanBiUI];
            }
        }else if ([responseObject[@"result"] integerValue] == -2){
            [Tools userDefaultRemoveObjectForKey:@"Login"];
            [Tools userDefaultRemoveObjectForKey:@"Account"];
            [Tools userDefaultRemoveObjectForKey:@"RealName"];
            [Tools userDefaultRemoveObjectForKey:@"OrganizeName"];
            [Tools userDefaultRemoveObjectForKey:@"AreaName"];
            [Tools userDefaultRemoveObjectForKey:@"Token"];
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            [self presentViewController:loginVC animated:YES completion:nil];
        }else{
            [Tools alterViewShow:responseObject[@"msg"] viewcontroller:self];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [Tools userDefaultRemoveObjectForKey:@"Login"];
        [Tools userDefaultRemoveObjectForKey:@"Account"];
        [Tools userDefaultRemoveObjectForKey:@"RealName"];
        [Tools userDefaultRemoveObjectForKey:@"OrganizeName"];
        [Tools userDefaultRemoveObjectForKey:@"AreaName"];
        [Tools userDefaultRemoveObjectForKey:@"Token"];
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [self presentViewController:loginVC animated:YES completion:nil];
    }];
}

#pragma mark --------- 点击SegementControl重新获取数据
- (void)getDataAgain{
    [SVProgressHUD showWithStatus:@"正在加载数据..."];
    //设置请求参数
    NSDictionary *dictonary;
    if ([Tools isBlankString:self.carType]) {
        dictonary = @{
                      @"CertType":@"",
                      @"PlanDate":self.dateString,
                      };
    }else{
        dictonary = @{
                      @"CertType":self.carType,
                      @"PlanDate":self.dateString,
                      };
    }
    NSString *loginStr = [Tools convertToJsonData:dictonary];
    NSString *loginAES = [AESCrypt encrypt:loginStr password:AESKey];
    NSDictionary *dic = @{@"":loginAES};
    
    [NetworkManager postWithURLString:[Str stringByAppendingString:@"Proportion/Info"] parameters:dic success:^(id responseObject) {
        [SVProgressHUD dismiss];
        if ([responseObject[@"result"] integerValue] == 0) {
            if ([responseObject[@"data"] isKindOfClass:[NSString class]]) {
                NSData *jsonData = [responseObject[@"data"] dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                
                self.PersonTotal = dic[@"PersonTotal"];
                self.BasePeriod = dic[@"BasePeriod"];
                self.FinishNum = dic[@"FinishNum"];
                self.TrainNum = dic[@"TrainNum"];
                self.CertRate = dic[@"CertRate"];
                self.PeriodRate = dic[@"PeriodRate"];
                
                self.numLab1.text = @"";
                self.numLab2.text = @"";
                self.numLab3.text = @"";
                self.numLab4.text = @"";
                self.numLab5.text = @"";
                self.numLab6.text = @"";
                
                self.numLab1.text = self.PersonTotal;
                self.numLab2.text = self.BasePeriod;
                self.numLab3.text = self.FinishNum;
                self.numLab4.text = self.TrainNum;
                self.numLab5.text = self.CertRate;
                self.numLab6.text = self.PeriodRate;
                
            }
        }else if ([responseObject[@"result"] integerValue] == -2){
            [Tools userDefaultRemoveObjectForKey:@"Login"];
            [Tools userDefaultRemoveObjectForKey:@"Account"];
            [Tools userDefaultRemoveObjectForKey:@"RealName"];
            [Tools userDefaultRemoveObjectForKey:@"OrganizeName"];
            [Tools userDefaultRemoveObjectForKey:@"AreaName"];
            [Tools userDefaultRemoveObjectForKey:@"Token"];
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            [self presentViewController:loginVC animated:YES completion:nil];
        }else{
            [Tools alterViewShow:responseObject[@"msg"] viewcontroller:self];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [Tools userDefaultRemoveObjectForKey:@"Login"];
        [Tools userDefaultRemoveObjectForKey:@"Account"];
        [Tools userDefaultRemoveObjectForKey:@"RealName"];
        [Tools userDefaultRemoveObjectForKey:@"OrganizeName"];
        [Tools userDefaultRemoveObjectForKey:@"AreaName"];
        [Tools userDefaultRemoveObjectForKey:@"Token"];
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [self presentViewController:loginVC animated:YES completion:nil];
    }];
}

@end

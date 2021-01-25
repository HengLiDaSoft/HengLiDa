//
//  SixViewController.m
//  ManagerCar
//
//  Created by wanshaoyong on 2019/10/18.
//  Copyright © 2019 Henanhld. All rights reserved.
//

#import "SixViewController.h"
#import "DVFoodPieModel.h"
#import "DVPieChart.h"


@interface SixViewController ()

@property (nonatomic, copy)NSString *sixAllStr;
@property (nonatomic, copy)NSString *sixFinishStr;

@end



@implementation SixViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f1f1f1" alpha:1.0];
    
    self.navigationItem.title = @"学时完成率";
    
    [self customSixLeft];
    [self getLearnRateData];
}

- (void)customSixLeft{
    UIBarButtonItem *ruleLeft = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(sixToZhanBi)];
    ruleLeft.tintColor = [UIColor colorWithHexString:@"#34273a" alpha:1.0];
    self.navigationItem.leftBarButtonItem = ruleLeft;
}

- (void)sixToZhanBi{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)creatSixUI{
    UIView *sixTopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 85*CHeight)];
    sixTopView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:sixTopView];
    
    UILabel *allLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 10*CHeight, WIDTH/2, 25*CHeight)];
    allLab.text = @"总人数";
    allLab.textAlignment = NSTextAlignmentCenter;
    [sixTopView addSubview:allLab];
    
    UILabel *finishLab = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH/2, 10*CHeight, WIDTH/2, 25*CHeight)];
    finishLab.text = @"完成人数";
    finishLab.textAlignment = NSTextAlignmentCenter;
    [sixTopView addSubview:finishLab];
    
    UILabel *sixAllLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 50*CHeight, WIDTH/2, 25*CHeight)];
    sixAllLab.text = [NSString stringWithFormat:@"%ld分钟", [self.sixAllStr integerValue]];
    sixAllLab.textColor = [UIColor orangeColor];
    sixAllLab.textAlignment = NSTextAlignmentCenter;
    [sixTopView addSubview:sixAllLab];
    
    UILabel *sixFinishLab = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH/2, 50*CHeight, WIDTH/2, 25*CHeight)];
    sixFinishLab.text = [NSString stringWithFormat:@"%ld分钟", [self.sixFinishStr integerValue]];
    sixFinishLab.textColor = [UIColor orangeColor];
    sixFinishLab.textAlignment = NSTextAlignmentCenter;
    [sixTopView addSubview:sixFinishLab];
    
    UIView *circleView = [[UIView alloc] initWithFrame:CGRectMake(30*CWidth, 115*CHeight, WIDTH-60*CWidth, 400*CHeight)];
    circleView.layer.cornerRadius = 10*CWidth;
    circleView.layer.masksToBounds = YES;
    circleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:circleView];
    

    DVPieChart *chart = [[DVPieChart alloc] initWithFrame:CGRectMake(0,  0, WIDTH-60*CWidth, 400*CHeight)];
    
    [circleView addSubview:chart];
    
    DVFoodPieModel *model1 = [[DVFoodPieModel alloc] init];
    if ([self.sixFinishStr floatValue] == 0) {
        model1.rate = 0;
        model1.name = [NSString stringWithFormat:@"已完成%@学时", self.sixFinishStr];
        model1.value = [self.sixFinishStr floatValue];
    }else if ([self.sixFinishStr floatValue] == [self.sixAllStr floatValue]){
        model1.rate = 1;
        model1.name = [NSString stringWithFormat:@"已完成%@学时", self.sixFinishStr];
        model1.value = [self.sixFinishStr floatValue];
    }else{
        model1.rate = [self.sixFinishStr floatValue]/[self.sixAllStr floatValue];
        model1.name = [NSString stringWithFormat:@"已完成%@学时", self.sixFinishStr];
        model1.value = [self.sixFinishStr floatValue];
    }
    
    
    DVFoodPieModel *model2 = [[DVFoodPieModel alloc] init];
    if ([self.sixFinishStr floatValue] == 0) {
        model2.rate = 1;
        model2.name = [NSString stringWithFormat:@"未完成%ld学时", [self.sixAllStr integerValue]];
        model2.value = [self.sixAllStr floatValue];
    }else if ([self.sixFinishStr floatValue] == [self.sixAllStr floatValue]){
        model2.rate = 0;
        model2.name = @"未完成0学时";
        model2.value = 0;
    }else{
        model2.rate = 1-model1.rate;
        model2.name = [NSString stringWithFormat:@"未完成%ld学时", [self.sixAllStr integerValue]-[self.sixFinishStr integerValue]];
        model2.value = [self.sixAllStr floatValue] - [self.sixFinishStr floatValue];
    }
    
    
    NSArray *dataArray = @[model1, model2];
    chart.dataArray = dataArray;
    chart.title = @"";
    [chart draw];
}

#pragma mark ----------- 学时完成率6
- (void)getLearnRateData{
    [SVProgressHUD show];
    //设置请求参数
    NSDictionary *dictonary;
    if ([Tools isBlankString:self.learnType]) {
        dictonary = @{
                      @"CertType":@"",
                      @"PlanDate":self.learnDate,
                      };
    }else{
        dictonary = @{
                      @"CertType":self.learnType,
                      @"PlanDate":self.learnDate,
                      };
    }
    
    NSString *loginStr = [Tools convertToJsonData:dictonary];
    NSString *loginAES = [AESCrypt encrypt:loginStr password:AESKey];
    NSDictionary *dic = @{@"":loginAES};
    
    [NetworkManager postWithURLString:[Str stringByAppendingString:@"Proportion/PeriodRate"] parameters:dic success:^(id responseObject) {
        [SVProgressHUD dismiss];
        
        if ([responseObject[@"result"] integerValue] == 0) {
            if ([responseObject[@"data"] isKindOfClass:[NSString class]]) {
                NSData *jsonData = [responseObject[@"data"] dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                
                self.sixAllStr = dic[@"TotalPeriod"];
                self.sixFinishStr = dic[@"FinishPeriod"];
                
                [self creatSixUI];
            }
        }
    } failure:^(NSError *error) {
        
    }];
}

@end

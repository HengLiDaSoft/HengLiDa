//
//  FiveViewController.m
//  ManagerCar
//
//  Created by wanshaoyong on 2019/10/18.
//  Copyright © 2019 Henanhld. All rights reserved.
//

#import "FiveViewController.h"
#import "DVFoodPieModel.h"
#import "DVPieChart.h"

@interface FiveViewController ()

@property (nonatomic, copy)NSString *allStr;
@property (nonatomic, copy)NSString *finishStr;



@end



@implementation FiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f1f1f1" alpha:1.0];
    
    self.navigationItem.title = @"从业人员完成率";
    
    [self customFiveLeft];
    [self getPeopleRateData];
    
}

- (void)customFiveLeft{
    UIBarButtonItem *ruleLeft = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(fiveToZhanBi)];
    ruleLeft.tintColor = [UIColor colorWithHexString:@"#34273a" alpha:1.0];
    self.navigationItem.leftBarButtonItem = ruleLeft;
}

- (void)fiveToZhanBi{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)creatFiveUI{
    UIView *fiveTopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 85*CHeight)];
    fiveTopView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:fiveTopView];
    
    UILabel *allLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 10*CHeight, WIDTH/2, 25*CHeight)];
    allLab.text = @"总人数";
    allLab.textAlignment = NSTextAlignmentCenter;
    [fiveTopView addSubview:allLab];
    
    UILabel *finishLab = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH/2, 10*CHeight, WIDTH/2, 25*CHeight)];
    finishLab.text = @"完成人数";
    finishLab.textAlignment = NSTextAlignmentCenter;
    [fiveTopView addSubview:finishLab];
    
    UILabel *allNumLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 50*CHeight, WIDTH/2, 25*CHeight)];
    allNumLab.text = [NSString stringWithFormat:@"%ld人", [self.allStr integerValue]];
    allNumLab.textColor = [UIColor orangeColor];
    allNumLab.textAlignment = NSTextAlignmentCenter;
    [fiveTopView addSubview:allNumLab];
    
    UILabel *finishNumLab = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH/2, 50*CHeight, WIDTH/2, 25*CHeight)];
    finishNumLab.text = [NSString stringWithFormat:@"%ld人", [self.finishStr integerValue]];
    finishNumLab.textColor = [UIColor orangeColor];
    finishNumLab.textAlignment = NSTextAlignmentCenter;
    [fiveTopView addSubview:finishNumLab];
    
    UIView *circleView = [[UIView alloc] initWithFrame:CGRectMake(30*CWidth, 115*CHeight, WIDTH-60*CWidth, 400*CHeight)];
    circleView.layer.cornerRadius = 10*CWidth;
    circleView.layer.masksToBounds = YES;
    circleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:circleView];
    
    DVPieChart *chart = [[DVPieChart alloc] initWithFrame:CGRectMake(0,  0, WIDTH-60*CWidth, 400*CHeight)];
    
    [circleView addSubview:chart];
    
    DVFoodPieModel *model1 = [[DVFoodPieModel alloc] init];
    if ([self.finishStr floatValue] == 0) {
        model1.rate = 0;
        model1.name = [NSString stringWithFormat:@"已完成%@人", self.finishStr];
        model1.value = [self.finishStr floatValue];
    }else if ([self.finishStr floatValue] == [self.allStr floatValue]){
        model1.rate = 1;
        model1.name = [NSString stringWithFormat:@"已完成%@人", self.finishStr];
        model1.value = [self.finishStr floatValue];
    }else{
        model1.rate = [self.finishStr floatValue]/[self.allStr floatValue];
        model1.name = [NSString stringWithFormat:@"已完成%@人", self.finishStr];
        model1.value = [self.finishStr floatValue];
    }
    
    
    DVFoodPieModel *model2 = [[DVFoodPieModel alloc] init];
    if ([self.finishStr floatValue] == 0) {
        model2.rate = 1;
        model2.name = [NSString stringWithFormat:@"未完成%ld人", [self.allStr integerValue]];
        model2.value = [self.allStr floatValue];
    }else if ([self.finishStr floatValue] == [self.allStr floatValue]){
        model2.rate = 0;
        model2.name = @"未完成0人";
        model2.value = 0;
    }else{
        model2.rate = 1-model1.rate;
        model2.name = [NSString stringWithFormat:@"未完成%ld人", [self.allStr integerValue]-[self.finishStr integerValue]];
        model2.value = [self.allStr floatValue] - [self.finishStr floatValue];
    }
    
    
    NSArray *dataArray = @[model1, model2];
    chart.dataArray = dataArray;
    chart.title = @"";
    [chart draw];
}

#pragma mark ----------- 从业人员完成率5
- (void)getPeopleRateData{
    [SVProgressHUD show];
    //设置请求参数
    NSDictionary *dictonary;
    if ([Tools isBlankString:self.peopleType]) {
        dictonary = @{
                      @"CertType":@"",
                      @"PlanDate":self.peopleDate,
                      };
    }else{
        dictonary = @{
                      @"CertType":self.peopleType,
                      @"PlanDate":self.peopleDate,
                      };
    }
    
    
    NSString *loginStr = [Tools convertToJsonData:dictonary];
    NSString *loginAES = [AESCrypt encrypt:loginStr password:AESKey];
    NSDictionary *dic = @{@"":loginAES};
    
    [NetworkManager postWithURLString:[Str stringByAppendingString:@"Proportion/StuRate"] parameters:dic success:^(id responseObject) {
        [SVProgressHUD dismiss];
        
        if ([responseObject[@"result"] integerValue] == 0) {
            if ([responseObject[@"data"] isKindOfClass:[NSString class]]) {
                NSData *jsonData = [responseObject[@"data"] dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                
                self.allStr = dic[@"TotalNum"];
                self.finishStr = dic[@"FinishNum"];
                
                [self creatFiveUI];
            }
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}
@end

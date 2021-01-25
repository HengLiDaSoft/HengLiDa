//
//  FirstViewController.m
//  ManagerCar
//
//  Created by wanshaoyong on 2019/10/17.
//  Copyright © 2019 Henanhld. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@property (nonatomic, copy)NSString *OrgTotal;
@property (nonatomic, copy)NSString *TotalNum;
@property (nonatomic, copy)NSString *OrgName;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f1f1f1" alpha:1.0];
    
    self.navigationItem.title = @"总/当月(人数)";
    
    [self customFirstLeft];
    [self getCompanyNumData];
    
    
    
}

- (void)customFirstLeft{
    UIBarButtonItem *ruleLeft = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(firstToZhanBi)];
    ruleLeft.tintColor = [UIColor colorWithHexString:@"#34273a" alpha:1.0];
    self.navigationItem.leftBarButtonItem = ruleLeft;
}

- (void)firstToZhanBi{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)creatFirstTab{
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 146*CHeight)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    UILabel *firNumLab = [[UILabel alloc] initWithFrame:CGRectMake(10*CWidth, 10*CHeight, WIDTH-20*CWidth, 25*CHeight)];
    firNumLab.text = self.OrgTotal;
    NSMutableAttributedString *allString = [[NSMutableAttributedString alloc] initWithString:firNumLab.text];
    [allString addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(10, firNumLab.text.length-10)];
    firNumLab.attributedText = allString;
    [topView addSubview:firNumLab];
    
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 45*CHeight, WIDTH, 10*CHeight)];
    grayView.backgroundColor = [UIColor colorWithHexString:@"#f1f1f1" alpha:1.0];
    [topView addSubview:grayView];
    
    UILabel *allLab = [[UILabel alloc] initWithFrame:CGRectMake(10*CWidth, 65*CHeight, 100*CWidth, 25*CHeight)];
    allLab.text = @"总人数";
    allLab.textColor = [UIColor colorWithHexString:@"#51b874" alpha:1.0];
    allLab.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:allLab];
    
    UIView *vView = [[UIView alloc] initWithFrame:CGRectMake(110*CWidth, 60*CHeight, 1*CWidth, 35*CHeight)];
    vView.backgroundColor = [UIColor colorWithHexString:@"#51b874" alpha:1.0];
    [topView addSubview:vView];
    
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(111*CWidth, 65*CHeight, WIDTH-121*CWidth, 25*CHeight)];
    nameLab.textAlignment = NSTextAlignmentCenter;
    nameLab.textColor = [UIColor colorWithHexString:@"#51b874" alpha:1.0];
    nameLab.text = @"企业名";
    [topView addSubview:nameLab];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 100*CHeight, WIDTH, 1*CHeight)];
    line.backgroundColor = [UIColor colorWithHexString:@"#f1f1f1" alpha:1.0];
    [topView addSubview:line];
    
    UILabel *allPeopleLab = [[UILabel alloc] initWithFrame:CGRectMake(10*CWidth, 111*CHeight, 100*CWidth, 25*CHeight)];
    if ([Tools isBlankString:self.TotalNum]) {
        allPeopleLab.text = @"";
    }else if ([self.TotalNum isEqualToString:@"0"]){
        allPeopleLab.text = @"";
    }else{
        allPeopleLab.text = self.TotalNum;
    }
    allPeopleLab.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:allPeopleLab];
    
    UILabel *companyNameLab = [[UILabel alloc] initWithFrame:CGRectMake(111*CWidth, 111*CHeight, WIDTH-121*CWidth, 25*CHeight)];
    companyNameLab.textAlignment = NSTextAlignmentCenter;
    companyNameLab.text = self.OrgName;
    [topView addSubview:companyNameLab];
    
}


#pragma mark ----------- 企业人数接口1
- (void)getCompanyNumData{
    [SVProgressHUD show];
    
    //设置请求参数
    NSDictionary *dictonary;
    if ([Tools isBlankString:self.allNumType]) {
        dictonary = @{
                      @"CertType":@"",
                      @"PlanDate":self.allNumDate,
                      };
    }else{
        dictonary = @{
                      @"CertType":self.allNumType,
                      @"PlanDate":self.allNumDate,
                      };
    }
    NSString *loginStr = [Tools convertToJsonData:dictonary];
    NSString *loginAES = [AESCrypt encrypt:loginStr password:AESKey];
    NSDictionary *dic = @{@"":loginAES};
    
    [NetworkManager postWithURLString:[Str stringByAppendingString:@"Proportion/Org"] parameters:dic success:^(id responseObject) {
        [SVProgressHUD dismiss];
        
        if ([responseObject[@"result"] integerValue] == 0) {
            if ([responseObject[@"data"] isKindOfClass:[NSString class]]) {
                NSData *jsonData = [responseObject[@"data"] dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                
                self.OrgTotal = [NSString stringWithFormat:@"总/当月(总人数)：%@", dic[@"OrgTotal"]];
                self.TotalNum = dic[@"TotalNum"];
                self.OrgName = dic[@"OrgName"];
                [self creatFirstTab];
            }
        }else{
           [Tools alterViewShow:responseObject[@"msg"] viewcontroller:self];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [Tools alterViewShow:@"网络出错" viewcontroller:self];
    }];
}

@end

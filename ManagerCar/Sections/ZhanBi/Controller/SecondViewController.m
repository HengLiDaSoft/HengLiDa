//
//  SecondViewController.m
//  ManagerCar
//
//  Created by wanshaoyong on 2019/10/18.
//  Copyright © 2019 Henanhld. All rights reserved.
//

#import "SecondViewController.h"
#import "FirstCell.h"
#import "PeriodModel.h"

@interface SecondViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *secTab;
@property (nonatomic, strong)NSMutableArray *periodArr;


@end

static NSString *secSrt = @"SecondCell";

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f1f1f1" alpha:1.0];
    
    self.navigationItem.title = @"总/当月(基础学时)";
    
    [self customSecondLeft];
    
    self.periodArr = [NSMutableArray array];
    
    
    [self getPeriodNumData];
    
    [self creatSecondTab];
    
}

- (void)customSecondLeft{
    UIBarButtonItem *ruleLeft = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(secondToZhanBi)];
    ruleLeft.tintColor = [UIColor colorWithHexString:@"#34273a" alpha:1.0];
    self.navigationItem.leftBarButtonItem = ruleLeft;
}

- (void)secondToZhanBi{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)creatSecondTab{
    
    UIView *secondTopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 45*CHeight)];
    secondTopView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:secondTopView];
    
    UILabel *monthLab = [[UILabel alloc] initWithFrame:CGRectMake(10*CWidth, 10*CHeight, 100*CWidth, 25*CHeight)];
    monthLab.text = @"月份";
    monthLab.textColor = [UIColor colorWithHexString:@"#51b874" alpha:1.0];
    monthLab.textAlignment = NSTextAlignmentCenter;
    [secondTopView addSubview:monthLab];
    
    UIView *vView = [[UIView alloc] initWithFrame:CGRectMake(110*CWidth, 5*CHeight, 1*CWidth, 35*CHeight)];
    vView.backgroundColor = [UIColor colorWithHexString:@"#51b874" alpha:1.0];
    [secondTopView addSubview:vView];
    
    UILabel *learnLab = [[UILabel alloc] initWithFrame:CGRectMake(111*CWidth, 10*CHeight, WIDTH-121*CWidth, 25*CHeight)];
    learnLab.textAlignment = NSTextAlignmentCenter;
    learnLab.textColor = [UIColor colorWithHexString:@"#51b874" alpha:1.0];
    learnLab.text = @"学时";
    [secondTopView addSubview:learnLab];
    
    self.secTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 46*CHeight, WIDTH, HEIGHT-64-46*CHeight) style:UITableViewStylePlain];
    _secTab.delegate = self;
    _secTab.dataSource = self;
    [self.view addSubview:_secTab];
}

#pragma mark ------------------ UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.periodArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FirstCell *cell = [tableView dequeueReusableCellWithIdentifier:secSrt];
    if (cell == nil) {
        cell = [[FirstCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:secSrt];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    PeriodModel *model = _periodArr[indexPath.row];
    cell.leftLab.text = model.PlanDate;
    cell.rightLab.text = [NSString stringWithFormat:@"%ld分钟", [model.BasePeriod integerValue]];
    
    return cell;
}

#pragma mark -------------------- UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 0.001f)];
    footView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footView];
    return footView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40*CHeight;
}

#pragma mark ----------- 基础学时2
- (void)getPeriodNumData{
    [SVProgressHUD show];
    //设置请求参数
    NSDictionary *dictonary;
    if ([Tools isBlankString:self.periodType]) {
        dictonary = @{
                      @"CertType":@"",
                      @"PlanDate":self.periodDate,
                      };
    }else{
        dictonary = @{
                      @"CertType":self.periodType,
                      @"PlanDate":self.periodDate,
                      };
    }
    
    NSString *loginStr = [Tools convertToJsonData:dictonary];
    NSString *loginAES = [AESCrypt encrypt:loginStr password:AESKey];
    NSDictionary *dic = @{@"":loginAES};
    
    [NetworkManager postWithURLString:[Str stringByAppendingString:@"Proportion/BasePeriod"] parameters:dic success:^(id responseObject) {
        [SVProgressHUD dismiss];
        if ([responseObject[@"result"] integerValue] == 0) {
            if ([responseObject[@"data"] isKindOfClass:[NSString class]]) {
                NSData *jsonData = [responseObject[@"data"] dataUsingEncoding:NSUTF8StringEncoding];
                NSArray *dicArr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                
                for (NSDictionary *dic in dicArr) {
                    PeriodModel *model = [[PeriodModel alloc] initWithDictionary:dic];
                    [self.periodArr addObject:model];
                }
                
                [self.secTab reloadData];
                
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

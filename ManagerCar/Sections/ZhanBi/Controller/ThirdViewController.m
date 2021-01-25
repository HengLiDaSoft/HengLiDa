//
//  ThirdViewController.m
//  ManagerCar
//
//  Created by wanshaoyong on 2019/10/18.
//  Copyright © 2019 Henanhld. All rights reserved.
//

#import "ThirdViewController.h"
#import "ThirdCell.h"
#import <MJRefresh.h>
#import "FinishModel.h"

@interface ThirdViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *thirdTab;
@property (nonatomic, assign)NSInteger finishPage;
@property (nonatomic, strong)NSMutableArray *finishArr;


@end

static NSString *thirdStr = @"ThirdCell";

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f1f1f1" alpha:1.0];
    
    self.navigationItem.title = @"完成人数";
    
    self.finishArr = [NSMutableArray array];
    
    [self customThirdLeft];
    
    self.finishPage = 1;
    
    [self getFinishNumData];
    
    [self creatThirdTab];
    
    _thirdTab.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.finishPage++;
        [self getFinishNumData];
        [self.thirdTab.mj_footer endRefreshing];
        self.thirdTab.mj_footer.hidden = YES;
    }];
}

- (void)customThirdLeft{
    UIBarButtonItem *ruleLeft = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(thirdToZhanBi)];
    ruleLeft.tintColor = [UIColor colorWithHexString:@"#34273a" alpha:1.0];
    self.navigationItem.leftBarButtonItem = ruleLeft;
}

- (void)thirdToZhanBi{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)creatThirdTab{
    
    UIView *thirdTopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 45*CHeight)];
    thirdTopView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:thirdTopView];
    
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(10*CWidth, 10*CHeight, WIDTH/3-20*CWidth/3, 25*CHeight)];
    nameLab.textAlignment = NSTextAlignmentCenter;
    nameLab.textColor = [UIColor colorWithHexString:@"#51b874" alpha:1.0];
    nameLab.text = @"姓名";
    [thirdTopView addSubview:nameLab];
    
    UIView *firView = [[UIView alloc] initWithFrame:CGRectMake(WIDTH/3-20*CWidth/3, 5*CHeight, 1*CWidth, 35*CHeight)];
    firView.backgroundColor = [UIColor colorWithHexString:@"#51b874" alpha:1.0];
    [thirdTopView addSubview:firView];
    
    UILabel *finishLab = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH/3-20*CWidth/3, 10*CHeight, WIDTH/3-20*CWidth/3, 25*CHeight)];
    finishLab.textAlignment = NSTextAlignmentCenter;
    finishLab.textColor = [UIColor colorWithHexString:@"#51b874" alpha:1.0];
    finishLab.text = @"车牌号";
    [thirdTopView addSubview:finishLab];
    
    UIView *secView = [[UIView alloc] initWithFrame:CGRectMake(2*WIDTH/3-2*20*CWidth/3, 5*CHeight, 1*CWidth, 35*CHeight)];
    secView.backgroundColor = [UIColor colorWithHexString:@"#51b874" alpha:1.0];
    [thirdTopView addSubview:secView];
    
    UILabel *planLab = [[UILabel alloc] initWithFrame:CGRectMake(2*WIDTH/3-2*20*CWidth/3, 10*CHeight, WIDTH/3-20*CWidth/3, 25*CHeight)];
    planLab.textAlignment = NSTextAlignmentCenter;
    planLab.textColor = [UIColor colorWithHexString:@"#51b874" alpha:1.0];
    planLab.text = @"手机号码";
    [thirdTopView addSubview:planLab];
    
    self.thirdTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 46*CHeight, WIDTH, HEIGHT-64-46*CHeight) style:UITableViewStylePlain];
    _thirdTab.delegate = self;
    _thirdTab.dataSource = self;
    [self.view addSubview:_thirdTab];
}


#pragma mark ------------------ UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.finishArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:thirdStr];
    if (cell == nil) {
        cell = [[ThirdCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:thirdStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    FinishModel *model = _finishArr[indexPath.row];
    cell.thirdNameLab.text = model.RealName;
    cell.thirdFinishLab.text = model.License;
    cell.thirdPlanLab.text = model.Phone;
    
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
    return 45*CHeight;
}

#pragma mark ----------- 完成学员信息3
- (void)getFinishNumData{
    [SVProgressHUD show];
    NSString *p = [NSString stringWithFormat:@"%ld", (long)_finishPage];
    //设置请求参数
    NSDictionary *dictonary;
    if ([Tools isBlankString:self.finishType]) {
        dictonary = @{
                      @"CertType":@"",
                      @"PlanDate":self.finishDate,
                      @"CurPage":p,
                      @"PageSize":@"6"
                     };
    }else{
        dictonary = @{
                      @"CertType":self.finishType,
                      @"PlanDate":self.finishDate,
                      @"CurPage":p,
                      @"PageSize":@"6"
                      };
    }
    
    NSString *loginStr = [Tools convertToJsonData:dictonary];
    NSString *loginAES = [AESCrypt encrypt:loginStr password:AESKey];
    NSDictionary *dic = @{@"":loginAES};
    
    [NetworkManager postWithURLString:[Str stringByAppendingString:@"Proportion/FinishStu"] parameters:dic success:^(id responseObject) {
        [SVProgressHUD dismiss];
        if ([responseObject[@"result"] integerValue] == 0) {
            if ([responseObject[@"data"] isKindOfClass:[NSString class]]) {
                NSData *jsonData = [responseObject[@"data"] dataUsingEncoding:NSUTF8StringEncoding];
                
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                
                if ([dic[@"Rows"] isKindOfClass:[NSString class]]) {
                    NSData *jsonData = [dic[@"Rows"] dataUsingEncoding:NSUTF8StringEncoding];
                    
                    NSArray *dicArr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                    
                    for (NSDictionary *diction in dicArr) {
                        FinishModel *model = [[FinishModel alloc] initWithDictionary:diction];
                        [self.finishArr addObject:model];
                    }
                    [self.thirdTab reloadData];
                }
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

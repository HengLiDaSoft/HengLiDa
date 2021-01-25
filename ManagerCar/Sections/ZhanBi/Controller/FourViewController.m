//
//  FourViewController.m
//  ManagerCar
//
//  Created by wanshaoyong on 2019/10/23.
//  Copyright © 2019 Henanhld. All rights reserved.
//

#import "FourViewController.h"
#import "ThirdCell.h"
#import <MJRefresh.h>
#import "FinishModel.h"

@interface FourViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *fourTab;
@property (nonatomic, assign)NSInteger unfinishPage;
@property (nonatomic, strong)NSMutableArray *unFinishArr;

@end

static NSString *fourStr = @"FourCell";

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f1f1f1" alpha:1.0];
    
    self.navigationItem.title = @"未完成人数";
    
    self.unFinishArr = [NSMutableArray array];
    
    [self customFourLeft];
    
    self.unfinishPage = 1;
    
    [self getUnfinishNumData];
    
    [self creatFourTab];
    
    _fourTab.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.unfinishPage++;
        [self getUnfinishNumData];
        [self.fourTab.mj_footer endRefreshing];
        self.fourTab.mj_footer.hidden = YES;
    }];
}

- (void)customFourLeft{
    UIBarButtonItem *ruleLeft = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(fourToZhanBi)];
    ruleLeft.tintColor = [UIColor colorWithHexString:@"#34273a" alpha:1.0];
    self.navigationItem.leftBarButtonItem = ruleLeft;
}

- (void)fourToZhanBi{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)creatFourTab{
    
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
    
    self.fourTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 46*CHeight, WIDTH, HEIGHT-64-46*CHeight) style:UITableViewStylePlain];
    _fourTab.delegate = self;
    _fourTab.dataSource = self;
    [self.view addSubview:_fourTab];
}


#pragma mark ------------------ UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.unFinishArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:fourStr];
    if (cell == nil) {
        cell = [[ThirdCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:fourStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    FinishModel *model = _unFinishArr[indexPath.row];
    
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

#pragma mark ----------- 未完成学员信息4
- (void)getUnfinishNumData{
    [SVProgressHUD show];
    NSString *p = [NSString stringWithFormat:@"%ld", (long)_unfinishPage];
    //设置请求参数
    NSDictionary *dictonary;
    if ([Tools isBlankString:self.unFinishType]) {
        dictonary = @{
                      @"CertType":@"",
                      @"PlanDate":self.unFinishDate,
                      @"CurPage":p,
                      @"PageSize":@"6"
                      };
    }else{
        dictonary = @{
                      @"CertType":self.unFinishType,
                      @"PlanDate":self.unFinishDate,
                      @"CurPage":p,
                      @"PageSize":@"6"
                      };
    }
    
    NSString *loginStr = [Tools convertToJsonData:dictonary];
    NSString *loginAES = [AESCrypt encrypt:loginStr password:AESKey];
    NSDictionary *dic = @{@"":loginAES};
    
    [NetworkManager postWithURLString:[Str stringByAppendingString:@"Proportion/UnfinishStu"] parameters:dic success:^(id responseObject) {
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
                        [self.unFinishArr addObject:model];
                    }
                    [self.fourTab reloadData];
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

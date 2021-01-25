//
//  DetailViewController.m
//  ManagerCar
//
//  Created by wanshaoyong on 2019/10/15.
//  Copyright © 2019 Henanhld. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailCell.h"
#import "LPButton.h"
#import "QFDatePickerView.h"
#import "DetailModel.h"

@interface DetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)LPButton *rtBt;
@property (nonatomic, copy)NSString *detailStr;
@property (nonatomic, copy)NSString *detailString;

@property (nonatomic, strong)NSMutableArray *detailArr;
@property (nonatomic, strong)UITableView *detailTab;


@end

static NSString *detailStr = @"DetailCell";

@implementation DetailViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.detailArr = [NSMutableArray array];
    [self getDetailData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f1f1f1" alpha:1.0];
    
    [self getDetailNowDate];
    self.rtBt = [[LPButton alloc] init];
    _rtBt.style = LPButtonStyleRight;
    _rtBt.space = 1*CWidth;
    [_rtBt setTitle:self.detailStr forState:UIControlStateNormal];
    [_rtBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_rtBt setImage:[UIImage imageNamed:@"xia"] forState:UIControlStateNormal];
    [_rtBt addTarget:self action:@selector(detailSelectDate) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = _rtBt;
    
    [self customDetailLeft];
    
    [self creatDetailTab];
    
}

- (void)customDetailLeft{
    UIBarButtonItem *ruleLeft = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(detaiToJinDu)];
    ruleLeft.tintColor = [UIColor colorWithHexString:@"#34273a" alpha:1.0];
    self.navigationItem.leftBarButtonItem = ruleLeft;
}

- (void)detaiToJinDu{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)creatDetailTab{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 5*CHeight, WIDTH, 82*CHeight)];
    titleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:titleView];
    
    UIImageView *nameImg = [[UIImageView alloc] initWithFrame:CGRectMake(30*CWidth, 10*CHeight, 20*CWidth, 20*CHeight)];
    nameImg.image = [UIImage imageNamed:@"45X45-+100001"];
    [titleView addSubview:nameImg];
    
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(50*CWidth, 10*CHeight, 50*CWidth, 20*CHeight)];
    nameLab.text = @"豆豆";
    [titleView addSubview:nameLab];
    
    
    UIImageView *numImg = [[UIImageView alloc] initWithFrame:CGRectMake(100*CWidth, 10*CHeight, 20*CWidth, 20*CHeight)];
    numImg.image = [UIImage imageNamed:@"45X45-+100002"];
    [titleView addSubview:numImg];
    
    UILabel *numLab = [[UILabel alloc] initWithFrame:CGRectMake(120*CWidth, 10*CHeight, 95*CWidth, 20*CHeight)];
    numLab.text = @"豫A88888";
    [titleView addSubview:numLab];
    
    UIImageView *phoneImg = [[UIImageView alloc] initWithFrame:CGRectMake(215*CWidth, 10*CHeight, 20*CWidth, 20*CHeight)];
    phoneImg.image = [UIImage imageNamed:@"45X45-+100003"];
    [titleView addSubview:phoneImg];
    
    UILabel *phoneLab = [[UILabel alloc] initWithFrame:CGRectMake(235*CWidth, 10*CHeight, 120*CWidth, 20*CHeight)];
    phoneLab.text = @"15536455555";
    [titleView addSubview:phoneLab];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 40*CHeight, WIDTH, 2*CHeight)];
    line.backgroundColor = [UIColor colorWithHexString:@"#f1f1f1" alpha:1.0];
    [titleView addSubview:line];
    
    UILabel *baseLab = [[UILabel alloc] initWithFrame:CGRectMake(30*CWidth, 52*CHeight, WIDTH/2-30*CWidth, 20*CHeight)];
    baseLab.text = @"基础学时：60分钟";
    baseLab.font = [UIFont systemFontOfSize:16*CHeight];
    NSMutableAttributedString *baseString = [[NSMutableAttributedString alloc] initWithString:baseLab.text];
    [baseString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#ff5a00" alpha:1.0] range:NSMakeRange(5, 4)];
    baseLab.attributedText = baseString;
    [titleView addSubview:baseLab];
    
    UILabel *finishLab = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH/2, 52*CHeight, WIDTH/2-30*CWidth, 20*CHeight)];
    finishLab.text = @"已完成学时：60分钟";
    finishLab.font = [UIFont systemFontOfSize:16*CHeight];
    finishLab.textAlignment = NSTextAlignmentRight;
    NSMutableAttributedString *finishString = [[NSMutableAttributedString alloc] initWithString:finishLab.text];
    [finishString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#ff5a00" alpha:1.0] range:NSMakeRange(6, 4)];
    finishLab.attributedText = finishString;
    [titleView addSubview:finishLab];
    
    self.detailTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 88*CHeight, WIDTH, HEIGHT-64-88*CHeight) style:UITableViewStylePlain];
    _detailTab.backgroundColor = [UIColor whiteColor];
    _detailTab.delegate = self;
    _detailTab.dataSource = self;
    [self.view addSubview:_detailTab];
}

#pragma mark --------------- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.detailArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:detailStr];
    if (cell == nil) {
        cell = [[DetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    DetailModel *model = self.detailArr[indexPath.row];
    cell.numberLab.text = [NSString stringWithFormat:@"%ld", indexPath.row+1];
    cell.titleLab.text = model.CourseName;
    
    if ([model.FinishPeriod integerValue] == [model.TotalPeriod integerValue]) {
       cell.downView.frame = CGRectMake(0, 0, cell.upView.frame.size.width, 15*CWidth);
       cell.detailPerLab.frame = CGRectMake(cell.downView.frame.size.width-35*CWidth, 0, 35*CWidth, 15*CHeight);
        cell.detailPerLab.text = @"100%";
    }
    cell.downView.frame = CGRectMake(0, 0, [model.FinishPeriod integerValue]*cell.upView.frame.size.width/[model.TotalPeriod integerValue], 15*CWidth);
    cell.detailPerLab.frame = CGRectMake(cell.downView.frame.size.width, 0, 35*CWidth, 15*CHeight);
    cell.detailPerLab.text = [[NSString stringWithFormat:@"%ld", [model.FinishPeriod integerValue]*100/[model.TotalPeriod integerValue]] stringByAppendingString:@"%"];
    return cell;
}

#pragma mark --------------- UITableViewDelegate

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
    return 80*CHeight;
}


#pragma mark ----------------- 选择日期
- (void)detailSelectDate{
    __weak typeof(self) weakSelf = self;
    QFDatePickerView *datePickerView = [[QFDatePickerView alloc]initDatePackerWithSUperView:self.view response:^(NSString *str) {
        
        NSArray *strArr = [str componentsSeparatedByString:@"-"];
        if ([strArr[1] length] == 1) {
            weakSelf.detailStr = [NSString stringWithFormat:@"%@-0%@", strArr[0], strArr[1]];
            weakSelf.detailString = [NSString stringWithFormat:@"%@0%@", strArr[0], strArr[1]];
            [weakSelf.rtBt setTitle:weakSelf.detailStr forState:UIControlStateNormal];
        }else{
            weakSelf.detailStr = [NSString stringWithFormat:@"%@-%@", strArr[0], strArr[1]];
            weakSelf.detailString = [NSString stringWithFormat:@"%@%@", strArr[0], strArr[1]];
            [weakSelf.rtBt setTitle:weakSelf.detailStr forState:UIControlStateNormal];
        }
        
        [weakSelf getDetailData];
    }];
    [datePickerView show];
    
    
}

- (void)getDetailNowDate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //[formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    [formatter setDateFormat:@"YYYY-MM"];
    //现在时间,你可以输出来看下是什么格式
    NSDate *datenow = [NSDate date];
    //----------将nsdate按formatter格式转成nsstring
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    //    NSArray *strArr = [currentTimeString componentsSeparatedByString:@"-"];
    //    self.dateStr = [NSString stringWithFormat:@"%@年%@月", strArr[0], strArr[1]];
    self.detailStr = currentTimeString;
    NSArray *strArr = [self.detailStr componentsSeparatedByString:@"-"];
    if ([strArr[1] length] == 1) {
        self.detailStr = [NSString stringWithFormat:@"%@-0%@", strArr[0], strArr[1]];
        self.detailString = [NSString stringWithFormat:@"%@0%@", strArr[0], strArr[1]];
    }else{
        self.detailStr = [NSString stringWithFormat:@"%@-%@", strArr[0], strArr[1]];
        self.detailString = [NSString stringWithFormat:@"%@%@", strArr[0], strArr[1]];
    }
}

#pragma mark ------------ 学员课件信息
- (void)getDetailData{
    [self.detailArr removeAllObjects];
    [SVProgressHUD show];
    //设置请求参数
    NSDictionary *dictonary = @{
                                @"CertType":self.detailType,
                                @"PlanDate":self.detailString,
                                @"StuNum":self.detailStuNum
                                };
    
    NSString *loginStr = [Tools convertToJsonData:dictonary];
    NSString *loginAES = [AESCrypt encrypt:loginStr password:AESKey];
    NSDictionary *dic = @{@"":loginAES};
    
    [NetworkManager postWithURLString:[Str stringByAppendingString:@"Schedule/StuCourse"] parameters:dic success:^(id responseObject) {
        [SVProgressHUD dismiss];
        if ([responseObject[@"result"] integerValue] == 0) {
            if ([responseObject[@"data"] isKindOfClass:[NSString class]]) {
                NSData *jsonData = [responseObject[@"data"] dataUsingEncoding:NSUTF8StringEncoding];
                
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                
                if ([dic[@"Rows"] isKindOfClass:[NSString class]]) {
                    NSData *jsonData = [dic[@"Rows"] dataUsingEncoding:NSUTF8StringEncoding];
                    
                    NSArray *dicArr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                    
                    for (NSDictionary *diction in dicArr) {
                        DetailModel *model = [[DetailModel alloc] initWithDictionary:diction];
                        [self.detailArr addObject:model];
                    }
                    [self.detailTab reloadData];
                    
                }
            }
            
        }else{
            [self.detailTab reloadData];
            [Tools alterViewShow:responseObject[@"msg"] viewcontroller:self];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

@end

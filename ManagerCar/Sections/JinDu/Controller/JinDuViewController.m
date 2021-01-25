//
//  JinDuViewController.m
//  ManagerCar
//
//  Created by wanshaoyong on 2019/10/14.
//  Copyright © 2019 Henanhld. All rights reserved.
//

#import "JinDuViewController.h"
#import "JinDuCell.h"
#import "DetailViewController.h"
#import "LPButton.h"
#import "QFDatePickerView.h"
#import <MJRefresh.h>
#import "JinduModel.h"

@interface JinDuViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)LPButton *rightBt;
@property (nonatomic, copy)NSString *jinduStr;
@property (nonatomic, copy)NSString *jinduString;

@property (nonatomic, strong)UITableView *jinduTab;
@property (nonatomic, assign)NSInteger jinduPage;
@property (nonatomic, strong)NSMutableArray *jinduArr;

@end

static NSString *jinduStr = @"JinDuCell";

@implementation JinDuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f1f1f1" alpha:1.0];
    
    [self getjinDuNowDate];
    self.rightBt = [[LPButton alloc] init];
    _rightBt.style = LPButtonStyleRight;
    _rightBt.space = 1;
    [_rightBt setTitle:self.jinduStr forState:UIControlStateNormal];
    [_rightBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_rightBt setImage:[UIImage imageNamed:@"xia"] forState:UIControlStateNormal];
    [_rightBt addTarget:self action:@selector(jinduSelectDate) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = _rightBt;
    
    self.jinduArr = [NSMutableArray array];
    
    self.jinduPage = 1;
    
    [self getJinDuData];
    
    [self creatJinDuTab];
    
    
    /*
    _jinduTab.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (self.jinduArr.count < 6) {
            [self.jinduTab.mj_footer endRefreshing];
            self.jinduTab.mj_footer.hidden = YES;
        }
        self.jinduPage++;
        [self getJinDuData];
        [self.jinduTab.mj_footer endRefreshing];
        self.jinduTab.mj_footer.hidden = YES;
    }];
    */

}

- (void)creatJinDuTab{
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 5*CHeight, WIDTH, 45*CHeight)];
    titleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:titleView];
    
    UILabel *allLab = [[UILabel alloc] initWithFrame:CGRectMake(10*CWidth, 10*CHeight, 100*CWidth, 25*CHeight)];
    allLab.text = @"总人数：2人";
    NSMutableAttributedString *allString = [[NSMutableAttributedString alloc] initWithString:allLab.text];
    [allString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#ff5a00" alpha:1.0] range:NSMakeRange(4, 2)];
    allLab.attributedText = allString;
    [titleView addSubview:allLab];
    
    
    UILabel *finishLab = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH/2, 10*CHeight, WIDTH/2, 25*CHeight)];
    finishLab.text = @"从业人员完成率：100%";
    NSMutableAttributedString *finishString = [[NSMutableAttributedString alloc] initWithString:finishLab.text];
    [finishString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#ff5a00" alpha:1.0] range:NSMakeRange(8, 4)];
    finishLab.attributedText = finishString;
    [titleView addSubview:finishLab];
    
    self.jinduTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 51*CHeight, WIDTH, HEIGHT-64-49-51*CHeight) style:UITableViewStylePlain];
    _jinduTab.backgroundColor = [UIColor whiteColor];
    _jinduTab.delegate = self;
    _jinduTab.dataSource = self;
    [self.view addSubview:_jinduTab];
}

#pragma mark ------------------ UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.jinduArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JinDuCell *cell = [tableView dequeueReusableCellWithIdentifier:jinduStr];
    if (cell == nil) {
        cell = [[JinDuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:jinduStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    JinduModel *model = _jinduArr[indexPath.row];
    cell.numbLab.text = [NSString stringWithFormat:@"%ld", indexPath.row+1];
    cell.nameLab.text = model.RealName;
    cell.numLab.text = model.License;
    cell.finishLab.text = @"客运";
    
    if ([model.PeriodRate integerValue]== 1) {
        cell.topView.frame = CGRectMake(0, 0, cell.bottomView.frame.size.width, 15*CHeight);
        cell.percentLab.frame = CGRectMake(cell.topView.frame.size.width-40*CWidth, 0, 40*CWidth, 15*CHeight);
        cell.percentLab.text = @"100%";
        [cell.topView addSubview:cell.percentLab];
    }else{
        cell.topView.frame = CGRectMake(0, 0, [model.PeriodRate floatValue]*cell.bottomView.frame.size.width, 15*CHeight);
        cell.percentLab.frame = CGRectMake(cell.topView.frame.size.width, 0, 35*CWidth, 15*CHeight);
        cell.percentLab.text = [[NSString stringWithFormat:@"%.f", [model.PeriodRate floatValue]*100] stringByAppendingString:@"%"];
    }
    
    return cell;
}
#pragma mark ------------------- UITableViewDelegate
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JinduModel *model = _jinduArr[indexPath.row];
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    detailVC.detailType = model.CertType;
    detailVC.detailDateStr = self.jinduString;
    detailVC.detailStuNum = model.StuNum;
    [self.navigationController pushViewController:detailVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}


#pragma mark ----------------- 选择日期
- (void)jinduSelectDate{
    __weak typeof(self) weakSelf = self;
    QFDatePickerView *datePickerView = [[QFDatePickerView alloc]initDatePackerWithSUperView:self.view response:^(NSString *str) {
        NSArray *strArr = [str componentsSeparatedByString:@"-"];
        if ([strArr[1] length] == 1) {
            weakSelf.jinduStr = [NSString stringWithFormat:@"%@-0%@", strArr[0], strArr[1]];
            weakSelf.jinduString = [NSString stringWithFormat:@"%@0%@", strArr[0], strArr[1]];
            [weakSelf.rightBt setTitle:weakSelf.jinduStr forState:UIControlStateNormal];
        }else{
            weakSelf.jinduStr = [NSString stringWithFormat:@"%@-%@", strArr[0], strArr[1]];
            weakSelf.jinduString = [NSString stringWithFormat:@"%@%@", strArr[0], strArr[1]];
            [weakSelf.rightBt setTitle:weakSelf.jinduStr forState:UIControlStateNormal];
        }
        
        [weakSelf getJinDuData];
    }];
    [datePickerView show];
}

- (void)getjinDuNowDate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //[formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    [formatter setDateFormat:@"YYYY-MM"];
    //现在时间,你可以输出来看下是什么格式
    NSDate *datenow = [NSDate date];
    //----------将nsdate按formatter格式转成nsstring
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    self.jinduStr = currentTimeString;
    NSArray *strArr = [self.jinduStr componentsSeparatedByString:@"-"];
    if ([strArr[1] length] == 1) {
        self.jinduStr = [NSString stringWithFormat:@"%@-0%@", strArr[0], strArr[1]];
        self.jinduString = [NSString stringWithFormat:@"%@0%@", strArr[0], strArr[1]];
    }else{
        self.jinduStr = [NSString stringWithFormat:@"%@-%@", strArr[0], strArr[1]];
        self.jinduString = [NSString stringWithFormat:@"%@%@", strArr[0], strArr[1]];
    }
}

#pragma mark --------------- 获取进度数据
- (void)getJinDuData{
    [self.jinduArr removeAllObjects];
    [SVProgressHUD show];
    NSString *p = [NSString stringWithFormat:@"%ld", (long)_jinduPage];
    //设置请求参数
    NSDictionary *dictonary = @{
                                @"CertType":@"101",
                                @"PlanDate":self.jinduString,
                                @"CurPage":p,
                                @"PageSize":@"6"
                                };
    
    NSString *loginStr = [Tools convertToJsonData:dictonary];
    NSString *loginAES = [AESCrypt encrypt:loginStr password:AESKey];
    NSDictionary *dic = @{@"":loginAES};
    
    [NetworkManager postWithURLString:[Str stringByAppendingString:@"Schedule/Info"] parameters:dic success:^(id responseObject) {
        [SVProgressHUD dismiss];
        if ([responseObject[@"result"] integerValue] == 0) {
            if ([responseObject[@"data"] isKindOfClass:[NSString class]]) {
                NSData *jsonData = [responseObject[@"data"] dataUsingEncoding:NSUTF8StringEncoding];
                
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                
                if ([dic[@"Rows"] isKindOfClass:[NSString class]]) {
                    NSData *jsonData = [dic[@"Rows"] dataUsingEncoding:NSUTF8StringEncoding];
                    
                    NSArray *dicArr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                    
                    for (NSDictionary *diction in dicArr) {
                        JinduModel *model = [[JinduModel alloc] initWithDictionary:diction];
                        [self.jinduArr addObject:model];
                    }
                    [self.jinduTab reloadData];
                    
                }
                
            }
            
        }else{
            [Tools alterViewShow:responseObject[@"msg"] viewcontroller:self];
        }

    } failure:^(NSError *error) {
        
    }];
}

@end

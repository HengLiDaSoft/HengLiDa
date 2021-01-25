//
//  BarViewController.m
//  ManagerCar
//
//  Created by wanshaoyong on 2019/10/14.
//  Copyright © 2019 Henanhld. All rights reserved.
//

#import "BarViewController.h"
#import "ZhanBiViewController.h"
#import "JinDuViewController.h"
#import "MineViewController.h"


@interface BarViewController ()

@end

@implementation BarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.tintColor = [UIColor colorWithHexString:@"#5ac688" alpha:1.0];
    
    
    //首页
    ZhanBiViewController *zhanbiVC = [[ZhanBiViewController alloc] init];
    UINavigationController *zhanbiNav = [[UINavigationController alloc] initWithRootViewController:zhanbiVC];
    zhanbiNav.tabBarItem.title = @"占比";
    zhanbiNav.tabBarItem.image = [UIImage imageNamed:@"zhanbi_mo"];
    zhanbiNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"zhanbi"] imageWithRenderingMode:UIImageRenderingModeAutomatic];
    
    //安全培训
    JinDuViewController *jinduVC = [[JinDuViewController alloc] init];
    UINavigationController *jinduNav = [[UINavigationController alloc] initWithRootViewController:jinduVC];
    jinduNav.tabBarItem.title = @"进度";
    jinduNav.tabBarItem.image = [UIImage imageNamed:@"jindu_mo"];
    jinduNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"jindu"] imageWithRenderingMode:UIImageRenderingModeAutomatic];
    
    //个人中心
    MineViewController *mineVC = [[MineViewController alloc] init];
    UINavigationController *mineNav = [[UINavigationController alloc] initWithRootViewController:mineVC];
    mineNav.tabBarItem.title = @"我的";
    mineNav.tabBarItem.image = [UIImage imageNamed:@"mine_mo"];
    mineNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"mine"] imageWithRenderingMode:UIImageRenderingModeAutomatic];
    
    self.viewControllers = @[zhanbiNav, jinduNav, mineNav];
    
    
}



@end

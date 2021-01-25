//
//  DetailViewController.h
//  ManagerCar
//
//  Created by wanshaoyong on 2019/10/15.
//  Copyright © 2019 Henanhld. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController

@property (nonatomic, copy)NSString *detailType;
@property (nonatomic, copy)NSString *detailDateStr;
@property (nonatomic, copy)NSString *detailStuNum;

@end

NS_ASSUME_NONNULL_END

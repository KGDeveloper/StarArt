//
//  KGNearConsumptionVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/12/11.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGNearConsumptionVC.h"

@interface KGNearConsumptionVC ()


@end

@implementation KGNearConsumptionVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /** 导航栏标题颜色 */
    [self changeNavBackColor:KGWhiteColor controller:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = KGManColor;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

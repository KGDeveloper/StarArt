//
//  KGCommunityVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/24.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGCommunityVC.h"
#import "KFCircleMenu.h"
#import "KGInstitutionVC.h"
#import "KGDatingVC.h"

@interface KGCommunityVC ()

@end

@implementation KGCommunityVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /** 导航栏标题颜色 */
    [self changeNavBackColor:[UIColor clearColor] controller:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setMenu];
}
/** 旋转球 */
- (void)setMenu{
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"社区背景"];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];
    
    KFCircleMenu *menu = [[KFCircleMenu alloc]initWithFrame:CGRectMake(-(KGScreenWidth + 100)/2,KGScreenHeight/2 - (KGScreenWidth + 100)/2, KGScreenWidth + 100, KGScreenWidth + 100)];
    menu.centerButtonSize = CGSizeMake(0, 0);
    [menu loadButtonWithIcons:@[[UIImage imageNamed:@"jigou"],[UIImage imageNamed:@"shuji"],[UIImage imageNamed:@"toutiao"],[UIImage imageNamed:@"yanchu"],[UIImage imageNamed:@"yishuren"],[UIImage imageNamed:@"zhanlan"],[UIImage imageNamed:@"jiaoyou"],[UIImage imageNamed:@"jigou"],[UIImage imageNamed:@"shuji"],[UIImage imageNamed:@"toutiao"],[UIImage imageNamed:@"yanchu"],[UIImage imageNamed:@"yishuren"],[UIImage imageNamed:@"zhanlan"],[UIImage imageNamed:@"jiaoyou"]] innerCircleRadius:150];
    menu.centerIconType = KFIconTypeCustomImage;
    menu.isOpened = YES;
    menu.offsetAfterOpened = CGSizeMake(50, 50);
    __weak typeof(self) weakSelf = self;
    menu.buttonClickBlock = ^(NSInteger idx) {
        [weakSelf pushViewControllerWithIndex:idx];
    };
    [self.view addSubview:menu];
}
/** 点击跳转页面 */
- (void)pushViewControllerWithIndex:(NSInteger)index{
    if (index == 0 || index == 7) {//:--机构--
        [self pushHideenTabbarViewController:[[KGInstitutionVC alloc]init] animted:YES];
    }else if (index == 1 || index == 8){//:--书籍--
        
    }else if (index == 2 || index == 9){//:--头条--
        
    }else if (index == 3 || index == 10){//:--演出--
        
    }else if (index == 4 || index == 11){//:--艺术人--
        
    }else if (index == 5 || index == 12){//:--展览--
        
    }else if (index == 6 || index == 13){//:--交友--
        [self pushHideenTabbarViewController:[[KGDatingVC alloc]init] animted:YES];
    }
//    dispatch_async(dispatch_get_main_queue(), ^{
//        
//    });
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

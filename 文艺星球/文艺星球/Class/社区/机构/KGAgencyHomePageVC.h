//
//  KGAgencyHomePageVC.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/9.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGBaseViewController.h"


typedef NS_ENUM(NSInteger,KGScenarioStyle) {
    /** 艺术 */
    KGScenarioStyleArts = 0,
    /** 设计 */
    KGScenarioStyleDesign,
    /** 摄影 */
    KGScenarioStylePhotography,
    /** 戏剧 */
    KGScenarioStyleDrama,
    /** 电影 */
    KGScenarioStyleMovies,
    /** 音乐 */
    KGScenarioStyleMusic,
    /** 美食 */
    KGScenarioStyleFood,
    /** 剧院 */
    KGScenarioStyleTheatre,
};

@interface KGAgencyHomePageVC : KGBaseViewController
/** 场景 */
@property (nonatomic,assign) KGScenarioStyle scenarioStyle;

@end


//
//  KGPerformanceDetailVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/19.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGPerformanceDetailVC.h"

@interface KGPerformanceDetailVC ()
/** 底部滚动 */
@property (nonatomic,strong) UIScrollView *backScrollView;
/** 底部半透明图 */
@property (nonatomic,strong) UIImageView *lowImage;
/** 蒙版 */
@property (nonatomic,strong) UIView *maskView;
/** 顶部封面 */
@property (nonatomic,strong) UIImageView *topImage;
/** 名称 */
@property (nonatomic,strong) UILabel *nameLab;
/** 封面下面直线 */
@property (nonatomic,strong) UIView *topLine;
/** 时间标签 */
@property (nonatomic,strong) UIImageView *timeImage;
/** 位置标签 */
@property (nonatomic,strong) UIImageView *locationImage;
/** 演出时间 */
@property (nonatomic,strong) UILabel *timeLab;
/** 演出地点 */
@property (nonatomic,strong) UILabel *locationLab;
/** 价格 */
@property (nonatomic,strong) UILabel *priceLab;
/** 价格参考 */
@property (nonatomic,strong) UIImageView *priceImage;
/** 参演艺人 */
@property (nonatomic,strong) UILabel *staringActorLab;
/** 演出地点 */
@property (nonatomic,strong) UILabel *placeLab;
/** 详情 */
@property (nonatomic,strong) UILabel *detailLab;
/** 底部直线 */
@property (nonatomic,strong) UIView *lowLine;
/** 演出时间 */
@property (nonatomic,strong) UILabel *theShowTimeLab;
/** 演出地点 */
@property (nonatomic,strong) UILabel *theShowPlaceLab;
/** 演出时长 */
@property (nonatomic,strong) UILabel *theShowNeedTimeLab;
/** 其他注意事项 */
@property (nonatomic,strong) UILabel *theOtherLab;

@end

@implementation KGPerformanceDetailVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /** 导航栏标题颜色 */
    [self changeNavBackColor:[UIColor clearColor] controller:self];
    [self changeNavTitleColor:KGWhiteColor font:KGFontSHBold(15) controller:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    /** 定制左侧返回按钮 */
    [self setLeftNavItemWithFrame:CGRectMake(15, 0, 50, 30) title:nil image:[UIImage imageNamed:@"fanhuibai"] font:nil color:nil select:@selector(leftNavAction)];
    self.view.backgroundColor = KGWhiteColor;
    self.title = @"演出详情";
    
    [self setUpBackView];
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 底部滚动 */
- (void)setUpBackView{
    self.backScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, KGScreenHeight)];
    self.backScrollView.showsVerticalScrollIndicator = NO;
    self.backScrollView.showsHorizontalScrollIndicator = NO;
    self.backScrollView.bounces = NO;
    self.backScrollView.backgroundColor = KGWhiteColor;
    self.backScrollView.contentSize = CGSizeMake(KGScreenWidth, 1100);
    if (@available(iOS 11.0, *)) {
        self.backScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.view addSubview:self.backScrollView];
    /** 自适应设置顶部封面 */
    self.lowImage = [UIImageView new];
    self.maskView = [UIView new];
    [self.backScrollView sd_addSubviews:@[self.lowImage,self.maskView]];
    /** 蒙版 */
    self.lowImage.backgroundColor = KGLineColor;
    self.lowImage.contentMode = UIViewContentModeScaleAspectFill;
    self.lowImage.sd_layout
    .leftEqualToView(self.backScrollView)
    .topEqualToView(self.backScrollView)
    .rightEqualToView(self.backScrollView)
    .autoHeightRatio(0.64);
    self.maskView.backgroundColor = [KGBlackColor colorWithAlphaComponent:0.3];
    self.maskView.sd_layout
    .leftEqualToView(self.lowImage)
    .rightEqualToView(self.lowImage)
    .topEqualToView(self.lowImage)
    .bottomEqualToView(self.lowImage);
    /** 封面下面直线 */
    self.topLine = [UIView new];
    [self.backScrollView addSubview:self.topLine];
    self.topLine.backgroundColor = KGLineColor;
    self.topLine.sd_layout
    .leftEqualToView(self.backScrollView)
    .rightEqualToView(self.backScrollView)
    .topSpaceToView(self.lowImage, 0)
    .heightIs(10);
    /** 封面 */
    self.topImage = [UIImageView new];
    [self.backScrollView addSubview:self.topImage];
    self.topImage.backgroundColor = KGBlueColor;
    self.topImage.layer.cornerRadius = 5;
    self.topImage.layer.masksToBounds = YES;
    self.topImage.contentMode = UIViewContentModeScaleAspectFill;
    self.topImage.sd_layout
    .leftSpaceToView(self.backScrollView, 15)
    .bottomSpaceToView(self.topLine, 25)
    .widthIs(110)
    .heightIs(140);
    /** 名称 */
    self.nameLab = [UILabel new];
    self.nameLab.text = @"开心麻花爆笑舞台剧《李茶的姑妈》明星版";
    self.nameLab.numberOfLines = 0;
    self.nameLab.textColor = KGWhiteColor;
    self.nameLab.font = KGFontSHBold(14);
    [self.backScrollView addSubview:self.nameLab];
    self.nameLab.sd_layout
    .leftSpaceToView(self.topImage, 15)
    .topEqualToView(self.topImage)
    .rightSpaceToView(self.backScrollView, 15)
    .autoHeightRatio(0);
    /** 时间 */
    self.timeImage = [UIImageView new];
    [self.backScrollView addSubview:self.timeImage];
    self.timeImage.image = [UIImage imageNamed:@"yanchushijian"];
    self.timeImage.contentMode = UIViewContentModeScaleAspectFit;
    self.timeImage.sd_layout
    .leftSpaceToView(self.topImage, 15)
    .topSpaceToView(self.nameLab, 10)
    .widthIs(12)
    .heightIs(12);
    self.timeLab = [UILabel new];
    [self.backScrollView addSubview:self.timeLab];
    self.timeLab.text = @"2018-10-12至2018-11-20";
    self.timeLab.textColor = KGWhiteColor;
    self.timeLab.font = KGFontSHRegular(11);
    self.timeLab.sd_layout
    .leftSpaceToView(self.timeImage, 5)
    .rightSpaceToView(self.backScrollView, 15)
    .centerYEqualToView(self.timeImage)
    .heightIs(11);
    /** 定位 */
    self.locationImage = [UIImageView new];
    [self.backScrollView addSubview:self.locationImage];
    self.locationImage.image = [UIImage imageNamed:@"xiangqingdingwei"];
    self.locationImage.contentMode = UIViewContentModeScaleAspectFit;
    self.locationImage.sd_layout
    .leftSpaceToView(self.topImage, 15)
    .topSpaceToView(self.timeImage, 10)
    .widthIs(12)
    .heightIs(12);
    self.locationLab = [UILabel new];
    [self.backScrollView addSubview:self.locationLab];
    self.locationLab.text = @"北京市北京展览馆剧场";
    self.locationLab.textColor = KGWhiteColor;
    self.locationLab.font = KGFontSHRegular(11);
    self.locationLab.sd_layout
    .leftSpaceToView(self.timeImage, 5)
    .rightSpaceToView(self.backScrollView, 15)
    .centerYEqualToView(self.locationImage)
    .heightIs(11);
    /** 价格 */
    self.priceLab = [UILabel new];
    [self.backScrollView addSubview:self.priceLab];
    self.priceLab.textColor = KGBlueColor;
    self.priceLab.text = @"￥80-1080";
    self.priceLab.font = KGFontSHRegular(11);
    self.priceLab.sd_layout
    .leftSpaceToView(self.topImage, 15)
    .topSpaceToView(self.locationImage, 10)
    .widthIs(60)
    .heightIs(11);
    self.priceImage = [UIImageView new];
    [self.backScrollView addSubview:self.priceImage];
    self.priceImage.image = [UIImage imageNamed:@"jingongcankao"];
    self.priceImage.contentMode = UIViewContentModeScaleAspectFit;
    self.priceImage.sd_layout
    .leftSpaceToView(self.priceLab, 5)
    .centerYEqualToView(self.priceLab)
    .widthIs(45)
    .heightIs(15);
    /** 演出详情 */
    UILabel *performLab = [UILabel new];
    [self.backScrollView addSubview:performLab];
    performLab.text = @"演出详情";
    performLab.textColor = KGBlackColor;
    performLab.font = KGFontSHBold(14);
    performLab.sd_layout
    .leftSpaceToView(self.backScrollView, 15)
    .rightSpaceToView(self.backScrollView, 15)
    .topSpaceToView(self.topLine, 0)
    .heightIs(50);
    /** 直线 */
    UIView *topTinyLine = [UIView new];
    [self.backScrollView addSubview:topTinyLine];
    topTinyLine.backgroundColor = KGLineColor;
    topTinyLine.sd_layout
    .leftSpaceToView(self.backScrollView, 15)
    .rightSpaceToView(self.backScrollView, 15)
    .topSpaceToView(performLab, 0)
    .heightIs(1);
    /** 参演人员 */
    self.staringActorLab = [UILabel new];
    [self.backScrollView addSubview:self.staringActorLab];
    self.staringActorLab.textColor = KGBlackColor;
    self.staringActorLab.text = @"参演艺人：肖亚丽、理解为、赵雨萌";
    self.staringActorLab.font = KGFontSHBold(14);
    self.staringActorLab.sd_layout
    .leftSpaceToView(self.backScrollView, 15)
    .rightSpaceToView(self.backScrollView, 15)
    .topSpaceToView(topTinyLine, 15)
    .heightIs(14);
    /** 演出地点 */
    self.placeLab = [UILabel new];
    [self.backScrollView addSubview:self.placeLab];
    self.placeLab.textColor = KGBlackColor;
    self.placeLab.text = @"演出场地：伏虎是人名体育馆";
    self.placeLab.font = KGFontSHBold(14);
    self.placeLab.sd_layout
    .leftSpaceToView(self.backScrollView, 15)
    .rightSpaceToView(self.backScrollView, 15)
    .topSpaceToView(self.staringActorLab, 15)
    .heightIs(14);
    /** 详情 */
    self.detailLab = [UILabel new];
    [self.backScrollView addSubview:self.detailLab];
    self.detailLab.textColor = KGBlackColor;
    self.detailLab.text = @"找出2个人族主角剑侠客、巫蛮儿以下谁有可能是杀破狼的师傅大大王、地藏王以下谁与猪八戒有爱情纠葛嫦娥仙子、卵二姐、高翠兰找出2个魔族主角找出2个人族主角剑侠客、巫蛮儿以下谁有可能是杀破狼的师傅大大王、地藏王以下谁与猪八戒有爱情纠葛嫦娥仙子、卵二姐、高翠兰找出2个魔族主角找出2个人族主角剑侠客、巫蛮儿以下谁有可能是杀破狼的师傅大大王、地藏王以下谁与猪八戒有爱情纠葛嫦娥仙子、卵二姐、高翠兰找出2个魔族主角找出2个人族主角剑侠客、巫蛮儿以下谁有可能是杀破狼的师傅大大王、地藏王以下谁与猪八戒有爱情纠葛嫦娥仙子、卵二姐、高翠兰找出2个魔族主角找出2个人族主角剑侠客、巫蛮儿以下谁有可能是杀破狼的师傅大大王、地藏王以下谁与猪八戒有爱情纠葛嫦娥仙子、卵二姐、高翠兰找出2个魔族主角找出2个人族主角剑侠客、巫蛮儿以下谁有可能是杀破狼的师傅大大王、地藏王以下谁与猪八戒有爱情纠葛嫦娥仙子、卵二姐、高翠兰找出2个魔族主角找出2个人族主角剑侠客、巫蛮儿以下谁有可能是杀破狼的师傅大大王、地藏王以下谁与猪八戒有爱情纠葛嫦娥仙子、卵二姐、高翠兰找出2个魔族主角找出2个人族主角剑侠客、巫蛮儿以下谁有可能是杀破狼的师傅大大王、地藏王以下谁与猪八戒有爱情纠葛嫦娥仙子、卵二姐、高翠兰找出2个魔族主角找出2个人族主角剑侠客、巫蛮儿以下谁有可能是杀破狼的师傅大大王、地藏王以下谁与猪八戒有爱情纠葛嫦娥仙子、卵二姐、高翠兰找出2个魔族主角找出2个人族主角剑侠客、巫蛮儿以下谁有可能是杀破狼的师傅大大王、地藏王以下谁与猪八戒有爱情纠葛嫦娥仙子、卵二姐、高翠兰找出2个魔族主角找出2个人族主角剑侠客、巫蛮儿以下谁有可能是杀破狼的师傅大大王、地藏王以下谁与猪八戒有爱情纠葛嫦娥仙子、卵二姐、高翠兰找出2个魔族主角找出2个人族主角剑侠客、巫蛮儿以下谁有可能是杀破狼的师傅大大王、地藏王以下谁与猪八戒有爱情纠葛嫦娥仙子、卵二姐、高翠兰找出2个魔族主角";
    self.detailLab.font = KGFontSHRegular(13);
    self.detailLab.numberOfLines = 0;
    self.detailLab.sd_layout
    .leftSpaceToView(self.backScrollView, 15)
    .rightSpaceToView(self.backScrollView, 15)
    .topSpaceToView(self.placeLab, 20)
    .maxHeightIs(310)
    .autoHeightRatio(0);
    /** 底部直线 */
    self.lowLine = [UIView new];
    [self.backScrollView addSubview:self.lowLine];
    self.lowLine.backgroundColor = KGLineColor;
    self.lowLine.sd_layout
    .leftSpaceToView(self.backScrollView, 0)
    .rightSpaceToView(self.backScrollView, 0)
    .topSpaceToView(self.detailLab, 20)
    .heightIs(10);
    /** 注意事项 */
    UILabel *amattersNeedingAttentionLab = [UILabel new];
    [self.backScrollView addSubview:amattersNeedingAttentionLab];
    amattersNeedingAttentionLab.textColor = KGBlackColor;
    amattersNeedingAttentionLab.text = @"注意事项";
    amattersNeedingAttentionLab.font = KGFontSHBold(14);
    amattersNeedingAttentionLab.sd_layout
    .leftSpaceToView(self.backScrollView, 15)
    .rightSpaceToView(self.backScrollView, 15)
    .topSpaceToView(self.lowLine, 0)
    .heightIs(50);
    /** 直线 */
    UIView *lowTinyLine = [UIView new];
    [self.backScrollView addSubview:lowTinyLine];
    lowTinyLine.backgroundColor = KGLineColor;
    lowTinyLine.sd_layout
    .leftSpaceToView(self.backScrollView, 15)
    .rightSpaceToView(self.backScrollView, 15)
    .topSpaceToView(amattersNeedingAttentionLab, 0)
    .heightIs(1);
    /** 演出时间 */
    UILabel *showTimeLab = [UILabel new];
    [self.backScrollView addSubview:showTimeLab];
    showTimeLab.textColor = KGBlackColor;
    showTimeLab.text = @"演出时间";
    showTimeLab.font = KGFontSHBold(14);
    showTimeLab.sd_layout
    .leftSpaceToView(self.backScrollView, 15)
    .rightSpaceToView(self.backScrollView, 15)
    .topSpaceToView(lowTinyLine, 15)
    .heightIs(14);
    /** 演出时间 */
    self.theShowTimeLab = [UILabel new];
    [self.backScrollView addSubview:self.theShowTimeLab];
    self.theShowTimeLab.text = @"2018-1-26日17：00-21：00";
    self.theShowTimeLab.textColor = [UIColor colorWithHexString:@"#666666"];
    self.theShowTimeLab.font = KGFontSHRegular(13);
    self.theShowTimeLab.sd_layout
    .leftSpaceToView(self.backScrollView, 15)
    .rightSpaceToView(self.backScrollView, 15)
    .topSpaceToView(showTimeLab, 15)
    .heightIs(13);
    /** 演出地点 */
    UILabel *showPlace = [UILabel new];
    [self.backScrollView addSubview:showPlace];
    showPlace.textColor = KGBlackColor;
    showPlace.text = @"演出地点";
    showPlace.font = KGFontSHBold(14);
    showPlace.sd_layout
    .leftSpaceToView(self.backScrollView, 15)
    .rightSpaceToView(self.backScrollView, 15)
    .topSpaceToView(self.theShowTimeLab, 15)
    .heightIs(14);
    /** 演出时间 */
    self.theShowPlaceLab = [UILabel new];
    [self.backScrollView addSubview:self.theShowPlaceLab];
    self.theShowPlaceLab.text = @"羌胡是人名体育馆";
    self.theShowPlaceLab.textColor = [UIColor colorWithHexString:@"#666666"];
    self.theShowPlaceLab.font = KGFontSHRegular(13);
    self.theShowPlaceLab.sd_layout
    .leftSpaceToView(self.backScrollView, 15)
    .rightSpaceToView(self.backScrollView, 15)
    .topSpaceToView(showPlace, 15)
    .heightIs(13);
    /** 演出时长 */
    UILabel *showNeedTimeLab = [UILabel new];
    [self.backScrollView addSubview:showNeedTimeLab];
    showNeedTimeLab.textColor = KGBlackColor;
    showNeedTimeLab.text = @"演出时长";
    showNeedTimeLab.font = KGFontSHBold(14);
    showNeedTimeLab.sd_layout
    .leftSpaceToView(self.backScrollView, 15)
    .rightSpaceToView(self.backScrollView, 15)
    .topSpaceToView(self.theShowPlaceLab, 15)
    .heightIs(14);
    /** 演出时长 */
    self.theShowNeedTimeLab = [UILabel new];
    [self.backScrollView addSubview:self.theShowNeedTimeLab];
    self.theShowNeedTimeLab.text = @"具体时长以实际演出为准";
    self.theShowNeedTimeLab.textColor = [UIColor colorWithHexString:@"#666666"];
    self.theShowNeedTimeLab.font = KGFontSHRegular(13);
    self.theShowNeedTimeLab.sd_layout
    .leftSpaceToView(self.backScrollView, 15)
    .rightSpaceToView(self.backScrollView, 15)
    .topSpaceToView(showNeedTimeLab, 15)
    .heightIs(13);
    /** 其他注意事项 */
    UILabel *otherLab = [UILabel new];
    [self.backScrollView addSubview:otherLab];
    otherLab.textColor = KGBlackColor;
    otherLab.text = @"其他注意事项";
    otherLab.font = KGFontSHBold(14);
    otherLab.sd_layout
    .leftSpaceToView(self.backScrollView, 15)
    .rightSpaceToView(self.backScrollView, 15)
    .topSpaceToView(self.theShowNeedTimeLab, 15)
    .heightIs(14);
    /** 其他注意事项 */
    self.theOtherLab = [UILabel new];
    [self.backScrollView addSubview:self.theOtherLab];
    self.theOtherLab.text = @"1.2米以下儿童谢绝入内\n1.2米以上儿童需要持入场券\n禁止携带食品入内";
    self.theOtherLab.textColor = [UIColor colorWithHexString:@"#666666"];
    self.theOtherLab.font = KGFontSHRegular(13);
    self.theOtherLab.numberOfLines = 0;
    self.theOtherLab.sd_layout
    .leftSpaceToView(self.backScrollView, 15)
    .rightSpaceToView(self.backScrollView, 15)
    .topSpaceToView(otherLab, 15)
    .autoHeightRatio(0);
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

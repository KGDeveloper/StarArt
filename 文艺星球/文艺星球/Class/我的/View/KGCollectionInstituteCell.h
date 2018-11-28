//
//  KGCollectionInstituteCell.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/31.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KGCollectionInstituteCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cusTomImage;
/** 修改view宽度，改变编辑状态 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *changeViewWidth;
/** 选择删除 */
@property (weak, nonatomic) IBOutlet UIButton *chooseBtu;
/** 介绍 */
@property (weak, nonatomic) IBOutlet UILabel *introductionLab;
/** 地址 */
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
/** 距离 */
@property (weak, nonatomic) IBOutlet UILabel *distanceLab;
/** 评分 */
@property (weak, nonatomic) IBOutlet UILabel *scoreLab;
/** 名称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIImageView *oneSatr;
@property (weak, nonatomic) IBOutlet UIImageView *twoStar;
@property (weak, nonatomic) IBOutlet UIImageView *threeStar;
@property (weak, nonatomic) IBOutlet UIImageView *fourStar;
@property (weak, nonatomic) IBOutlet UIImageView *fiveStar;
/** 修改评分 */
- (void)changeStarWithScroe:(NSInteger)scroe;
/** 开始编辑 */
- (void)starEdit;
/** 结束编辑 */
- (void)endEdit;

@end

NS_ASSUME_NONNULL_END

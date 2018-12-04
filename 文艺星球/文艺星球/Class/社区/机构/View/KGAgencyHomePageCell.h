//
//  KGAgencyHomePageCell.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/9.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KGAgencyHomePageCell : UITableViewCell
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *customImage;
/** 名称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
/** 星星 */
@property (weak, nonatomic) IBOutlet UIImageView *oneStar;
/** 星星 */
@property (weak, nonatomic) IBOutlet UIImageView *twoStar;
/** 星星 */
@property (weak, nonatomic) IBOutlet UIImageView *threeStar;
/** 星星 */
@property (weak, nonatomic) IBOutlet UIImageView *fourStar;
/** 星星 */
@property (weak, nonatomic) IBOutlet UIImageView *fiveStar;
/** 评分 */
@property (weak, nonatomic) IBOutlet UILabel *scoreLab;
/** 距离 */
@property (weak, nonatomic) IBOutlet UILabel *distanceLab;
/** 地址 */
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
/** 介绍 */
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
/** 内容填充 */
- (void)cellDetailWithDictionary:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END

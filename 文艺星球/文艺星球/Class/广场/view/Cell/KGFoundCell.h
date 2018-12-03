//
//  KGFoundCell.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/6.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KGFoundCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *backImage;
@property (weak, nonatomic) IBOutlet UIImageView *oneStar;
@property (weak, nonatomic) IBOutlet UIImageView *twoStar;
@property (weak, nonatomic) IBOutlet UIImageView *threeStar;
@property (weak, nonatomic) IBOutlet UIImageView *fourStar;
@property (weak, nonatomic) IBOutlet UIImageView *fiveStar;
@property (weak, nonatomic) IBOutlet UIImageView *leftImage;
@property (weak, nonatomic) IBOutlet UIImageView *centerImage;
@property (weak, nonatomic) IBOutlet UIImageView *rightImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *englishLab;
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *classLab;
/** 数据填充 */
- (void)sendModelToCell:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END

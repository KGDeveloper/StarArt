//
//  KGBooksCell.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/13.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KGBooksCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *customImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIImageView *onrStar;
@property (weak, nonatomic) IBOutlet UIImageView *twoStar;
@property (weak, nonatomic) IBOutlet UIImageView *threeStar;
@property (weak, nonatomic) IBOutlet UIImageView *fourStar;
@property (weak, nonatomic) IBOutlet UIImageView *fiveStar;
@property (weak, nonatomic) IBOutlet UILabel *socreLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;

/** 填充 */
- (void)cellDetailWithDactionary:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END

//
//  KGInstitutionMoviesDetailCell.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/12/8.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KGInstitutionMoviesDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cusImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *classLab;
@property (weak, nonatomic) IBOutlet UILabel *locationLab;
/** 填充内容 */
- (void)cellDetailWithDictionary:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END

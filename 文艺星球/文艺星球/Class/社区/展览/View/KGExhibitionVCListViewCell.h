//
//  KGExhibitionVCListViewCell.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/21.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KGExhibitionVCListViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *customImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;

/** 填充cell内容 */
- (void)cellDetailWithDictionary:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END

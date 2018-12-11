//
//  KGArtisticPeopleCell.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/19.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KGArtisticPeopleCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *customImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIButton *sexBtu;
@property (weak, nonatomic) IBOutlet UILabel *foucsLab;
@property (weak, nonatomic) IBOutlet UILabel *professLab;
@property (weak, nonatomic) IBOutlet UIButton *locationBtu;

- (void)cellDetailWithDictionary:(NSDictionary *)dic;


@end

NS_ASSUME_NONNULL_END

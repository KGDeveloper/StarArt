//
//  KGNewsCell.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/15.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KGNewsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *customImage;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIButton *shareBtu;
@property (weak, nonatomic) IBOutlet UIButton *commendBtu;
@property (weak, nonatomic) IBOutlet UIButton *zansBtu;

@end

NS_ASSUME_NONNULL_END

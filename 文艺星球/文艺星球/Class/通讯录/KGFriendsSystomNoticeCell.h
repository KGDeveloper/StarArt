//
//  KGFriendsSystomNoticeCell.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/12/13.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KGFriendsSystomNoticeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailHeight;

@end

NS_ASSUME_NONNULL_END

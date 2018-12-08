//
//  KGBooksView.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/13.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KGBooksView : UIView
@property (strong, nonatomic) IBOutlet KGBooksView *customView;

@property (weak, nonatomic) IBOutlet UIImageView *booksImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *socreLab;
@property (weak, nonatomic) IBOutlet UIImageView *oneStar;
@property (weak, nonatomic) IBOutlet UIImageView *twoStar;
@property (weak, nonatomic) IBOutlet UIImageView *threeStar;
@property (weak, nonatomic) IBOutlet UIImageView *fourStar;
@property (weak, nonatomic) IBOutlet UIImageView *fiveStar;


@end

NS_ASSUME_NONNULL_END

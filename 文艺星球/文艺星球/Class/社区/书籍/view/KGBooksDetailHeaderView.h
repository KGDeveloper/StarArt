//
//  KGBooksDetailHeaderView.h
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/14.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KGBooksDetailHeaderView : UIView
/** 底层view */
@property (strong, nonatomic) IBOutlet KGBooksDetailHeaderView *contentView;
/** 底层背景图 */
@property (weak, nonatomic) IBOutlet UIImageView *customBackImage;
/** 蒙版view */
@property (weak, nonatomic) IBOutlet UIView *markView;
/** 书籍封面 */
@property (weak, nonatomic) IBOutlet UIImageView *booksImage;
/** 书名 */
@property (weak, nonatomic) IBOutlet UILabel *bookName;
@property (weak, nonatomic) IBOutlet UIImageView *oneStar;
@property (weak, nonatomic) IBOutlet UIImageView *twoStar;
@property (weak, nonatomic) IBOutlet UIImageView *threeStar;
@property (weak, nonatomic) IBOutlet UIImageView *fourStar;
@property (weak, nonatomic) IBOutlet UIImageView *fiveStar;
/** 作者名 */
@property (weak, nonatomic) IBOutlet UILabel *workerNameLab;
/** 出版社 */
@property (weak, nonatomic) IBOutlet UILabel *pressLab;
/** 出版时间 */
@property (weak, nonatomic) IBOutlet UILabel *pressTimeLab;
/** 想读 */
@property (weak, nonatomic) IBOutlet UIButton *wantToReadBtu;
/** 在读 */
@property (weak, nonatomic) IBOutlet UIButton *readingBtu;
/** 评分 */
@property (weak, nonatomic) IBOutlet UIButton *scoreBtu;
/** 书评view */
@property (weak, nonatomic) IBOutlet UIView *bookReviewView;
/** 书籍状态 */
@property (weak, nonatomic) IBOutlet UIButton *bookStateBtu;
/** 书评 */
@property (weak, nonatomic) IBOutlet UILabel *reviewLab;
/** 读过 */
@property (weak, nonatomic) IBOutlet UIButton *finishReadBtu;
/** 简介 */
@property (weak, nonatomic) IBOutlet UILabel *bookIntroudceLab;
/** 作者照片 */
@property (weak, nonatomic) IBOutlet UIImageView *workerPhotoImage;
/** 作者姓名 */
@property (weak, nonatomic) IBOutlet UILabel *workerLab;
/** 作者生日籍贯 */
@property (weak, nonatomic) IBOutlet UILabel *brithdayLab;
/** 代表作 */
@property (weak, nonatomic) IBOutlet UILabel *magnumOpusLab;
/** 评论列表 */
@property (weak, nonatomic) IBOutlet UILabel *commendLab;
/** 我要评分 */
@property (weak, nonatomic) IBOutlet UIButton *wantToScroeBtu;
/** 评论用户头像 */
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
/** 评论用户昵称 */
@property (weak, nonatomic) IBOutlet UILabel *userNameLab;
/** 用户评论内容 */
@property (weak, nonatomic) IBOutlet UILabel *userCommendLab;
/** 用户评论时间 */
@property (weak, nonatomic) IBOutlet UILabel *userTimeLab;
/** 评论被点赞次数 */
@property (weak, nonatomic) IBOutlet UIButton *userZansBtu;
/** 查看全部评论 */
@property (weak, nonatomic) IBOutlet UIButton *pushAllCommendView;

@end

NS_ASSUME_NONNULL_END

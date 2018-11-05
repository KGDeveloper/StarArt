//
//  KGSquareDetailVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/5.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGSquareDetailVC.h"
#import "KGSquareDetailCell.h"
#import "KGReleaseTF.h"

typedef NS_ENUM(NSInteger,DATASTYLE) {
    DATASTYLE_LeftAliment = 0,
    DATASTYLE_CenterAliment,
    DATASTYLE_RightTopAliment,
    DATASTYLE_RightCenterAliment,
    DATASTYLE_RoundAliment,
};

@interface KGSquareDetailVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
/** 头像 */
@property (nonatomic,strong) UIImageView *headerImage;
/** 昵称 */
@property (nonatomic,strong) UILabel *nameLab;
/** 发布时间 */
@property (nonatomic,strong) UILabel *timeLab;
/** 文本view */
@property (nonatomic,strong) UIView *contextView;
/** 图片view */
@property (nonatomic,strong) UIScrollView *photosView;
/** 底部常规组件 */
@property (nonatomic,strong) UIView *bottomView;
/** 位置 */
@property (nonatomic,strong) UIButton *locationBtu;
/** 点赞 */
@property (nonatomic,strong) UIButton *zansBtu;
/** 收藏 */
@property (nonatomic,strong) UIImageView *contellionImage;
/** 评论 */
@property (nonatomic,strong) UIButton *commentBtu;
/** 头视图 */
@property (nonatomic,strong) UIView *backView;
/** 样式 */
@property (nonatomic,assign) DATASTYLE style;
/** 详情 */
@property (nonatomic,strong) UITableView *listView;
/** 写评论或者回复 */
@property (nonatomic,strong) KGReleaseTF *wirteCommentView;

@end

@implementation KGSquareDetailVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /** 导航栏标题颜色 */
    [self changeNavTitleColor:KGBlackColor font:KGFontSHBold(15) controller:self];
    [self changeNavBackColor:KGWhiteColor controller:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 定制左侧返回按钮 */
    [self setLeftNavItemWithFrame:CGRectZero title:nil image:[UIImage imageNamed:@"fanhui"] font:nil color:nil select:@selector(leftNavAction)];
    /** 定制右侧返回按钮 */
    [self setRightNavItemWithFrame:CGRectZero title:@"关注" image:nil font:KGFontSHRegular(13) color:KGBlueColor select:@selector(rightNavAction)];
    /** 导航栏标题 */
    self.title = @"动态详情";
    self.view.backgroundColor = KGWhiteColor;
    
    self.style = DATASTYLE_RightCenterAliment;
    [self setUpListView];
    [self setCommentVIew];
    [self setContentStr:@"君不见，黄河之水天上来，奔流到海不复回！君不见，高堂明月悲白发，朝成青丝暮成雪！人生得意须尽欢，莫使金樽空对月！天生我才必有用，千金散尽还复来！烹羊宰牛且为乐，会须一饮三百杯！"];
    [self setPhotosArr:@[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1541414693009&di=635ed83436598dfdde0b01598452e936&imgtype=0&src=http%3A%2F%2Fi2.hdslb.com%2Fbfs%2Farchive%2Fd042d658bd575b27795ff660720aa3d8f2eb2203.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1541414693008&di=f33ea846c0e1af93ee24df14fee2d52c&imgtype=0&src=http%3A%2F%2Fi0.hdslb.com%2Fbfs%2Farchive%2F243efa18e8a34fb4c5c4cf0590704b7ed8180f53.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1541414693007&di=ede4d5a307fb27fc65dccba1346f42f5&imgtype=0&src=http%3A%2F%2Fatt2.citysbs.com%2Ftiaozao%2F2014%2F05%2F19%2F15%2F2592x1552-155516_14381400486116459_f7155a6e18f86b83a19d55de4c3f0704.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1541414693005&di=349bf1201b53911319486638f42253d7&imgtype=0&src=http%3A%2F%2Ffile.mumayi.com%2Fforum%2F201412%2F27%2F201015d652uc1l5tbxbmzb.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1541414739316&di=ce619c961d28d578ef78074f0fad5e77&imgtype=jpg&src=http%3A%2F%2Fimg0.imgtn.bdimg.com%2Fit%2Fu%3D2815243985%2C324467483%26fm%3D214%26gp%3D0.jpg"]];
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 导航栏右侧点击事件 */
- (void)rightNavAction{
    if ([self.rightNavItem.currentTitle isEqualToString:@"关注"]) {
        [self.rightNavItem setTitle:@"已关注" forState:UIControlStateNormal];
        [self.rightNavItem setTitleColor:KGGrayColor forState:UIControlStateNormal];
    }else{
        [self.rightNavItem setTitle:@"关注" forState:UIControlStateNormal];
        [self.rightNavItem setTitleColor:KGBlueColor forState:UIControlStateNormal];
    }
}
/** 头部用户信息 */
- (void)setHeaderView{
    /** 用户头像 */
    self.headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 30, 30)];
    self.headerImage.backgroundColor = KGLineColor;
    self.headerImage.layer.cornerRadius = 15;
    self.headerImage.layer.masksToBounds = YES;
    [self.backView addSubview:self.headerImage];
    /** 用户昵称 */
    self.nameLab = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, KGScreenWidth - 70, 13)];
    self.nameLab.text = @"轩哥哥";
    self.nameLab.textColor = KGBlueColor;
    self.nameLab.font = KGFontSHRegular(13);
    [self.backView addSubview:self.nameLab];
    /** 发布时间 */
    self.timeLab = [[UILabel alloc]initWithFrame:CGRectMake(55, 31, KGScreenWidth - 70, 9)];
    self.timeLab.text = @"3分钟前";
    self.timeLab.textColor = KGGrayColor;
    self.timeLab.font = KGFontSHRegular(9);
    [self.backView addSubview:self.timeLab];
}
/** 横向排版 */
- (UIView *)headerHorizontalView{
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, (KGScreenWidth - 30)/69*46 + 285)];
    self.contextView = [[UIView alloc]initWithFrame:CGRectMake(0, 60, KGScreenWidth, 105)];
    [self.backView addSubview:self.contextView];
    
    self.photosView = [[UIScrollView alloc]initWithFrame:CGRectMake(15, 190, KGScreenWidth - 30, (KGScreenWidth - 30)/69*46)];
    self.photosView.pagingEnabled = YES;
    self.photosView.showsVerticalScrollIndicator = NO;
    self.photosView.showsHorizontalScrollIndicator = NO;
    [self.backView addSubview:self.photosView];
    return self.backView;
}
/** 纵向排版 */
- (UIView *)headerVerticalView{
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, (KGScreenWidth - 140)/5*7 + 155)];
    self.contextView = [[UIView alloc]initWithFrame:CGRectMake(KGScreenWidth - 110, 60, 110, (KGScreenWidth - 140)/5*7)];
    [self.backView addSubview:self.contextView];
    
    self.photosView = [[UIScrollView alloc]initWithFrame:CGRectMake(15, 60, KGScreenWidth - 140, (KGScreenWidth - 140)/5*7)];
    self.photosView.pagingEnabled = YES;
    self.photosView.showsVerticalScrollIndicator = NO;
    self.photosView.showsHorizontalScrollIndicator = NO;
    [self.backView addSubview:self.photosView];
    return self.backView;
}
/** 圆图排版 */
- (UIView *)headerRoundView{
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, 230 + 285)];
    self.contextView = [[UIView alloc]initWithFrame:CGRectMake(0, 60, KGScreenWidth, 105)];
    [self.backView addSubview:self.contextView];
    
    self.photosView = [[UIScrollView alloc]initWithFrame:CGRectMake((KGScreenWidth - 230)/2, 190, 230, 230)];
    self.photosView.pagingEnabled = YES;
    self.photosView.showsVerticalScrollIndicator = NO;
    self.photosView.showsHorizontalScrollIndicator = NO;
    [self.backView addSubview:self.photosView];
    return self.backView;
}
/** 创建文本显示 */
- (void)setContentStr:(NSString *)contentStr{
    /** 如果包含特殊字符句号，就以特殊字符切割 */
    if ([contentStr rangeOfString:@"。"].location != NSNotFound) {
        NSArray *endArr = [contentStr componentsSeparatedByString:@"。"];
        __block NSMutableArray *markArr = [NSMutableArray array];
        [endArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj rangeOfString:@"！"].location != NSNotFound) {
                NSArray *tmp = [obj componentsSeparatedByString:@"！"];
                [markArr addObjectsFromArray:tmp];
            }else{
                [markArr addObject:obj];
            }
        }];
        [self setLabelWithArr:markArr];
        /** 如果包含特殊字符感叹号，就以特殊字符切割 */
    }else if ([contentStr rangeOfString:@"！"].location != NSNotFound) {
        NSArray *endArr = [contentStr componentsSeparatedByString:@"！"];
        __block NSMutableArray *markArr = [NSMutableArray array];
        [endArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj rangeOfString:@"。"].location != NSNotFound) {
                NSArray *tmp = [obj componentsSeparatedByString:@"。"];
                [markArr addObjectsFromArray:tmp];
            }else{
                [markArr addObject:obj];
            }
        }];
        [self setLabelWithArr:markArr];
        /** 如果不包含特殊字符，那就20个字一行切割 */
    }else{
        if (contentStr.length > 20) {
            NSString *one = [contentStr substringToIndex:20];
            NSString *oneEnd = [[contentStr componentsSeparatedByString:one] lastObject];
            if (oneEnd.length > 20) {
                NSString *two = [oneEnd substringToIndex:20];
                NSString *twoEnd = [[oneEnd componentsSeparatedByString:two] lastObject];
                if (twoEnd.length > 20) {
                    NSString *three = [twoEnd substringToIndex:20];
                    NSString *threeEnd = [[twoEnd componentsSeparatedByString:three] lastObject];
                    if (threeEnd.length > 20) {
                        NSString *four = [threeEnd substringToIndex:20];
                        NSString *fourEnd = [[threeEnd componentsSeparatedByString:four] lastObject];
                        if (fourEnd.length > 20) {
                            NSString *five = [fourEnd substringToIndex:20];
                            [self setLabelWithArr:@[one,two,three,four,five]];
                        }else{
                            [self setLabelWithArr:@[one,two,three,four,fourEnd]];
                        }
                    }else{
                        [self setLabelWithArr:@[one,two,three,threeEnd]];
                    }
                }else{
                    [self setLabelWithArr:@[one,two,twoEnd]];
                }
            }else{
                [self setLabelWithArr:@[one,oneEnd]];
            }
        }else{
            [self setLabelWithArr:@[contentStr]];
        }
    }
}
/** 创建label */
- (void)setLabelWithArr:(NSArray *)arr{
    if (arr.count > 0) {
        switch (self.style) {
            case DATASTYLE_LeftAliment:/** 横向排版居左 */
                self.listView.tableHeaderView = [self headerHorizontalView];
                for (int i = 0; i < arr.count; i++) {
                    UILabel *tmp = [[UILabel alloc]initWithFrame:CGRectMake(15,23*i, KGScreenWidth - 30, 13)];
                    tmp.text = arr[i];
                    tmp.textColor = KGBlackColor;
                    tmp.font = KGFontFZ(13);
                    [self.contextView addSubview:tmp];
                }
                self.contextView.frame = CGRectMake(0, 60, KGScreenWidth, 23*arr.count);
                self.backView.frame = CGRectMake(0, 0, KGScreenWidth, 23*arr.count + (KGScreenWidth - 30)/69*46 + 155);
                [self setLabAligment:NSTextAlignmentLeft];
                break;
            case DATASTYLE_CenterAliment:/** 横向排版居中 */
                self.listView.tableHeaderView = [self headerHorizontalView];
                for (int i = 0; i < arr.count; i++) {
                    UILabel *tmp = [[UILabel alloc]initWithFrame:CGRectMake(15,23*i, KGScreenWidth - 30, 13)];
                    tmp.text = arr[i];
                    tmp.textColor = KGBlackColor;
                    tmp.font = KGFontFZ(13);
                    [self.contextView addSubview:tmp];
                }
                self.contextView.frame = CGRectMake(0, 60, KGScreenWidth, 23*arr.count);
                self.backView.frame = CGRectMake(0, 0, KGScreenWidth, 23*arr.count + (KGScreenWidth - 30)/69*46 + 155);
                [self setLabAligment:NSTextAlignmentCenter];
                break;
            case DATASTYLE_RightTopAliment:/** 竖向排版居上 */
                self.listView.tableHeaderView = [self headerVerticalView];
                for (int i = 0; i < arr.count; i++) {
                    UILabel *tmp = [[UILabel alloc]initWithFrame:CGRectMake(self.contextView.bounds.size.width - 28 - 23*i,0, 13, [arr[i] boundingRectWithSize:CGSizeMake(13, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:KGFontFZ(13)} context:nil].size.height)];
                    tmp.text = arr[i];
                    tmp.numberOfLines = 0;
                    tmp.textColor = KGBlackColor;
                    tmp.font = KGFontFZ(13);
                    tmp.textAlignment = NSTextAlignmentLeft;
                    [self.contextView addSubview:tmp];
                }
                break;
            
            case DATASTYLE_RightCenterAliment:/** 竖向排版居中 */
                self.listView.tableHeaderView = [self headerVerticalView];
                for (int i = 0; i < arr.count; i++) {
                    UILabel *tmp = [[UILabel alloc]initWithFrame:CGRectMake(self.contextView.bounds.size.width - 28 - 23*i,0, 13,[arr[i] boundingRectWithSize:CGSizeMake(13, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:KGFontFZ(13)} context:nil].size.height)];
                    tmp.center = CGPointMake(self.contextView.bounds.size.width - 28 - 23*i + 7, self.contextView.bounds.origin.y + self.contextView.bounds.size.height/2);
                    tmp.text = arr[i];
                    tmp.numberOfLines = 0;
                    tmp.textColor = KGBlackColor;
                    tmp.font = KGFontFZ(13);
                    tmp.textAlignment = NSTextAlignmentRight;
                    [self.contextView addSubview:tmp];
                }
                break;
            case DATASTYLE_RoundAliment:/** 横向排版居中 */
                self.listView.tableHeaderView = [self headerRoundView];
                for (int i = 0; i < arr.count; i++) {
                    UILabel *tmp = [[UILabel alloc]initWithFrame:CGRectMake(15,23*i, KGScreenWidth - 30, 13)];
                    tmp.text = arr[i];
                    tmp.textColor = KGBlackColor;
                    tmp.font = KGFontFZ(13);
                    [self.contextView addSubview:tmp];
                }
                self.contextView.frame = CGRectMake(0, 60, KGScreenWidth, 23*arr.count);
                self.backView.frame = CGRectMake(0, 0, KGScreenWidth, 23*arr.count + 230 + 155);
                [self setLabAligment:NSTextAlignmentCenter];
                break;
                
            default:
                break;
        }
    }
    [self setHeaderView];
    [self setUpBottomView];
    [self.listView reloadData];
}
/** 创建Imageview */
- (void)setPhotosArr:(NSArray *)photosArr{
    if (photosArr.count > 0) {
        switch (self.style) {
            case DATASTYLE_RoundAliment:
                self.photosView.contentSize = CGSizeMake(230*photosArr.count, 230);
                for (int i = 0; i < photosArr.count; i++) {
                    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(230*i, 0, 230, 230)];
                    [image sd_setImageWithURL:[NSURL URLWithString:photosArr[i]]];
                    image.contentMode = UIViewContentModeScaleAspectFill;
                    image.layer.cornerRadius = 115;
                    image.layer.masksToBounds = YES;
                    [self.photosView addSubview:image];
                }
                break;
            case DATASTYLE_LeftAliment:
                self.photosView.contentSize = CGSizeMake((KGScreenWidth - 30)*photosArr.count, (KGScreenWidth - 30)/69*46);
                for (int i = 0; i < photosArr.count; i++) {
                    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake((KGScreenWidth - 30)*i, 0, KGScreenWidth - 30, (KGScreenWidth - 30)/69*46)];
                    [image sd_setImageWithURL:[NSURL URLWithString:photosArr[i]]];
                    image.contentMode = UIViewContentModeScaleAspectFill;
                    image.layer.cornerRadius = 5;
                    image.layer.masksToBounds = YES;
                    [self.photosView addSubview:image];
                }
                break;
            case DATASTYLE_CenterAliment:
                self.photosView.contentSize = CGSizeMake((KGScreenWidth - 30)*photosArr.count, (KGScreenWidth - 30)/69*46);
                for (int i = 0; i < photosArr.count; i++) {
                    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake((KGScreenWidth - 30)*i, 0, KGScreenWidth - 30, (KGScreenWidth - 30)/69*46)];
                    [image sd_setImageWithURL:[NSURL URLWithString:photosArr[i]]];
                    image.contentMode = UIViewContentModeScaleAspectFill;
                    image.layer.cornerRadius = 5;
                    image.layer.masksToBounds = YES;
                    [self.photosView addSubview:image];
                }
                break;
            case DATASTYLE_RightTopAliment:
                self.photosView.contentSize = CGSizeMake((KGScreenWidth - 140)*photosArr.count, (KGScreenWidth - 140)/5*7);
                for (int i = 0; i < photosArr.count; i++) {
                    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake((KGScreenWidth - 140)*i, 0, (KGScreenWidth - 140), (KGScreenWidth - 140)/5*7)];
                    [image sd_setImageWithURL:[NSURL URLWithString:photosArr[i]]];
                    image.contentMode = UIViewContentModeScaleAspectFill;
                    image.layer.cornerRadius = 5;
                    image.layer.masksToBounds = YES;
                    [self.photosView addSubview:image];
                }
                break;
            case DATASTYLE_RightCenterAliment:
                self.photosView.contentSize = CGSizeMake((KGScreenWidth - 140)*photosArr.count, (KGScreenWidth - 140)/5*7);
                for (int i = 0; i < photosArr.count; i++) {
                    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake((KGScreenWidth - 140)*i, 0, (KGScreenWidth - 140), (KGScreenWidth - 140)/5*7)];
                    [image sd_setImageWithURL:[NSURL URLWithString:photosArr[i]]];
                    image.contentMode = UIViewContentModeScaleAspectFill;
                    image.layer.cornerRadius = 5;
                    image.layer.masksToBounds = YES;
                    [self.photosView addSubview:image];
                }
                break;
                
            default:
                break;
        }
    }
    [self.listView reloadData];
}
/** 文本对其 */
- (void)setLabAligment:(NSTextAlignment)labAligment{
    for (id obj in self.contextView.subviews) {
        if ([obj isKindOfClass:[UILabel class]]) {
            UILabel *tmp = obj;
            tmp.textAlignment = labAligment;
        }
    }
}
/** 底部组件 */
- (void)setUpBottomView{
    self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.photosView.frame.origin.y + self.photosView.frame.size.height + 15, KGScreenWidth, 95)];
    [self.backView addSubview:self.bottomView];
    
    self.locationBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.locationBtu.frame = CGRectMake(15, 0, KGScreenWidth - 30, 15);
    [self.locationBtu setImage:[UIImage imageNamed:@"dingwei"] forState:UIControlStateNormal];
    [self.locationBtu setTitle:@"北京798艺术区" forState:UIControlStateNormal];
    [self.locationBtu setTitleColor:KGBlueColor forState:UIControlStateNormal];
    self.locationBtu.titleLabel.font = KGFontSHRegular(11);
    self.locationBtu.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    self.locationBtu.userInteractionEnabled = NO;
    self.locationBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.bottomView addSubview:self.locationBtu];
    
    self.contellionImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 30, 11, 14)];
    self.contellionImage.image = [UIImage imageNamed:@"shoucang (2)"];
    self.contellionImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.bottomView addSubview:self.contellionImage];
    
    /** 评论 */
    self.commentBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.commentBtu.frame = CGRectMake(KGScreenWidth - 90, 30, 75, 20);
    [self.commentBtu setTitle:@"232" forState:UIControlStateNormal];
    [self.commentBtu setTitleColor:KGGrayColor forState:UIControlStateNormal];
    [self.commentBtu setImage:[UIImage imageNamed:@"pinglun"] forState:UIControlStateNormal];
    self.commentBtu.titleLabel.font = KGFontSHRegular(13);
    self.commentBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.commentBtu.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [self.commentBtu addTarget:self action:@selector(commentAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:self.commentBtu];
    /** 点赞 */
    self.zansBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.zansBtu.frame = CGRectMake(KGScreenWidth - 165, 30, 75, 20);
    [self.zansBtu setTitle:@"232" forState:UIControlStateNormal];
    [self.zansBtu setTitleColor:KGGrayColor forState:UIControlStateNormal];
    [self.zansBtu setImage:[UIImage imageNamed:@"dianzan (2)"] forState:UIControlStateNormal];
    self.zansBtu.titleLabel.font = KGFontSHRegular(13);
    self.zansBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.zansBtu.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [self.zansBtu addTarget:self action:@selector(zansAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:self.zansBtu];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 60, KGScreenWidth, 20)];
    line.backgroundColor = KGLineColor;
    [self.bottomView addSubview:line];
    
    UILabel *tmp = [[UILabel alloc]initWithFrame:CGRectMake(15, 60, KGScreenWidth - 30, 20)];
    tmp.text = @"所有评论";
    tmp.textColor = KGGrayColor;
    tmp.font = KGFontSHRegular(10);
    [self.bottomView addSubview:tmp];
    
}
/** 评论 */
- (void)commentAction:(UIButton *)sender{
    
}
/** 评论 */
- (void)zansAction:(UIButton *)sender{
    if ([sender.currentImage isEqual:[UIImage imageNamed:@"dianzan (2)"]]) {
        [sender setImage:[UIImage imageNamed:@"dianzan"] forState:UIControlStateNormal];
    }else{
        [sender setImage:[UIImage imageNamed:@"dianzan (2)"] forState:UIControlStateNormal];
    }
}
/** 详情列表 */
- (void)setUpListView{
    self.listView = [[UITableView alloc]initWithFrame:CGRectMake(0, KGRectNavAndStatusHight, KGScreenWidth, KGScreenHeight - KGRectNavAndStatusHight)];
    self.listView.delegate = self;
    self.listView.dataSource = self;
    self.listView.emptyDataSetSource = self;
    self.listView.emptyDataSetDelegate = self;
    self.listView.tableFooterView = [UIView new];
    self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.listView.showsVerticalScrollIndicator = NO;
    self.listView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.listView];
    
    [self.listView registerNib:[UINib nibWithNibName:@"KGSquareDetailCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGSquareDetailCell"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KGSquareDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGSquareDetailCell"];
    return cell;
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"404"];
}
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"可能因为网络原因加载失败，请点击刷新";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName:[UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName:paragraph
                                 };
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    // 设置按钮标题
    NSString *buttonTitle = @"重新加载";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:14.0f],NSForegroundColorAttributeName:KGBlueColor
                                 };
    return [[NSAttributedString alloc] initWithString:buttonTitle attributes:attributes];
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    
}
/** 写评论或者回复 */
- (void)setCommentVIew{
    self.wirteCommentView = [[KGReleaseTF alloc]initWithFrame:CGRectMake(0, KGScreenHeight - 50, KGScreenWidth, 50)];
    self.wirteCommentView.placeholder = @"写个评论吧";
    self.wirteCommentView.textColor = KGBlackColor;
    self.wirteCommentView.font = KGFontSHRegular(12);
    self.wirteCommentView.leftView = [UIView new];
    self.wirteCommentView.backgroundColor = KGWhiteColor;
    UIButton *releaseBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    releaseBtu.frame = CGRectMake(0, 0, 50, 25);
    [releaseBtu setTitle:@"发布" forState:UIControlStateNormal];
    [releaseBtu setTitleColor:KGGrayColor forState:UIControlStateNormal];
    releaseBtu.titleLabel.font = KGFontSHRegular(10);
    [releaseBtu addTarget:self action:@selector(releaseAction:) forControlEvents:UIControlEventTouchUpInside];
    self.wirteCommentView.rightView = releaseBtu;
    self.wirteCommentView.rightViewMode = UITextFieldViewModeAlways;
    [self.view insertSubview:self.wirteCommentView atIndex:99];
}
/** 发布按钮 */
- (void)releaseAction:(UIButton *)sender{
    NSLog(@"%@",self.wirteCommentView.text);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

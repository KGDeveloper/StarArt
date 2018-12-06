//
//  KGPreviewVerticalView.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/2.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGPreviewVerticalView.h"

@interface KGPreviewVerticalView ()
/** 保存切割字符串 */
@property (nonatomic,strong) NSMutableArray *titleArr;
/** 显示文本 */
@property (nonatomic,strong) UIView *labView;
/** 加载图片 */
@property (nonatomic,strong) UIScrollView *scrollImage;

@end

@implementation KGPreviewVerticalView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.titleArr = [NSMutableArray array];
        [self setLab];
    }
    return self;
}
/** 创建文本显示 */
- (void)setContentStr:(NSString *)contentStr{
    _contentStr = contentStr;
    if ([contentStr rangeOfString:@"\n"].location != NSNotFound) {
        NSArray *endArr = [contentStr componentsSeparatedByString:@"\n"];
        [self setLabelWithArr:endArr];
    }else{
        if (contentStr.length > 16) {
            NSString *one = [contentStr substringToIndex:16];
            NSString *oneEnd = [[contentStr componentsSeparatedByString:one] lastObject];
            if (oneEnd.length > 16) {
                NSString *two = [oneEnd substringToIndex:16];
                NSString *twoEnd = [[oneEnd componentsSeparatedByString:two] lastObject];
                if (twoEnd.length > 16) {
                    NSString *three = [twoEnd substringToIndex:16];
                    NSString *threeEnd = [[twoEnd componentsSeparatedByString:three] lastObject];
                    if (threeEnd.length > 16) {
                        NSString *four = [threeEnd substringToIndex:16];
                        NSString *fourEnd = [[threeEnd componentsSeparatedByString:four] lastObject];
                        if (fourEnd.length > 16) {
                            NSString *five = [fourEnd substringToIndex:16];
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
/** 创建View */
- (void)setLab{
    
    self.scrollImage = [[UIScrollView alloc]initWithFrame:CGRectMake(15, 0, KGScreenWidth - 140, (KGScreenWidth - 140)/5*7)];
    self.scrollImage.pagingEnabled = YES;
    self.scrollImage.showsVerticalScrollIndicator = NO;
    self.scrollImage.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollImage];
    
    self.labView = [[UIView alloc]initWithFrame:CGRectMake(KGScreenWidth - 110, 0, 110, (KGScreenWidth - 140)/5*7)];
    [self addSubview:self.labView];
}
/** 创建label */
- (void)setLabelWithArr:(NSArray *)arr{
    self.titleArr = [NSMutableArray arrayWithArray:arr];
    if (arr.count > 0) {
        for (int i = 0; i < arr.count; i++) {
            UILabel *tmp = [[UILabel alloc]initWithFrame:CGRectMake(self.labView.bounds.size.width - 28 - 23*i,0, 13, [arr[i] boundingRectWithSize:CGSizeMake(13, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:KGFontFZ(13)} context:nil].size.height)];
            tmp.text = arr[i];
            tmp.numberOfLines = 0;
            tmp.textColor = KGBlackColor;
            tmp.font = KGFontFZ(13);
            tmp.textAlignment = NSTextAlignmentLeft;
            [self.labView addSubview:tmp];
        }
    }
}
/** 创建Imageview */
- (void)setPhotosArr:(NSArray *)photosArr{
    _photosArr = photosArr;
    if (photosArr.count > 0) {
        self.scrollImage.contentSize = CGSizeMake((KGScreenWidth - 140)*photosArr.count, (KGScreenWidth - 140)/5*7);
        for (int i = 0; i < photosArr.count; i++) {
            KGImageView *image = [[KGImageView alloc]initWithFrame:CGRectMake((KGScreenWidth - 140)*i, 0, (KGScreenWidth - 140), (KGScreenWidth - 140)/5*7)];
            image.image = photosArr[i];
            image.deleteBtu.hidden = YES;
            image.contentMode = UIViewContentModeScaleAspectFill;
            image.layer.cornerRadius = 5;
            image.layer.masksToBounds = YES;
            [self.scrollImage addSubview:image];
        }
    }
}
/** 显示模式 */
- (void)setIsCenter:(BOOL)isCenter{
    _isCenter = isCenter;
    for (id obj in self.labView.subviews) {
        if ([obj isKindOfClass:[UILabel class]]) {
            UILabel *tmp = obj;
            [tmp removeFromSuperview];
        }
    }
    if (isCenter == NO) {
        [self setLabelWithArr:self.titleArr];
    }else{
        [self setLabWithArr:self.titleArr];
    }
}
/** 居中文本 */
- (void)setLabWithArr:(NSArray *)arr{
    if (arr.count > 0) {
        for (int i = 0; i < arr.count; i++) {
            UILabel *tmp = [[UILabel alloc]initWithFrame:CGRectMake(self.labView.bounds.size.width - 28 - 23*i,0, 13,[arr[i] boundingRectWithSize:CGSizeMake(13, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:KGFontFZ(13)} context:nil].size.height)];
            tmp.center = CGPointMake(self.labView.bounds.size.width - 28 - 23*i + 7, self.labView.center.y);
            tmp.text = arr[i];
            tmp.numberOfLines = 0;
            tmp.textColor = KGBlackColor;
            tmp.font = KGFontFZ(13);
            tmp.textAlignment = NSTextAlignmentRight;
            [self.labView addSubview:tmp];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

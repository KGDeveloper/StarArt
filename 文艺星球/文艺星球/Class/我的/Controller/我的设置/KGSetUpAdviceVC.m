//
//  KGSetUpAdviceVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/25.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGSetUpAdviceVC.h"

@interface KGSetUpAdviceVC ()<YYTextViewDelegate>
/** 描述 */
@property (nonatomic,strong) YYTextView *ideaView;
/** 字数统计 */
@property (nonatomic,strong) YYLabel *countLab;
/** 提交按钮 */
@property (nonatomic,strong) UIButton *submitBtu;
/** 选择按钮 */
@property (nonatomic,strong) UIButton *chooseBtu;
/** 照片数 */
@property (nonatomic,strong) YYLabel *photosCount;
/** 选择 */
@property (nonatomic,strong) PhotosLibraryView *photoLibary;
/** 保存照片 */
@property (nonatomic,strong) NSMutableArray *dataArr;
/** 加载图片 */
@property (nonatomic,strong) UIView *lowView;

@end

@implementation KGSetUpAdviceVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /** 导航栏标题颜色 */
    [self changeNavTitleColor:KGBlackColor font:KGFontSHRegular(15) controller:self];
    [self changeNavBackColor:KGWhiteColor controller:self];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    /** 定制左侧返回按钮 */
    [self setLeftNavItemWithFrame:CGRectZero title:nil image:[UIImage imageNamed:@"fanhui"] font:nil color:nil select:@selector(leftNavAction)];
    /** 导航栏标题 */
    self.title = @"意见反馈";
    self.view.backgroundColor = KGAreaGrayColor;
    self.dataArr = [NSMutableArray array];
    [self setUI];
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 创建ui */
- (void)setUI{
    /** 顶部标签 */
    UILabel *topLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, KGRectNavAndStatusHight, KGScreenWidth - 30, 30)];
    topLabel.text = @"请输入详细问题或者意见";
    topLabel.textColor = KGBlackColor;
    topLabel.font = KGFontSHRegular(12);
    [self.view addSubview:topLabel];
    /** 描述view */
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0,KGRectNavAndStatusHight + 30, KGScreenWidth, 130)];
    topView.backgroundColor = KGWhiteColor;
    [self.view addSubview:topView];
    /** 描述 */
    self.ideaView = [[YYTextView alloc]initWithFrame:CGRectMake(15, 15, KGScreenWidth - 30, 80)];
    self.ideaView.placeholderText = @"请输入不少于10个字的描述。";
    self.ideaView.placeholderFont = KGFontSHRegular(13);
    self.ideaView.placeholderTextColor = KGGrayColor;
    self.ideaView.textColor = KGBlackColor;
    self.ideaView.font = KGFontSHRegular(13);
    self.ideaView.delegate = self;
    [topView addSubview:self.ideaView];
    /** 字数统计 */
    self.countLab = [[YYLabel alloc]initWithFrame:CGRectMake(15, 95, KGScreenWidth - 30, 35)];
    self.countLab.attributedText = [self attributedStringWithString:@"0/200" changeString:@"0"];
    [topView addSubview:self.countLab];
    /** 底部标签 */
    UILabel *lowLabel = [[UILabel alloc]initWithFrame:CGRectMake(15,KGRectNavAndStatusHight + 160, KGScreenWidth - 30, 30)];
    lowLabel.text = @"请提供问题相关截图或者照片";
    lowLabel.textColor = KGBlackColor;
    lowLabel.font = KGFontSHRegular(12);
    [self.view addSubview:lowLabel];
    /** 照片view */
    self.lowView = [[UIView alloc]initWithFrame:CGRectMake(0,KGRectNavAndStatusHight + 190, KGScreenWidth, 95)];
    self.lowView.backgroundColor = KGWhiteColor;
    [self.view addSubview:self.lowView];
    /** 照片统计 */
    self.photosCount = [[YYLabel alloc]initWithFrame:CGRectMake(15, 60, KGScreenWidth - 30, 35)];
    self.photosCount.attributedText = [self attributedStringWithString:@"0/3" changeString:@"0"];
    [self.lowView addSubview:self.photosCount];
    /** 选择按钮 */
    self.chooseBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.chooseBtu.frame = CGRectMake(15, 10, 75, 75);
    [self.chooseBtu setImage:[UIImage imageNamed:@"tigongwenti"] forState:UIControlStateNormal];
    [self.chooseBtu addTarget:self action:@selector(chooseAction) forControlEvents:UIControlEventTouchUpInside];
    self.chooseBtu.layer.cornerRadius = 5;
    self.chooseBtu.layer.masksToBounds = YES;
    [self.lowView addSubview:self.chooseBtu];
    /** 提交按钮 */
    self.submitBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.submitBtu.frame = CGRectMake(15,KGRectNavAndStatusHight + 315, KGScreenWidth - 30, 40);
    self.submitBtu.backgroundColor = KGGrayColor;
    [self.submitBtu setTitle:@"提交" forState:UIControlStateNormal];
    [self.submitBtu setTitleColor:KGWhiteColor forState:UIControlStateNormal];
    self.submitBtu.titleLabel.font = KGFontSHRegular(16);
    self.submitBtu.userInteractionEnabled = NO;
    self.submitBtu.layer.cornerRadius = 5;
    self.submitBtu.layer.masksToBounds = YES;
    [self.submitBtu addTarget:self action:@selector(submitIdeaAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.submitBtu];
}
/** 点击选择相片 */
- (void)chooseAction{
    self.photoLibary.hidden = NO;
}
/** 提交按钮点击事件 */
- (void)submitIdeaAction{
    
}
/** 富文本修改样式 */
- (NSMutableAttributedString *)attributedStringWithString:(NSString *)string changeString:(NSString *)changeString{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:string];
    attributedString.font = KGFontSHRegular(11);
    attributedString.alignment = NSTextAlignmentRight;
    attributedString.color = KGGrayColor;
    [attributedString setColor:KGBlackColor range:[string rangeOfString:changeString]];
    return attributedString;
}
/** YYTextViewDelegate */
- (void)textViewDidChange:(YYTextView *)textView{
    self.countLab.attributedText = [self attributedStringWithString:[NSString stringWithFormat:@"%lu/200",(unsigned long)textView.text.length] changeString:[NSString stringWithFormat:@"%lu",(unsigned long)textView.text.length]];
}
/** 当字数超出显示。不能返回 */
- (BOOL)textViewShouldEndEditing:(YYTextView *)textView{
    if (self.dataArr.count > 0 && self.ideaView.text.length > 10) {
        self.submitBtu.userInteractionEnabled = YES;
        self.submitBtu.backgroundColor = KGBlueColor;
    }else{
        self.submitBtu.userInteractionEnabled = NO;
        self.submitBtu.backgroundColor = KGGrayColor;
    }
    return (textView.text.length > 200) ? NO:YES;
}
/** 监听键盘弹出 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.ideaView resignFirstResponder];
}
/** 选择照片 */
- (PhotosLibraryView *)photoLibary{
    if (!_photoLibary) {
        _photoLibary = [[PhotosLibraryView alloc]initWithFrame:CGRectMake(0,0, KGScreenWidth, KGScreenHeight)];
        _photoLibary.maxCount = 3 - self.dataArr.count;
        __weak typeof(self) weakSelf = self;
        _photoLibary.chooseImageFromPhotoLibary = ^(NSArray<UIImage *> *imageArr) {
            [weakSelf.dataArr addObjectsFromArray:imageArr];
            [weakSelf createImageView];
        };
        [self.navigationController.view insertSubview:_photoLibary atIndex:99];
    }
    return _photoLibary;
}
/** 显示照片 */
- (void)createImageView{
    if (self.dataArr.count < 3) {
        if (self.dataArr.count == 1) {
            [self imageViewWithImage:[self.dataArr firstObject] frame:CGRectMake(15, 10, 75, 75)];
            self.chooseBtu.frame = CGRectMake(105, 10, 75, 75);
        }else if (self.dataArr.count == 2){
            [self imageViewWithImage:[self.dataArr firstObject] frame:CGRectMake(15, 10, 75, 75)];
            [self imageViewWithImage:[self.dataArr lastObject] frame:CGRectMake(105, 10, 75, 75)];
            self.chooseBtu.frame = CGRectMake(195, 10, 75, 75);
        }
    }else{
        [self imageViewWithImage:self.dataArr[0] frame:CGRectMake(15, 10, 75, 75)];
        [self imageViewWithImage:self.dataArr[1] frame:CGRectMake(105, 10, 75, 75)];
        [self imageViewWithImage:self.dataArr[2] frame:CGRectMake(195, 10, 75, 75)];
        self.chooseBtu.hidden = YES;
    }
    if (self.dataArr.count > 0 && self.ideaView.text.length > 10) {
        self.submitBtu.userInteractionEnabled = YES;
        self.submitBtu.backgroundColor = KGBlueColor;
    }else{
        self.submitBtu.userInteractionEnabled = NO;
        self.submitBtu.backgroundColor = KGGrayColor;
    }
}

/** 根据图片创建imageview */
- (UIImageView *)imageViewWithImage:(UIImage *)image frame:(CGRect)frame{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
    imageView.image = image;
    imageView.layer.cornerRadius = 5;
    imageView.layer.masksToBounds = YES;
    [self.lowView addSubview:imageView];
    return imageView;
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

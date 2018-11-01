//
//  KGEditPhotoView.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/12.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGEditPhotoView.h"

@interface KGEditPhotoView ()<UIScrollViewDelegate>
/** 加载UIImageView */
@property (nonatomic,strong) UIScrollView *rootView;
/** 展示原始图片以及裁剪后的图片 */
@property (nonatomic,strong) UIImageView *showImageView;
/** 裁剪图片类型 */
@property (nonatomic,assign) ClipUIImageWithType clipType;
/** 裁剪框 */
@property (nonatomic,strong) UIView *overLayView;
/** 取消按钮 */
@property (nonatomic,strong) UIButton *closeBtu;
/** 确认按钮 */
@property (nonatomic,strong) UIButton *shureBtu;
/** 裁剪区域面积 */
@property (nonatomic,assign) CGRect clipFrame;

@end

@implementation KGEditPhotoView

- (instancetype)initWithFrame:(CGRect)frame cilpType:(ClipUIImageWithType)clipType{
    if (self = [super initWithFrame:frame]) {
        /** 设置图片裁剪类型 */
        self.clipType = clipType;
        /** 创建底部加载图片的滚动视图，先不设置显示区域大小，因为不确定图片的大小 */
        self.rootView = [[UIScrollView alloc]initWithFrame:self.bounds];
        /** 设置滚动视图的中心始终保持和View一致 */
        self.rootView.center = self.center;
        /** 可以设置滚动视图的最大缩放级别和最小缩放级别 */
        self.rootView.bouncesZoom = YES;
        /** 关闭滚动视图弹性滚动 */
        self.rootView.bounces = NO;
        /** 隐藏竖直方向的滚动条 */
        self.rootView.showsVerticalScrollIndicator = NO;
        /** 隐藏水平方向的滚动条 */
        self.rootView.showsHorizontalScrollIndicator = NO;
        /** 设置最大缩放级别 */
        self.rootView.maximumZoomScale = MAX_CANON;
        /** 设置滚动视图代理 */
        self.rootView.delegate = self;
        /** 添加到父视图中 */
        [self addSubview:self.rootView];
        
        /** 设置显示图片视图 */
        self.showImageView = [[UIImageView alloc]init];
        /** 添加拖拽收拾 */
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
        /** 添加到UIImageView上 */
        [self.showImageView addGestureRecognizer:pan];
        /** 添加视图到父视图中 */
        [self.rootView addSubview:self.showImageView];
        
        /** 创建裁剪框蒙版 */
        self.overLayView = [[UIView alloc]initWithFrame:self.bounds];
        /** 设置蒙版颜色 */
        self.overLayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        /** 添加到视图 */
        [self addSubview:self.overLayView];
        
        /** 创建取消按钮 */
        self.closeBtu = [UIButton buttonWithType:UIButtonTypeCustom];
        self.closeBtu.frame = CGRectMake((KGViewWidth(self) - 300)/2, KGViewHeight(self) - 200, 100, 100);
        [self.closeBtu setImage:[UIImage imageNamed:@"错号"] forState:UIControlStateNormal];
        [self.closeBtu addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
        self.closeBtu.backgroundColor = [UIColor whiteColor];
        self.closeBtu.layer.cornerRadius = 50;
        self.closeBtu.layer.masksToBounds = YES;
        [self addSubview:self.closeBtu];
        
        /** 创建确认按钮 */
        self.shureBtu = [UIButton buttonWithType:UIButtonTypeCustom];
        self.shureBtu.frame = CGRectMake(KGViewWidth(self) - (KGViewWidth(self) - 300)/2 - 100, KGViewHeight(self) - 200, 100, 100);
        [self.shureBtu setImage:[UIImage imageNamed:@"对号"] forState:UIControlStateNormal];
        [self.shureBtu addTarget:self action:@selector(shureAction:) forControlEvents:UIControlEventTouchUpInside];
        self.shureBtu.backgroundColor = [UIColor whiteColor];
        self.shureBtu.layer.cornerRadius = 50;
        self.shureBtu.layer.masksToBounds = YES;
        [self addSubview:self.shureBtu];
        
        switch (clipType) {
            case ClipUIImageWithRound:/** 裁剪圆 */
                [self transparenClipRoundArea];
                break;
            case ClipUIImageWithVerticalRectangular:/** 裁剪竖直方向矩形 */
                [self transparenClipVerticalArea];
                break;
            case ClipUIImageWithHorizontalRectangular:/** 裁剪水平方向矩形 */
                [self transparenClipHorizontalArea];
                break;
            default:
                break;
        }
    }
    return self;
}
/** 取消按钮点击事件 */
- (void)closeAction:(UIButton *)sender{
    [self removeFromSuperview];
}
/** 确认按钮点击事件 */
- (void)shureAction:(UIButton *)sender{
    self.image = [self clipImageFromBigImage];
    self.showImageView.frame = CGRectMake(0, 0, self.clipFrame.size.width, self.clipFrame.size.height);
    self.rootView.contentSize = self.clipFrame.size;
    self.showImageView.center = self.center;
    self.showImageView.image = self.image;
}
/** 实现UIImageView拖拽手势方法 */
- (void)pan:(UIPanGestureRecognizer *)pan{
    /** 获取到拖拽距离 */
    CGPoint point = [pan translationInView:self.rootView];
    /** 因为拖拽起来是累加的，所以要置0，防止拖拽的时候距离太大跑出视图外 */
    [pan setTranslation:CGPointZero inView:self.rootView];
    /** 当拖拽距离过大时不进行任何操作 */
    if ([self returnResultWithPointIsInViewWithFrame:CGRectMake(self.showImageView.frame.origin.x + point.x, self.showImageView.frame.origin.y + point.y, self.showImageView.frame.size.width, self.showImageView.frame.size.height)] == YES) {
        /** 根据拖拽距离适当修改UIImageView的位置 */
        self.showImageView.frame = CGRectMake(self.showImageView.frame.origin.x + point.x, self.showImageView.frame.origin.y + point.y, self.showImageView.frame.size.width, self.showImageView.frame.size.height);
    }
}
// MARK: --计算UIImageView大小以及ScrollView大小--
- (void)setImage:(UIImage *)image{
    _image = image;
    /** 计算宽度最小缩放级别 */
    CGFloat widthScale = self.clipFrame.size.width/image.size.width;
    /** 计算高度最小缩放级别 */
    CGFloat heightScale = self.clipFrame.size.height/image.size.height;
    /** 为了比较大小，转化为number类型 */
    NSNumber *widthNmb = [NSNumber numberWithFloat:widthScale];
    NSNumber *heightNmb = [NSNumber numberWithFloat:heightScale];
    if ([widthNmb compare:heightNmb] == kCFCompareGreaterThan) {
        /** 设置最小缩放级别 */
        self.rootView.minimumZoomScale = widthScale;
    }else{
        /** 设置最小缩放级别 */
        self.rootView.minimumZoomScale = heightScale;
    }
    /** 设置显示图片视图的大小，根据图片的大小变化 */
    self.showImageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    /** 设置图片内容 */
    self.showImageView.image = image;
    /** 设置滚动视图的滚动范围 */
    self.rootView.contentSize = CGSizeMake(image.size.width, image.size.height);
}
// MARK: --UIScrollViewDelegate--
- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    /** 根据缩放级别，实时修改加载图片的视图的大小 */
    self.showImageView.frame = CGRectMake(KGViewX(self.showImageView), KGViewY(self.showImageView), KGViewWidth(self.showImageView)*scrollView.zoomScale, KGViewHeight(self.showImageView)*scrollView.zoomScale);
    /** 及时调整加载图片的视图的中心点 */
    self.showImageView.center = self.center;
}
// MARK: --滚动视图开始缩放调用，返回缩放对象，在这里我们要修改UIImageView的大小来影响UIImage的大小，所以返回UIImageView--
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.showImageView;
}
// MARK: --设置圆形裁剪区域--
- (void)transparenClipRoundArea{
    /** 创建半透明模板路径 */
    UIBezierPath *alphaPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, KGViewWidth(self), KGViewHeight(self))];
    /** 半透明模板路径裁剪出空白框 */
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake((KGViewWidth(self) - 230)/2, KGViewHeight(self)/2 - 115, 230, 230)];
    /** 添加空白框路径 */
    [alphaPath appendPath:clipPath];
    /** 创建图层 */
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    /** 给图层设置路径 */
    shapeLayer.path = alphaPath.CGPath;
    /** 根据非交集，裁剪出蒙版区域 */
    shapeLayer.fillRule = kCAFillRuleEvenOdd;
    /** 添加到蒙版上 */
    self.overLayView.layer.mask = shapeLayer;
    
    /** 创建裁剪路径 */
    UIBezierPath *cropPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake((KGViewWidth(self) - 230)/2 - 1, KGViewHeight(self)/2 - 116, 232, 232)];
    /** 创建图层 */
    CAShapeLayer *cropLayer = [CAShapeLayer layer];
    /** 给图层设置路径 */
    cropLayer.path = cropPath.CGPath;
    /** 填充颜色 */
    cropLayer.fillColor = [UIColor whiteColor].CGColor;
    /** 路劲颜色 */
    cropLayer.strokeColor = [UIColor whiteColor].CGColor;
    /** 添加到蒙版上 */
    [self.overLayView.layer addSublayer:cropLayer];
    /** 设置裁剪区域 */
    self.clipFrame = CGRectMake((KGViewWidth(self) - 230)/2, KGViewHeight(self)/2 - 115, 230, 230);
}
// MARK: --设置竖直矩形裁剪区域--
- (void)transparenClipVerticalArea{
    /** 创建半透明模板路径 */
    UIBezierPath *alphaPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, KGViewWidth(self), KGViewHeight(self))];
    /** 半透明模板路径裁剪出空白框 */
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithRect:CGRectMake((KGViewWidth(self) - 250)/2,KGViewHeight(self)/2 - 350/2,250,350)];
    /** 添加空白框路径 */
    [alphaPath appendPath:clipPath];
    /** 创建图层 */
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    /** 给图层设置路径 */
    shapeLayer.path = alphaPath.CGPath;
    /** 根据非交集，裁剪出蒙版区域 */
    shapeLayer.fillRule = kCAFillRuleEvenOdd;
    /** 添加到蒙版上 */
    self.overLayView.layer.mask = shapeLayer;
    
    /** 创建裁剪路径 */
    UIBezierPath *cropPath = [UIBezierPath bezierPathWithRect:CGRectMake((KGViewWidth(self) - 250)/2 - 1,KGViewHeight(self)/2 - 350/2 - 1,252,352)];
    /** 创建图层 */
    CAShapeLayer *cropLayer = [CAShapeLayer layer];
    /** 给图层设置路径 */
    cropLayer.path = cropPath.CGPath;
    /** 填充颜色 */
    cropLayer.fillColor = [UIColor whiteColor].CGColor;
    /** 路劲颜色 */
    cropLayer.strokeColor = [UIColor whiteColor].CGColor;
    /** 添加到蒙版上 */
    [self.overLayView.layer addSublayer:cropLayer];
    /** 设置裁剪区域 */
    self.clipFrame = CGRectMake((KGViewWidth(self) - 250)/2,KGViewHeight(self)/2 - 350/2,250,350);
}
// MARK: --设置水平矩形裁剪区域--
- (void)transparenClipHorizontalArea{
    /** 创建半透明模板路径 */
    UIBezierPath *alphaPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, KGViewWidth(self), KGViewHeight(self))];
    /** 半透明模板路径裁剪出空白框 */
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithRect:CGRectMake((KGViewWidth(self) - 345)/2, KGViewHeight(self)/2 - 230/2, 345, 230)];
    /** 添加空白框路径 */
    [alphaPath appendPath:clipPath];
    /** 创建图层 */
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    /** 给图层设置路径 */
    shapeLayer.path = alphaPath.CGPath;
    /** 根据非交集，裁剪出蒙版区域 */
    shapeLayer.fillRule = kCAFillRuleEvenOdd;
    /** 添加到蒙版上 */
    self.overLayView.layer.mask = shapeLayer;
    
    /** 创建裁剪路径 */
    UIBezierPath *cropPath = [UIBezierPath bezierPathWithRect:CGRectMake((KGViewWidth(self) - 345)/2 - 1, KGViewHeight(self)/2 - 230/2 - 1, 347, 232)];
    /** 创建图层 */
    CAShapeLayer *cropLayer = [CAShapeLayer layer];
    /** 给图层设置路径 */
    cropLayer.path = cropPath.CGPath;
    /** 填充颜色 */
    cropLayer.fillColor = [UIColor whiteColor].CGColor;
    /** 路劲颜色 */
    cropLayer.strokeColor = [UIColor whiteColor].CGColor;
    /** 添加到蒙版上 */
    [self.overLayView.layer addSublayer:cropLayer];
    /** 设置裁剪区域 */
    self.clipFrame = CGRectMake((KGViewWidth(self) - 345)/2, KGViewHeight(self)/2 - 230/2, 345, 230);
}
// MARK: --设置裁剪区域失去触控--
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitView = [super hitTest:point withEvent:event];
    if (hitView == self.overLayView) {
        /** 当缩放的图片大小边距有一个小于屏幕边距时，改变拖拽对象 */
        if (self.showImageView.frame.size.width < KGViewWidth(self) || self.showImageView.frame.size.height < KGViewHeight(self)) {
            return self.showImageView;
        }
        return self.rootView;
    }
    return hitView;
}
/** 裁剪图片 */
- (UIImage *)clipImageFromBigImage{
    /** 获取裁剪点在image上的坐标 */
    CGPoint point = [self convertPoint:self.clipFrame.origin toView:self.showImageView];
    /** 计算中心点x轴移动距离 */
    CGFloat moveWidthDistance = self.center.x - self.showImageView.center.x;
    /** 计算中心点y轴移动距离 */
    CGFloat moveHeightDistance = self.center.y - self.showImageView.center.y;
    /** 计算缩放级别 */
    CGFloat scale = self.image.size.width/self.showImageView.frame.size.width;
    NSNumber *scaleNmb = [NSNumber numberWithFloat:scale];
    NSNumber *defoultNmb = [NSNumber numberWithFloat:1.0];
    CGRect myImageRect;
    if ([scaleNmb compare:defoultNmb] == kCFCompareEqualTo) {
        myImageRect = CGRectMake(point.x, point.y, self.clipFrame.size.width, self.clipFrame.size.height);
    }else{
        myImageRect = CGRectMake(point.x - moveWidthDistance*scale, point.y + moveHeightDistance*scale, self.clipFrame.size.width*scale, self.clipFrame.size.height*scale);
    }
    CGImageRef imageRef = self.image.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, myImageRect);
    UIGraphicsBeginImageContext(self.clipFrame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, myImageRect, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    return smallImage;
}
/** 判断图片是否超出裁剪区域 */
- (BOOL)returnResultWithPointIsInViewWithFrame:(CGRect)frame{
    /** 转化坐标到滚动视图，保持和图片坐标一致 */
    CGRect imageRect = [self convertRect:frame toView:self.overLayView];
    /** 求出图片四个角坐标 */
    CGPoint leftTopPoint = imageRect.origin;
    CGPoint rightBottomPoint = CGPointMake(leftTopPoint.x + imageRect.size.width, leftTopPoint.y + imageRect.size.height);
    /** 求出裁剪框四个角坐标 */
    CGPoint imageLeftTop = self.clipFrame.origin;
    CGPoint imageRightBottom = CGPointMake(imageLeftTop.x + self.clipFrame.size.width, imageLeftTop.y + self.clipFrame.size.height);
    /** 比较是否相交 */
    if (imageLeftTop.x + 1 < leftTopPoint.x) {
        return NO;
    }else if (imageLeftTop.y - 1 < leftTopPoint.y){
        return NO;
    }else if (imageRightBottom.x + 1 > rightBottomPoint.x){
        return NO;
    }else if (imageRightBottom.y + 1 > rightBottomPoint.y){
        return NO;
    }
    return YES;
}

@end

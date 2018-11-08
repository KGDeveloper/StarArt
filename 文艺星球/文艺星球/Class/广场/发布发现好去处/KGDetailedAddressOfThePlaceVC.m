//
//  KGDetailedAddressOfThePlaceVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/8.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGDetailedAddressOfThePlaceVC.h"

@interface KGDetailedAddressOfThePlaceVC ()
/** 地图 */
@property (nonatomic,strong) MAMapView *mapView;
/** 定位 */
@property (nonatomic,strong) AMapLocationManager *manager;
/** 地址 */
@property (nonatomic,copy) NSString *address;
/** 截图 */
@property (nonatomic,copy) UIImage *resultImage;

@end

@implementation KGDetailedAddressOfThePlaceVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /** 导航栏标题颜色 */
    [self changeNavBackColor:KGWhiteColor controller:self];
    [self changeNavTitleColor:KGBlackColor font:KGFontSHBold(15) controller:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 定制左侧返回按钮 */
    [self setLeftNavItemWithFrame:CGRectZero title:nil image:[UIImage imageNamed:@"fanhui"] font:nil color:nil select:@selector(leftNavAction)];
    /** 定制右侧返回按钮 */
    [self setRightNavItemWithFrame:CGRectZero title:@"确定" image:nil font:KGFontSHRegular(14) color:KGBlueColor select:@selector(rightNavAction)];
    /** 导航栏标题 */
    self.title = @"详细地址";
    self.view.backgroundColor = KGWhiteColor;
    
    [self requestLoaction];
    [self setUpMapView];
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 导航栏右侧点击事件 */
- (void)rightNavAction{
    __block MBProgressHUD *hud = [KGHUD showMessage:@"正在获取..." toView:self.view];
    __weak typeof(self) weakSelf = self;
    [self.mapView takeSnapshotInRect:CGRectMake(15, KGScreenHeight/2 - (KGScreenWidth - 30)/690*260/2, KGScreenWidth - 30, (KGScreenWidth - 30)/690*260) withCompletionBlock:^(UIImage *resultImage, NSInteger state) {
        if (state == 1) {
            weakSelf.resultImage = resultImage;
        }
        [hud hideAnimated:YES];
        [weakSelf sendImageAndString];
    }];
}
/** 发送截图 */
- (void)sendImageAndString{
    if (self.sendDetailedAddress) {
        if (self.resultImage) {
            self.sendDetailedAddress(self.address,self.resultImage);
        }else{
            self.sendDetailedAddress(self.address,[UIImage imageNamed:@"好去处实例地图"]);
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}
/** 定位 */
- (void)requestLoaction{
    self.manager = [[AMapLocationManager alloc]init];
    [self.manager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    __weak typeof(self) weakSelf = self;
    [self.manager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error) {
            [[KGHUD showMessage:@"定位失败"] hideAnimated:YES afterDelay:1];
            return;
        }
        weakSelf.address = [NSString stringWithFormat:@"%@%@%@%@",regeocode.province,regeocode.city,regeocode.district,regeocode.street];
        weakSelf.mapView.centerCoordinate = location.coordinate;
        
    }];
}
/** 创建地图 */
- (void)setUpMapView{
    self.mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, KGRectNavAndStatusHight, KGScreenWidth, KGScreenHeight - KGRectNavAndStatusHight)];
    self.mapView.zoomEnabled = NO;
    self.mapView.rotateEnabled = NO;
    self.mapView.zoomLevel = 15;
    self.mapView.rotateCameraEnabled = NO;
    [self.view addSubview:self.mapView];
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;
    /** 自定义定位蓝点 */
    MAUserLocationRepresentation *pointStyle = [[MAUserLocationRepresentation alloc]init];
    pointStyle.showsAccuracyRing = YES;
    pointStyle.showsHeadingIndicator = YES;
    pointStyle.fillColor = [KGBlueColor colorWithAlphaComponent:0.3];
    pointStyle.strokeColor = KGBlueColor;
    pointStyle.lineWidth = 1;
    pointStyle.enablePulseAnnimation = YES;
    pointStyle.locationDotBgColor = KGWhiteColor;
    pointStyle.locationDotFillColor = KGBlueColor;
    [self.mapView updateUserLocationRepresentation:pointStyle];
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

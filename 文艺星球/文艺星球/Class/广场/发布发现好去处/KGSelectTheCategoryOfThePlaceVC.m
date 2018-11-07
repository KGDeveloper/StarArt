//
//  KGSelectTheCategoryOfThePlaceVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/7.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGSelectTheCategoryOfThePlaceVC.h"
#import "KGFoundInterestAreaCell.h"

@interface KGSelectTheCategoryOfThePlaceVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) NSMutableArray *titleArr;
@property (nonatomic,assign) NSInteger chooseRow;
@property (nonatomic,copy) NSString *imageStr;

@end

@implementation KGSelectTheCategoryOfThePlaceVC

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
    /** 定制z右侧返回按钮 */
    [self setRightNavItemWithFrame:CGRectZero title:@"确定" image:nil font:KGFontSHRegular(13) color:KGBlueColor select:@selector(rightNavAction)];
    /** 导航栏标题 */
    self.title = @"选择品类";
    self.view.backgroundColor = KGWhiteColor;
    
    self.titleArr = [NSMutableArray arrayWithArray:@[@"餐厅",@"咖啡",@"茗茶",@"糕点面包",@"酒店民宿",@"书店",@"夜蒲",@"影像音乐",@"展览艺术",@"花店",@"度假胜地",@"集成店",@"剧院"]];
    self.chooseRow = 0;
    self.imageStr = @"http://image.iartplanet.com/canting.png";
    [self setUpListView];
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 导航栏右侧点击事件 */
- (void)rightNavAction{
    if (self.sendChooseSelectString) {
        self.sendChooseSelectString(self.imageStr);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
/** 选择项 */
- (void)setUpListView{
    self.listView = [[UITableView alloc]initWithFrame:CGRectMake(0,KGRectNavAndStatusHight, KGScreenWidth, KGScreenHeight - KGRectNavAndStatusHight)];
    self.listView.delegate = self;
    self.listView.dataSource = self;
    self.listView.backgroundColor = KGWhiteColor;
    self.listView.showsVerticalScrollIndicator = NO;
    self.listView.showsHorizontalScrollIndicator = NO;
    self.listView.tableFooterView = [UIView new];
    self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.listView];
    [self.listView registerNib:[UINib nibWithNibName:@"KGFoundInterestAreaCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGFoundInterestAreaCell"];
}
// MARK: --UITableViewDelegate--
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
// MARK :--UITableViewDataSource--
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 13;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KGFoundInterestAreaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGFoundInterestAreaCell" forIndexPath:indexPath];
    cell.titleLab.text = self.titleArr[indexPath.row];
    if (indexPath.row == self.chooseRow) {
        cell.chooseBtu.hidden = NO;
        cell.titleLab.textColor = KGBlueColor;
    }else{
        cell.chooseBtu.hidden = YES;
        cell.titleLab.textColor = KGGrayColor;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.chooseRow = indexPath.row;
    [self.listView reloadData];
    if (indexPath.row == 0) {
        self.imageStr = @"http://image.iartplanet.com/canting.png";
    }else if (indexPath.row == 1){
        self.imageStr = @"http://image.iartplanet.com/kafei.png";
    }else if (indexPath.row == 2){
        self.imageStr = @"http://image.iartplanet.com/mingcha.png";
    }else if (indexPath.row == 3){
        self.imageStr = @"http://image.iartplanet.com/gaodianmianbao.png";
    }else if (indexPath.row == 4){
        self.imageStr = @"http://image.iartplanet.com/jiudianmingsu.png";
    }else if (indexPath.row == 5){
        self.imageStr = @"http://image.iartplanet.com/shudian.png";
    }else if (indexPath.row == 6){
        self.imageStr = @"http://image.iartplanet.com/yepu.png";
    }else if (indexPath.row == 7){
        self.imageStr = @"http://image.iartplanet.com/yingxiangyinyue.png";
    }else if (indexPath.row == 8){
        self.imageStr = @"http://image.iartplanet.com/zhanlanyishu.png";
    }else if (indexPath.row == 9){
        self.imageStr = @"http://image.iartplanet.com/huadian.png";
    }else if (indexPath.row == 10){
        self.imageStr = @"http://image.iartplanet.com/dujiashengdi.png";
    }else if (indexPath.row == 11){
        self.imageStr = @"http://image.iartplanet.com/jichengdian.png";
    }else if (indexPath.row == 12){
        self.imageStr = @"http://image.iartplanet.com/13.png";
    }
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

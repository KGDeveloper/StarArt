//
//  KGContellionVC.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/10/31.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGContellionVC.h"
#import "KGCollectionInstituteCell.h"
#import "KGExhibitionCell.h"
#import "KGSqureCell.h"
#import "KGArticleCell.h"
#import "KGArticleInterviewCell.h"
#import "KGBookCell.h"

@interface KGContellionVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
/** 收藏列表 */
@property (nonatomic,strong) UITableView *listView;
/** 顶部滚动线条 */
@property (nonatomic,strong) UIView *line;
/** 是否开启编辑模式 */
@property (nonatomic,assign) BOOL isEdit;
/** 编辑view */
@property (nonatomic,strong) UIView *editView;
/** 目前状态 */
@property (nonatomic,copy) NSString *styleName;
/** 数据 */
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger type;

@end

@implementation KGContellionVC

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
    /** 定制z右侧返回按钮 */
    [self setRightNavItemWithFrame:CGRectZero title:@"编辑" image:nil font:KGFontSHRegular(13) color:KGBlackColor select:@selector(rightNavAction)];
    /** 导航栏标题 */
    self.title = @"收藏";
    self.view.backgroundColor = KGWhiteColor;
    
    /** 设置初始编辑模式为NO */
    self.isEdit = NO;
    /** 默认进入显示机构收藏 */
    self.styleName = @"机构";
    self.page = 1;
    self.dataArr = [NSMutableArray array];
    
    [self requestDataWithType:0];
    [self setTopView];
    [self setUpListView];
}
/** 请求数据 */
- (void)requestDataWithType:(NSInteger)type{
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak typeof(self) weakSelf = self;
    [KGRequest postWithUrl:[NSString stringWithFormat:@"%@/%ld",CollectionList,(long)type] parameters:@{@"pageIndex":@"1",@"pageSize":@"20"} succ:^(id  _Nonnull result) {
        if ([result[@"status"] integerValue] == 200) {
            NSDictionary *dic = result[@"data"];
            NSArray *tmp = dic[@"list"];
            if (tmp.count > 0) {
                [weakSelf.dataArr addObjectsFromArray:tmp];
            }
        }
        [weakSelf.listView.mj_header endRefreshing];
        [weakSelf.listView.mj_footer endRefreshing];
        [weakSelf.listView reloadData];
        [hud hideAnimated:YES];
    } fail:^(NSError * _Nonnull error) {
        [weakSelf.listView.mj_header endRefreshing];
        [weakSelf.listView.mj_footer endRefreshing];
        [weakSelf.listView reloadData];
        [hud hideAnimated:YES];
    }];
}
/** 导航栏左侧点击事件 */
- (void)leftNavAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 导航栏右侧点击事件 */
- (void)rightNavAction{
    if (self.isEdit == YES) {
        self.isEdit = NO;
        self.editView.hidden = YES;
    }else{
        self.editView.hidden = NO;
        self.isEdit = YES;
    }
    [self.listView reloadData];
}
/** 顶部滚动按钮 */
- (void)setTopView{
    NSArray *titleArr = @[@"机构",@"展览",@"广场",@"文章",@"图书"];
    for (int i = 0; i < 5; i++) {
        UIButton *touchBtu = [UIButton buttonWithType:UIButtonTypeCustom];
        touchBtu.frame = CGRectMake(KGScreenWidth/5*i, KGRectNavAndStatusHight, KGScreenWidth/5, 50);
        [touchBtu setTitle:titleArr[i] forState:UIControlStateNormal];
        touchBtu.titleLabel.font = KGFontSHRegular(14);
        [touchBtu setTitleColor:KGGrayColor forState:UIControlStateNormal];
        if (i == 0) {
            [touchBtu setTitleColor:KGBlueColor forState:UIControlStateNormal];
        }
        [touchBtu addTarget:self action:@selector(touchAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:touchBtu];
    }
    self.line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 2)];
    self.line.backgroundColor = KGBlueColor;
    self.line.center = CGPointMake(KGScreenWidth/10,KGRectNavAndStatusHight + 49);
    [self.view addSubview:self.line];
    
}
/** 顶部按钮点击事件 */
- (void)touchAction:(UIButton *)sender{
    [UIView animateWithDuration:0.2 animations:^{
        self.line.center = CGPointMake(sender.center.x, self.line.center.y);
    }];
    for (id tmp in self.view.subviews) {
        if ([tmp isKindOfClass:[UIButton class]]) {
            [tmp setTitleColor:KGGrayColor forState:UIControlStateNormal];
        }
    }
    [sender setTitleColor:KGBlueColor forState:UIControlStateNormal];
    self.styleName = sender.currentTitle;
    self.dataArr = [NSMutableArray array];
    if ([sender.currentTitle isEqualToString:@"机构"]) {
        [self requestDataWithType:0];
        self.type = 0;
    }
    if ([sender.currentTitle isEqualToString:@"展览"]) {
        [self requestDataWithType:1];
        self.type = 1;
    }
    if ([sender.currentTitle isEqualToString:@"广场"]) {
        [self requestDataWithType:2];
        self.type = 2;
    }
    if ([sender.currentTitle isEqualToString:@"文章"]) {
        [self requestDataWithType:3];
        self.type = 3;
    }
    if ([sender.currentTitle isEqualToString:@"图书"]) {
        [self requestDataWithType:4];
        self.type = 4;
    }
    [self.listView reloadData];
}
/** 收藏列表 */
- (void)setUpListView{
    self.listView = [[UITableView alloc]initWithFrame:CGRectMake(0, KGRectNavAndStatusHight + 50, KGScreenWidth, KGScreenHeight - KGRectNavAndStatusHight - 50)];
    self.listView.delegate = self;
    self.listView.dataSource = self;
    self.listView.emptyDataSetSource = self;
    self.listView.emptyDataSetDelegate = self;
    self.listView.showsVerticalScrollIndicator = NO;
    self.listView.showsHorizontalScrollIndicator = NO;
    self.listView.tableFooterView = [UIView new];
    self.listView.separatorStyle = UITableViewCellSelectionStyleNone;
    __weak typeof(self) weakSelf = self;
    self.listView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        weakSelf.dataArr = [NSMutableArray array];
        [weakSelf requestDataWithType:weakSelf.type];
        [weakSelf.listView.mj_header beginRefreshing];
    }];
    self.listView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        weakSelf.page++;
        [weakSelf requestDataWithType:weakSelf.type];
        [weakSelf.listView.mj_footer beginRefreshing];
    }];
    [self.view addSubview:self.listView];
    /** 绑定cell */
    [self.listView registerNib:[UINib nibWithNibName:@"KGCollectionInstituteCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGCollectionInstituteCell"];
    [self.listView registerNib:[UINib nibWithNibName:@"KGExhibitionCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGExhibitionCell"];
    [self.listView registerNib:[UINib nibWithNibName:@"KGSqureCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGSqureCell"];
    [self.listView registerNib:[UINib nibWithNibName:@"KGArticleCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGArticleCell"];
    [self.listView registerNib:[UINib nibWithNibName:@"KGArticleInterviewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGArticleInterviewCell"];
    [self.listView registerNib:[UINib nibWithNibName:@"KGBookCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGBookCell"];
}
/** UITableViewDataSource */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.styleName isEqualToString:@"机构"]) {
        return 137;
    }else if ([self.styleName isEqualToString:@"广场"]){
        return 175;
    }else if ([self.styleName isEqualToString:@"文章"]){
        return 160;
    }else if ([self.styleName isEqualToString:@"图书"]){
        return 190;
    }else{
        return 310;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.styleName isEqualToString:@"机构"]) {
        KGCollectionInstituteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGCollectionInstituteCell"];
        if (self.isEdit == YES) {
            [cell starEdit];
        }else{
            [cell endEdit];
        }
//        if (self.dataArr.count > 0) {
//            NSDictionary *dic = self.dataArr[indexPath.row];
//            [cell.cusTomImage sd_setImageWithURL:[NSURL URLWithString:dic[@"merchantImage"]]];
//            cell.introductionLab.text = dic[@"merchantDetails"];
//            cell.nameLab.text = dic[@"merchantName"];
//            cell.addressLab.text = dic[@"merchantLocation"];
////            cell.distanceLab.text = dic
//            cell.scoreLab.text = [NSString stringWithFormat:@"%@",dic[@"merchantGrade"]];
//            if ([dic[@"merchantGrade"] integerValue] == 5) {
//
//            }
//            [cell changeStarWithScroe:[dic[@"merchantGrade"] integerValue]];
//        }
        return cell;
    }else if ([self.styleName isEqualToString:@"广场"]){
        KGSqureCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGSqureCell"];
        if (self.isEdit == YES) {
            [cell starEdit];
        }else{
            [cell endEdit];
        }
        return cell;
    }else if ([self.styleName isEqualToString:@"文章"]){
        if (indexPath.row%2 == 0) {
            KGArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGArticleCell"];
            if (self.isEdit == YES) {
                [cell starEdit];
            }else{
                [cell endEdit];
            }
            if (self.dataArr.count > 0) {
                NSDictionary *dic = self.dataArr[indexPath.row];
                [cell.customImage sd_setImageWithURL:[NSURL URLWithString:[[dic[@"newsCover"] componentsSeparatedByString:@"#"] firstObject]]];
                cell.titleLab.text = dic[@"newsTitle"];
                cell.detailLab.text = dic[@"newsSource"];
            }
            return cell;
        }else{
            KGArticleInterviewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGArticleInterviewCell"];
            if (self.isEdit == YES) {
                [cell starEdit];
            }else{
                [cell endEdit];
            }
            return cell;
        }
    }else if ([self.styleName isEqualToString:@"图书"]){
        KGBookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGBookCell"];
        if (self.isEdit == YES) {
            [cell starEdit];
        }else{
            [cell endEdit];
        }
        if (self.dataArr.count > 0) {
            NSDictionary *dic = self.dataArr[indexPath.row];
            [cell.customImage sd_setImageWithURL:[NSURL URLWithString:[[dic[@"bookCover"] componentsSeparatedByString:@"#"] firstObject]]];
            cell.titleLab.text = dic[@"bookName"];
            cell.scoreLab.text = [NSString stringWithFormat:@"%@",dic[@"bookScore"]];
            cell.detailLab.text = [NSString stringWithFormat:@"%@\n%@",dic[@"bookPress"],dic[@"bookIntroduction"]];
            cell.detailHeight.constant = 60;
            [cell changeStarWithScroe:[dic[@"bookScore"] integerValue]];
        }
        return cell;
    }else{
        KGExhibitionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGExhibitionCell"];
        if (self.isEdit == YES) {
            [cell starEdit];
        }else{
            [cell endEdit];
        }
        if (self.dataArr.count > 0) {
            NSDictionary *dic = self.dataArr[indexPath.row];
            [cell.customImage sd_setImageWithURL:[NSURL URLWithString:[[dic[@"exhibitionCover"] componentsSeparatedByString:@"#"] firstObject]]];
            cell.nameLab.text = dic[@"exhibitionTitle"];
            cell.adressLab.text = dic[@"exhibitionAddres"];
        }
        return cell;
    }
    
}
/** UITableViewDelegate */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
/** DZNEmptyDataSetSource */
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"kongyemian"];
}
/** 底部编辑view */
- (UIView *)editView{
    if (!_editView) {
        _editView = [[UIView alloc]initWithFrame:CGRectMake(0, KGScreenHeight - 50, KGScreenWidth, 50)];
        _editView.backgroundColor = KGWhiteColor;
        [self.view insertSubview:_editView atIndex:99];
        /** 顶部横线 */
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, 1)];
        line.backgroundColor = KGLineColor;
        [_editView addSubview:line];
        /** 全选按钮 */
        UIButton *allChooseBtu = [UIButton buttonWithType:UIButtonTypeCustom];
        allChooseBtu.frame = CGRectMake(0, 0, 130, 50);
        [allChooseBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
        [allChooseBtu setTitle:@"全选" forState:UIControlStateNormal];
        [allChooseBtu setImage:[UIImage imageNamed:@"weixuanzhong"] forState:UIControlStateNormal];
        allChooseBtu.titleEdgeInsets = UIEdgeInsetsMake(0, allChooseBtu.imageView.bounds.size.width + 15, 0, 0);
        allChooseBtu.titleLabel.font = KGFontSHRegular(16);
        [allChooseBtu addTarget:self action:@selector(allChooseAction:) forControlEvents:UIControlEventTouchUpInside];
        [_editView addSubview:allChooseBtu];
        /** 删除按钮 */
        UIButton *deleteBtu = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteBtu.frame = CGRectMake(130, 0, 130, 50);
        [deleteBtu setTitleColor:[UIColor colorWithHexString:@"#ff6666"] forState:UIControlStateNormal];
        [deleteBtu setTitle:@"删除" forState:UIControlStateNormal];
        deleteBtu.titleLabel.font = KGFontSHRegular(16);
        [deleteBtu addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
        [_editView addSubview:deleteBtu];
        /** 中间风格县 */
        UIView *hLine = [[UIView alloc]initWithFrame:CGRectMake(130, 12.5, 1, 25)];
        hLine.backgroundColor = KGLineColor;
        [_editView addSubview:hLine];
        
    }
    return _editView;
}
/** 全选点击事件 */
- (void)allChooseAction:(UIButton *)sender{
    if ([sender.currentImage isEqual:[UIImage imageNamed:@"weixuanzhong"]]) {
        [sender setImage:[UIImage imageNamed:@"fuhao"] forState:UIControlStateNormal];
    }else{
        [sender setImage:[UIImage imageNamed:@"weixuanzhong"] forState:UIControlStateNormal];
    }
}
/** 删除点击事件 */
- (void)deleteAction:(UIButton *)sender{
    
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

//
//  KGArtisticPeopleDetailArtisticView.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/11/21.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGArtisticPeopleDetailArtisticView.h"
#import "KGArtisticPeopleDetailTheEndCell.h"
#import "KGArtisticPeopleDetailArtisticViewCell.h"

@interface KGArtisticPeopleDetailArtisticView ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
/** 展讯 */
@property (nonatomic,strong) UITableView *listView;
/** 媒体报道 */
@property (nonatomic,strong) UIButton *willBtu;
/** 原创文章 */
@property (nonatomic,strong) UIButton *historyBtu;

@end

@implementation KGArtisticPeopleDetailArtisticView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpListView];
    }
    return self;
}
/** 文章列表 */
- (void)setUpListView{
    self.listView = [[UITableView alloc]initWithFrame:self.bounds];
    self.listView.delegate = self;
    self.listView.dataSource = self;
    self.listView.emptyDataSetSource = self;
    self.listView.emptyDataSetDelegate = self;
    self.listView.tableFooterView = [UIView new];
    self.listView.tableHeaderView = [self setUpHeaderView];
    self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.listView.showsVerticalScrollIndicator = NO;
    self.listView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.listView];
    
    [self.listView registerNib:[UINib nibWithNibName:@"KGArtisticPeopleDetailArtisticViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGArtisticPeopleDetailArtisticViewCell"];
    [self.listView registerNib:[UINib nibWithNibName:@"KGArtisticPeopleDetailTheEndCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGArtisticPeopleDetailTheEndCell"];
}
/** 头视图 */
- (UIView *)setUpHeaderView{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KGScreenWidth, 50)];
    /** 媒体报道 */
    self.willBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.willBtu.frame = CGRectMake(0, 0, KGScreenWidth/2, 50);
    [self.willBtu setTitle:@"媒体报道" forState:UIControlStateNormal];
    [self.willBtu setTitleColor:KGBlueColor forState:UIControlStateNormal];
    self.willBtu.titleLabel.font = KGFontSHRegular(14);
    [self.willBtu addTarget:self action:@selector(willAction:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:self.willBtu];
    
    UIView *centerline = [[UIView alloc]initWithFrame:CGRectMake(KGScreenWidth/2, 10, 1, 30)];
    centerline.backgroundColor = KGLineColor;
    [headerView addSubview:centerline];
    
    /** 原创文章 */
    self.historyBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.historyBtu.frame = CGRectMake(KGScreenWidth/2, 0, KGScreenWidth/2, 50);
    [self.historyBtu setTitle:@"原创文章" forState:UIControlStateNormal];
    [self.historyBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
    self.historyBtu.titleLabel.font = KGFontSHRegular(14);
    [self.historyBtu addTarget:self action:@selector(historyAction:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:self.historyBtu];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 59, KGScreenWidth, 1)];
    line.backgroundColor = KGLineColor;
    [headerView addSubview:line];
    
    return headerView;
}
/** 媒体报道 */
- (void)willAction:(UIButton *)sender{
    [sender setTitleColor:KGBlueColor forState:UIControlStateNormal];
    [self.historyBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
}
/** 原创文章 */
- (void)historyAction:(UIButton *)sender{
    [sender setTitleColor:KGBlueColor forState:UIControlStateNormal];
    [self.willBtu setTitleColor:KGBlackColor forState:UIControlStateNormal];
}
/** 空页面 */
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"kongyemian"];
}
/** 代理方法以及数据源 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3) {
        return 75;
    }else{
        return (KGScreenWidth - 30)/69*38 + 135;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3) {
        KGArtisticPeopleDetailTheEndCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGArtisticPeopleDetailTheEndCell"];
        return cell;
    }else{
        KGArtisticPeopleDetailArtisticViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGArtisticPeopleDetailArtisticViewCell"];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

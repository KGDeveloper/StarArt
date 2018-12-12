//
//  KGSelectLeftNavChooseCityView.m
//  文艺星球
//
//  Created by 文艺星球 on 2018/12/12.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGSelectLeftNavChooseCityView.h"
#import "KGAgencyHomePageScreeningCell.h"

@interface KGSelectLeftNavChooseCityView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,copy) NSArray *oneArr;
@property (nonatomic,assign) NSInteger oneListCellRow;

@end

@implementation KGSelectLeftNavChooseCityView


- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.oneArr = @[@{@"city":@"北京市",@"id":@"1"},@{@"city":@"上海市",@"id":@"13"},@{@"city":@"广州市",@"id":@"28"},@{@"city":@"深圳市",@"id":@"36"},@{@"city":@"天津市",@"id":@"43"},@{@"city":@"成都市",@"id":@"65"},@{@"city":@"西安市",@"id":@"54"}];
        self.oneListCellRow = 0;
        [self setUpUI];
    }
    return self;
}
/** 创建ui */
- (void)setUpUI{
    self.listView = [[UITableView alloc]initWithFrame:self.bounds];
    self.listView.delegate = self;
    self.listView.dataSource = self;
    self.listView.scrollEnabled = NO;
    self.listView.bounces = NO;
    self.listView.showsVerticalScrollIndicator = NO;
    self.listView.showsHorizontalScrollIndicator = NO;
    self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.listView];
    [self.listView registerNib:[UINib nibWithNibName:@"KGAgencyHomePageScreeningCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KGAgencyHomePageScreeningCell"];
}
// MARK: --UITableViewDelegate--
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
// MARK :--UITableViewDataSource--
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KGAgencyHomePageScreeningCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGAgencyHomePageScreeningCell" forIndexPath:indexPath];
    if (indexPath.row == self.oneListCellRow) {
        cell.backgroundColor = KGWhiteColor;
        cell.titleLab.textColor = KGBlackColor;
    }else{
        cell.backgroundColor = KGWhiteColor;
        cell.titleLab.textColor = KGGrayColor;
    }
    NSDictionary *dic = self.oneArr[indexPath.row];
    cell.titleLab.text = dic[@"city"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.oneListCellRow = indexPath.row;
    [self.listView reloadData];
    NSDictionary *dic = self.oneArr[indexPath.row];
    if (self.chooseResult) {
        self.chooseResult(dic[@"city"],dic[@"id"]);
    }
    self.hidden = YES;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

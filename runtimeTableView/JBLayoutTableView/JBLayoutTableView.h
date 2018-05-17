//
//  JBLayoutTableView.h
//  JieBao
//
//  Created by 君未央 on 2018/4/13.
//  Copyright © 2018年 YangJL. All rights reserved.
//

#import "JBLayoutCell.h"
#import "JBLayoutTableTools.h"

typedef enum JBLayoutTableView_CellNumState {
    
    /// 默认一级数组 section num =1  row num = arrData.count
    JBLayoutCellNumStateDefault  = 0,
    
    /// 二级数组 section num = arrData.count row num = arrData[section].count
    JBLayoutCellNumStateSecondLevel,
    
    ///  根据 sever 下发数据 section num = arrData.count row num = 1 ;
    JBLayoutCellNumStateNetLayout
    
} JBNetLayoutTableState ;


@protocol JBLayoutTableViewDelegate <NSObject>

@optional
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section ;
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section ;
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section ;
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section ;

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath ;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView ;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section ;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath ;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath ;

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView ;
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section ;
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString*)title atIndex:(NSInteger)index ;



@end



@interface JBLayoutTableView : UIView

@property (nonatomic ,strong) UITableView *tabvTool ;
@property (nonatomic ,strong) JBLayoutCell *jbLayoutCell ;
@property (nonatomic ,weak)id <JBLayoutTableViewDelegate>delegate ;

/// cell section TableSectionHeader Hight
@property (nonatomic ,assign) CGFloat fTableSectionHeaderHight ;

/// cell section TableSectionFooter Hight
@property (nonatomic ,assign) CGFloat fTableSectionFooterHight ;

/// cell hight
@property (nonatomic ,assign) CGFloat fTableCellHight ;

/// cell 返回 hight的方法名 若为空则调用cellOfHight
@property (nonatomic ,copy) NSString *strSelectorName ;

/// cell class Name
@property (nonatomic ,copy) NSString *strCellName ;

/// 赋值属性名字
@property (nonatomic ,copy) NSString *strModelName ;

@property (nonatomic ,copy) NSArray *aryCellBtnSelector ;

@property (nonatomic ,copy) void (^blockDidTableView)(NSIndexPath *indexPath) ;


- (instancetype)initJBNetLayoutFrame:(CGRect )tFrame TableViewData:(NSArray *)tArrData LayoutTableViewState:(JBNetLayoutTableState )tLayoutState;

- (instancetype)initJBNetLayoutFrame:(CGRect)tFrame TableViewData:(NSArray *)tArrData CellName:(NSString *)tCellName ModelName:(NSString *)tModelName LayoutTableViewState:(JBNetLayoutTableState)tLayoutState ;


- (void)buildTableView ;

- (void)reloadTableView:(NSArray *)arrData ;

@end


/*
 
 
 JBLayoutTableView *tabv = [[JBLayoutTableView alloc]initJBNetLayoutFrame:self.view.bounds
 TableViewData:arr
 LayoutTableViewState:JBLayoutCellNumStateDefault];
 tabv.strCellName = @"JBHomePageCell";
 tabv.strModelName = @"strText";
 tabv.strSelectorName = @"cellHight:";
 tabv.fTableSectionFooterHight = 1 ;
 tabv.fTableSectionHeaderHight = 100 ;
 tabv.delegate = self ;
 [self.view addSubview:tabv];
 [tabv buildTableView];
 
 tabv.blockDidTableView = ^(NSIndexPath *indexPath) {
 
 };
 
 [tabv.tabvTool creatrLoadMoreViewBlockLoadBegin:^{
 
 }];
 
 [tabv.tabvTool creatrPullToRefreshViewBlockRefreshBegin:^{
 
 }];
 
 
 
 */









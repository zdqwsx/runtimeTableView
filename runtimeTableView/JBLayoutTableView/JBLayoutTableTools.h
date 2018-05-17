//
//  JBNetLayoutTools.h
//  JieBao
//
//  Created by 君未央 on 2018/4/12.
//  Copyright © 2018年 YangJL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JBLayoutCell.h"


typedef enum JBNetLayoutTableTool_CellNumState {

    /// row 等于数组 count section = 1
    JBNetLayoutTableToolTableDataToRow  = 0,

    /// section 等于数组 count row = arr[i].count
    JBNetLayoutTableToolTableDataToSectionAndRow,

    /// section 等于数组 row = 1 ;
    JBNetLayoutTableToolNetDataToSection

} JBLayoutTableToolstate ;

@interface JBLayoutTableTools : NSObject

@property (nonatomic ,strong) JBLayoutCell *jbCell ;

@property (nonatomic ,copy ) NSArray *aryCellData ;

@property (nonatomic ,assign) JBLayoutTableToolstate toolState ;

/// cell hight
@property (nonatomic ,assign) CGFloat fTableCellHight ;

/// cell section TableSectionHeader Hight
@property (nonatomic ,assign) CGFloat fTableSectionHeaderHight ;

/// cell section TableSectionFooter Hight
@property (nonatomic ,assign) CGFloat fTableSectionFooterHight ;

/// cell 返回 hight的方法名 若为空则调用cellOfHight
@property (nonatomic ,copy) NSString *strSelectorName ;

/// cell class Name
@property (nonatomic ,copy) NSString *strCellName ;

/// cell赋值的名字
@property (nonatomic ,copy) NSString *strModelName ;


- (instancetype)initJBNetLayoutTools:(NSArray *) aryCellData ;

- (void)buildJBLayoutCell ;

- (void)reloadData:(NSArray *)arrData ;

 ///判断sever下发状态返回定制好的 tableviewcell
- (UITableViewCell *)jbNetLayoutToolDisposeTableViewCell:(UITableView *)tTableView IndexPath:(NSIndexPath *)tIndexPath ;

 ///根据sever提供参数 返回table的 Header段间距
- (CGFloat)jbNetLayoutTollDisposeTableViewHeightFotHeaderInSection:(NSInteger)tSection ;

 ///根据sever提供参数 返回table的 Footer段间距
- (CGFloat)jbNetLayoutToolDisposeTableViewHeightForFooterInSection:(NSInteger)tSection ;

 ///根据sever提供参数 返回cell 高度
- (CGFloat)jbNetLayoutToolDisposeTableViewHeightForRowAtIndexPath:(NSIndexPath *)tIndexPath ;

 ///根据sever提供参数 返回table section 数量
- (CGFloat)jbNetLayoutToolDisposeTableNumberOfSections ;

 /// 返回每组 section cell 数量
- (NSInteger)jbNetLayoutToolDisposeNumberOfRowsInSection:(NSInteger)tSection ;

 /// 返回SectionHeaderView
- (UIView *)jbNetLayoutToolViewForHeaderInSection ;

 /// 返回sectionFooterView
- (UIView *)jbNetLayoutToolViewForFooterInSection ;

@end

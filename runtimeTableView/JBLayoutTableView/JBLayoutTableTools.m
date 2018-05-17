//
//  JBNetLayoutTools.m
//  JieBao
//
//  Created by 君未央 on 2018/4/12.
//  Copyright © 2018年 YangJL. All rights reserved.
//

#import "JBLayoutTableTools.h"
#import "Header.h"

#import <objc/runtime.h>
#import <objc/message.h>

@interface JBLayoutTableTools ()

@property (nonatomic ,assign) NSInteger intSectionNum ;

@property (nonatomic ,assign) NSInteger intRowNum ;

@property (nonatomic ,assign) JBLayoutTableToolstate toolsState ;


@end

@implementation JBLayoutTableTools


#pragma mark 对外提供方法

-(instancetype)initJBNetLayoutTools:(NSArray *) aryCellData
{
    self = [super init];
    if (self) {
        
        _intRowNum = 0 ;
        _intSectionNum = 0 ;
        _aryCellData = [[NSArray alloc]initWithArray:aryCellData] ;
    }
    return self ;
}

-(void)setToolState:(JBLayoutTableToolstate)toolState
{
    /// 0 row 等于数组 count section = 1
    /// 1 section 等于数组 count row = arr[i].count
    /// 2 section 等于数组 row = 1 ;
    self.toolsState = toolState ;
    switch (toolState) {
        case 0:
        {
            self.intSectionNum = 1 ;
            self.intRowNum = self.aryCellData.count ;
        }
            break;
        case 1:
        {
            self.intSectionNum = self.aryCellData.count ;
            self.intRowNum = 0 ;
        }
            break;
        case 2:
        {
            self.intSectionNum = self.aryCellData.count ;
            self.intRowNum = 1 ;
        }
            break;
            
        default:
            break;
    }
}


- (void)buildJBLayoutCell
{
    self.jbCell = [[JBLayoutCell alloc]init];
    self.jbCell.aryDataCell = self.aryCellData ;
    self.jbCell.strCellName = WQXK_Str_Protect(self.strCellName);

}

- (void)reloadData:(NSArray *)arrData
{
    self.aryCellData = arrData ;
    self.jbCell.aryDataCell = self.aryCellData ;;
    [self setToolState:self.toolsState];

}

///判断sever下发状态返回定制好的 Cell
- (UITableViewCell *)jbNetLayoutToolDisposeTableViewCell:(UITableView *)tTableView IndexPath:(NSIndexPath *)tIndexPath
{

    if (WQXK_Ary_Not_Valid(self.aryCellData)) {
        return [self.jbCell tableViewAtDataSourceIsEmptyTableView:tTableView];
    }
    
    NSDictionary *dicCellData = @{};
    switch (self.toolsState) {
        case 0:
        {
            dicCellData = [self analyticalDataOfIndexPath:tIndexPath.row] ;
        }
            break;
        case 1:
        {
            NSArray *aryRowData = self.aryCellData [tIndexPath.section];
            dicCellData = aryRowData[tIndexPath.row];
        }
            break;
        case 2:
        {
            dicCellData = [self analyticalDataOfIndexPath:tIndexPath.row] ;
        }
            break;
            
        default:
            break;
    }
    
   
    if (![self dicCheckValidValues:dicCellData]) {
        NSLog(@"空数据");
        return [self.jbCell tableViewAtDataSourceIsEmptyTableView:tTableView];
    }else {

        if (WQXK_Str_Protect(self.strModelName).length > 0 && WQXK_Str_Protect(self.strCellName).length > 0) {
            
            self.jbCell.dicCellModelName = @{self.strModelName : dicCellData};
        }
                
        UITableViewCell *cell = [self.jbCell buildLayoutCell:tTableView indexPath:tIndexPath cellData:dicCellData];
            
        return cell ;
    }
}


///根据sever提供参数 返回table的 Header段间距
- (CGFloat)jbNetLayoutTollDisposeTableViewHeightFotHeaderInSection:(NSInteger)tSection
{
    return [self returnHeaderAndFooterHight:0 section:tSection] ;
}

///根据sever提供参数 返回table的 Footer段间距
- (CGFloat)jbNetLayoutToolDisposeTableViewHeightForFooterInSection:(NSInteger)tSection
{
    return [self returnHeaderAndFooterHight:1 section:tSection] ;
}

///根据sever提供参数 返回cell 高度
- (CGFloat)jbNetLayoutToolDisposeTableViewHeightForRowAtIndexPath:(NSIndexPath *)tIndexPath
{
    id dicCellData = @{};
    switch (self.toolsState) {
        case 0:
        {
            dicCellData = [self analyticalDataOfIndexPath:tIndexPath.row] ;
        }
            break;
        case 1:
        {
            NSArray *aryRowData = self.aryCellData [tIndexPath.section];
            dicCellData = aryRowData[tIndexPath.row];
        }
            break;
        case 2:
        {
            dicCellData = [self analyticalDataOfIndexPath:tIndexPath.row] ;
        }
            break;
            
        default:
            break;
    }
    return [self cellHeghtOf:dicCellData] ;
}

///根据sever提供参数 返回table section 数量
- (CGFloat)jbNetLayoutToolDisposeTableNumberOfSections
{
    return self.intSectionNum ;
}

/// 返回每组 section cell 数量
- (NSInteger)jbNetLayoutToolDisposeNumberOfRowsInSection:(NSInteger)tSection
{
    if (1 == self.toolsState) {
        NSArray *arrRow = [self.aryCellData objectAtIndex:tSection];
        if (WQXK_Ary_Is_Valid(arrRow)) {
            return arrRow.count ;
        }
        return 0 ;
    }
    return self.intRowNum ;
}

/// 返回 SectionHeaderView
- (UIView *)jbNetLayoutToolViewForHeaderInSection
{
    UIView *viewHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    viewHeader.backgroundColor = JBCOLOR_BACKGROUND_VC ;
    return viewHeader ;
}

/// 返回 sectionFooterView
- (UIView *)jbNetLayoutToolViewForFooterInSection
{
    UIView *viewFooter = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    viewFooter.backgroundColor = JBCOLOR_BACKGROUND_VC ;
    return viewFooter ;
}

#pragma mark 内部方法


/// 计算cell高度
- (CGFloat)cellHeghtOf:(id)dicData
{
    if (self.fTableCellHight) {
        return self.fTableCellHight ;
    }
    self.strSelectorName = WQXK_Str_Protect(self.strSelectorName).length > 0 ? self.strSelectorName : @"cellOfHight:";
    
    const char *className = [self.strCellName cStringUsingEncoding:NSASCIIStringEncoding];
    Class newClass = objc_getClass(className);
    if (!newClass) {
        //创建一个类
        Class superClass = [NSObject class];
        newClass = objc_allocateClassPair(superClass, className, 0);
        //注册你创建的这个类
        objc_registerClassPair(newClass);
    }
    
    SEL selector = NSSelectorFromString(self.strSelectorName);
    ///TODO fix
    CGFloat h = ((CGFloat  (*)(id,SEL,NSString *)) objc_msgSend)((id)newClass, selector ,dicData);
    return h ;
}


/// locationSection 0 header 1 footer
- (CGFloat)returnHeaderAndFooterHight:(NSInteger)locationSection
                              section:(NSInteger)tSection
{
    CGFloat hight = 0.01 ;
    if (0 == locationSection) {
       hight = self.fTableSectionHeaderHight != 0 ? self.fTableSectionHeaderHight : 0.01 ;

    }else if (1 == locationSection) {
        hight =self.fTableSectionFooterHight!= 0 ? self.fTableSectionFooterHight : 0.01 ;
    }
    
    switch (self.toolsState) {
        case 0:
        {
            return hight ;
        }
            break;
        case 1:
        {
            return hight ;
        }
            break;
        case 2:
        {
            NSDictionary *dicCellData = [self analyticalDataOfIndexPath:tSection];
            if (![self dicCheckValidValues:dicCellData]) {
                return 0.01 ;
            }
            //TODO 根据业务返回计算高度 不是0.01
            return 0.01 ;
            
        }
            break;
            
        default:
        {
            return 0.01 ;
        }
            break;
    }

}



- (NSDictionary *)analyticalDataOfIndexPath:(NSInteger )tIndx
{
    if (WQXK_Ary_Not_Valid(self.aryCellData)) {
        return nil ;
    }
    
    id dicData = [self.aryCellData objectAtIndex:tIndx];
    
    if (dicData) {
        return dicData ;
    } else {
        return nil ;
    }
}

- (BOOL)dicCheckValidValues:(id )dicData
{
    if (dicData) {
        return YES ;
    } else {
        return NO ;
    }
}





@end

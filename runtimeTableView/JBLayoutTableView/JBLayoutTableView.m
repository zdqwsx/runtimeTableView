//
//  JBLayoutTableView.m
//  JieBao
//
//  Created by 君未央 on 2018/4/13.
//  Copyright © 2018年 YangJL. All rights reserved.
//

#import "JBLayoutTableView.h"
#import "Header.h"

@interface JBLayoutTableView ()<UITableViewDelegate ,UITableViewDataSource>

@property (nonatomic ,strong) JBLayoutTableTools *jbLayoutTools ;
@property (nonatomic ,assign) JBNetLayoutTableState layoutState ;

@property (nonatomic ,copy) NSArray *arrDataCell ;

@end

@implementation JBLayoutTableView

- (instancetype)initJBNetLayoutFrame:(CGRect)tFrame
                       TableViewData:(NSArray *)tArrData
                LayoutTableViewState:(JBNetLayoutTableState )tLayoutState
{
    self = [super initWithFrame:tFrame];
    if (self) {
        
        _arrDataCell = tArrData ;
        _layoutState = tLayoutState ;
    }
    
    return self ;
    
}

- (instancetype)initJBNetLayoutFrame:(CGRect)tFrame TableViewData:(NSArray *)tArrData CellName:(NSString *)tCellName ModelName:(NSString *)tModelName LayoutTableViewState:(JBNetLayoutTableState)tLayoutState
{
    self = [super initWithFrame:tFrame];
    if (self) {
        
        _arrDataCell = tArrData ;
        _layoutState = tLayoutState ;
        
        _strCellName = tCellName ;
        _strModelName = tModelName ;
    }
    
    return self ;

}

- (void)buildTableView
{
    self.jbLayoutTools = [[JBLayoutTableTools alloc]initJBNetLayoutTools:self.arrDataCell];
   
    self.jbLayoutTools.fTableCellHight = self.fTableCellHight ;
    self.jbLayoutTools.fTableSectionFooterHight = self.fTableSectionFooterHight;
    self.jbLayoutTools.fTableSectionHeaderHight = self.fTableSectionHeaderHight ;
    self.jbLayoutTools.strCellName = WQXK_Str_Protect(self.strCellName) ;
    self.jbLayoutTools.strSelectorName = WQXK_Str_Protect(self.strSelectorName);
    self.jbLayoutTools.strModelName = WQXK_Str_Protect(self.strModelName) ;
    
    [self.jbLayoutTools buildJBLayoutCell];
    self.jbLayoutCell = self.jbLayoutTools.jbCell ;
    
    [self structureLayoutToolsTableState];
    
    self.tabvTool = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStyleGrouped];
    self.tabvTool.delegate = self ;
    self.tabvTool.dataSource = self ;
    [self addSubview:self.tabvTool];
}

- (void)reloadTableView:(NSArray *)arrData
{
    self.arrDataCell = arrData ;
    [self.jbLayoutTools reloadData:arrData];
    
    [self.tabvTool reloadData];
}


- (void)structureLayoutToolsTableState
{
    switch (self.layoutState) {
        case 0:
        {
            self.jbLayoutTools.toolState = JBNetLayoutTableToolTableDataToRow ;
        }
            break;
        case 1:
        {
             self.jbLayoutTools.toolState = JBNetLayoutTableToolTableDataToSectionAndRow ;
        }
            break;
        case 2:
        {
            self.jbLayoutTools.toolState = JBNetLayoutTableToolNetDataToSection ;
        }
            break;
            
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([self.delegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
       return [self.delegate tableView:tableView heightForHeaderInSection:section];
    }
    
    return [self.jbLayoutTools jbNetLayoutTollDisposeTableViewHeightFotHeaderInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ([self.delegate respondsToSelector:@selector(tableView:heightForFooterInSection:)]) {
        return [self.delegate tableView:tableView heightForFooterInSection:section];
    }
    return [self.jbLayoutTools jbNetLayoutToolDisposeTableViewHeightForFooterInSection:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([self.delegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        return [self.delegate tableView:tableView viewForHeaderInSection:section];
    }
    return [self.jbLayoutTools jbNetLayoutToolViewForHeaderInSection];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if ([self.delegate respondsToSelector:@selector(tableView:viewForFooterInSection:)]) {
        return [self.delegate tableView:tableView viewForFooterInSection:section];
    }
    return [self.jbLayoutTools jbNetLayoutToolViewForFooterInSection];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
        return [self.delegate tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    return [self.jbLayoutTools jbNetLayoutToolDisposeTableViewHeightForRowAtIndexPath:indexPath];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self.delegate respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        return [self.delegate numberOfSectionsInTableView:tableView];
    }
    return [self.jbLayoutTools jbNetLayoutToolDisposeTableNumberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.delegate respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
        return [self.delegate tableView:tableView numberOfRowsInSection:section];
    }
    return [self.jbLayoutTools jbNetLayoutToolDisposeNumberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)]) {
        return [self.delegate tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    return [self.jbLayoutTools jbNetLayoutToolDisposeTableViewCell:tableView IndexPath:indexPath] ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        return [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.blockDidTableView) {
        self.blockDidTableView(indexPath);
    }
}


-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if ([self.delegate respondsToSelector:@selector(sectionIndexTitlesForTableView:)]) {
        return [self.delegate sectionIndexTitlesForTableView:tableView];
    }
    return  nil ;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ([self.delegate respondsToSelector:@selector(tableView:titleForHeaderInSection:)]) {
        return [self.delegate tableView:tableView titleForHeaderInSection:section];
    }
    return nil ;
}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString*)title atIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(tableView:sectionForSectionIndexTitle:atIndex:)]) {
        return [self.delegate tableView:tableView sectionForSectionIndexTitle:title atIndex:index] ;
    }
    
    return 0 ;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

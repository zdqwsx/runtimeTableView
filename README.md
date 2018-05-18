# runtimeTableView
封装tableview ，使用runtime 根据传入方法名称 ，动态获取cell ，动态获取cell传参方法，cell高度。
无需导入cell，model 头文件
实现目的 降低耦合，提高内聚性 ，快算布局一个列表，减少重复代码

runtimeTableView 结构分为三层
1. 第一层JBLayoutTableView 提供API功能

   (1)可以重写tableViewdelegate 任意一个或多个代理 ，深度定制
	 
   (2)- (instancetype)initJBNetLayoutFrame:(CGRect)tFrame 
	 
                             TableViewData:(NSArray *)tArrData
														 
                                  CellName:(NSString *)tCellName 
																	
                                  ModelName:(NSString *)tModelName
																	
                       LayoutTableViewState:(JBNetLayoutTableState)tLayoutState ;

tArrData 是数据源 tCellName 是cell类的名字  tModelName 是cell 赋值对象的名字任意类型都可

	(3)JBLayoutTableView_CellNumState 
	
	    /// 默认一级数组 section num =1  row num = arrData.count
    JBLayoutCellNumStateDefault  = 0,
    
    /// 二级数组 section num = arrData.count row num = arrData[section].count
    JBLayoutCellNumStateSecondLevel,
    
    /// section num = arrData.count row num = 1 ;
    JBLayoutCellNumStateNetLayout

2. 第二层JBLayoutTableTools  再未重写tableViewDelegate的情况下，实现tableViewDelegate 具体逻辑 ,包括cell高度，section/row 的数量与高度

3. 第三层JBLayoutCell ，使用runtime 初始化cell，给cell 赋值，调用cell 返回高度接口 ，等。。。

runtimeTableView 可以从三层从任意一层作为入口使用


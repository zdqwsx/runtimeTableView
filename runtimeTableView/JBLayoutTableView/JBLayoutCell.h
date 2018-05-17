//
//  JBLayoutCell.h
//  JieBao
//
//  Created by 君未央 on 2018/4/13.
//  Copyright © 2018年 YangJL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JBLayoutCell : NSObject

@property (nonatomic ,copy) NSArray *aryDataCell ;

/// 指定列表全部cell的类名 ，一旦传值内部判断将失效
@property (nonatomic ,copy) NSString *strCellName ;

/// 对传入的cell赋值 {key:value} 对应cell 属性key value
@property (nonatomic ,copy) NSDictionary *dicCellModelName ;

/// 传入 cell 响应btn的selector 方法名数组最多三个
@property (nonatomic ,copy) NSArray *aryCellBtnSelector ;

/// index 点击第几个按钮 这个row上的数据源
@property (nonatomic ,copy)void (^blockClickBtnAtCell)(NSInteger index , id model);

- (UITableViewCell *)buildLayoutCell:(UITableView *)tTableView
                           indexPath:(NSIndexPath *)tIndexPath
                            cellData:(id)dicData ;

 /// 返回一个空白的 cell
- (UITableViewCell *)tableViewAtDataSourceIsEmptyTableView:(UITableView *)tTableView ;

/// 根据cell 名字 model 名字 动态配置cell
- (UITableViewCell *)dynamicIncomingCell:(UITableView *)tTableView indexPath:(NSIndexPath *)tIndexPath ;

- (void)clickBtn1 ;
+ (void)clickBtn2 ;
+ (void)clickBtn3 ;

@end

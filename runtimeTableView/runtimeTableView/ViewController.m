//
//  ViewController.m
//  runtimeTableView
//
//  Created by 君未央 on 2018/5/17.
//  Copyright © 2018年 君未央. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    /*
     
     arr 为数据类型
     
     JBLayoutTableView *tabv = [[JBLayoutTableView alloc]initJBNetLayoutFrame:self.view.bounds
     TableViewData:arr LayoutTableViewState:JBLayoutCellNumStateDefault];
     ///需要复用的cell的类名
     tabv.strCellName = @"JBHomePageCell";
     ///需要给cell赋值的参数名字 需要在cell中重写 dic 或 model 或 string 。。。。 的 set 方法
     tabv.strModelName = @"strText";
     /// 获取cell高度的方法 写在cell 中的 类方法 +  接收参数类型与 “strModelName” 实际类型相同
     tabv.strSelectorName = @"cellHight:";
     /// 设置 section footer 与 header 高度 默认0.01
     tabv.fTableSectionFooterHight = 1 ;
     tabv.fTableSectionHeaderHight = 100 ;
     ///JBLayoutTableView 的代理 可以重写 tableview 代理方法实现具体定制
     tabv.delegate = self ;
     [self.view addSubview:tabv];
     [tabv buildTableView];
     
     tabv.blockDidTableView = ^(NSIndexPath *indexPath) {
     
     };
     
     
     
     /// 此处可以拓展调用 刷新与加载更多的功能
     [tabv.tabvTool creatrLoadMoreViewBlockLoadBegin:^{
     
     }];
     
     [tabv.tabvTool creatrPullToRefreshViewBlockRefreshBegin:^{
     
     }];
     */

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

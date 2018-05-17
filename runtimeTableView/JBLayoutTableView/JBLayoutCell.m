//
//  JBLayoutCell.m
//  JieBao
//
//  Created by 君未央 on 2018/4/13.
//  Copyright © 2018年 YangJL. All rights reserved.
//

#import "JBLayoutCell.h"
#import "Header.h"

#import <objc/runtime.h>
#import <objc/message.h>

@interface JBLayoutCell ()

@property (nonatomic ,copy) NSDictionary *dicCellData ;

@end

@implementation JBLayoutCell

- (UITableViewCell *)buildLayoutCell:(UITableView *)tTableView
                           indexPath:(NSIndexPath *)tIndexPath
                            cellData:(id)dicData
{
    ///TODO 要将字典转成模型
    if (!dicData) {
         return [self tableViewAtDataSourceIsEmptyTableView:tTableView] ;
    }

    self.dicCellData = dicData ;
    
    if (self.strCellName)
    {
        return [self dynamicIncomingCell:tTableView indexPath:tIndexPath];
    }
    
    /// TODO 获取 model 判断type
    NSString *strType = @"";
    if ([strType isEqualToString:@""]) {
        /// TODO if 判断写实际 cell
         return [self tableViewAtDataSourceIsEmptyTableView:tTableView] ;
    }else if ([strType isEqualToString:@""]) {
         return [self tableViewAtDataSourceIsEmptyTableView:tTableView] ;
    }else{
        return [self tableViewAtDataSourceIsEmptyTableView:tTableView] ;
    }
}

/// 根据cell 名字 model 名字 动态配置cell
- (UITableViewCell *)dynamicIncomingCell:(UITableView *)tTableView indexPath:(NSIndexPath *)tIndexPath
{
    UITableViewCell *cell = [tTableView dequeueReusableCellWithIdentifier:self.strCellName];
    if (cell == nil) {
                
        const char *className = [self.strCellName cStringUsingEncoding:NSASCIIStringEncoding];
        Class newClass = objc_getClass(className);
        if (!newClass) {
            //创建一个类
            Class superClass = [NSObject class];
            newClass = objc_allocateClassPair(superClass, className, 0);
            //注册你创建的这个类
            objc_registerClassPair(newClass);
        }
        
        cell = [[newClass alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:self.strCellName];
    }
    
    [self.dicCellModelName enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        if ([self checkIsExistPropertyWithInstance:[cell class] verifyPropertyName:key]) {
            
            [cell setValue:obj forKey:key];
        }else {
            NSLog(@"cell不包含key%@传入值的",key);
        }
        
    }];

    
    return cell ;

}

- (void)clickBtn1
{
    NSLog(@"btn1");
}



- (UITableViewCell *)tableViewAtDataSourceIsEmptyTableView:(UITableView *)tTableView
{
    NSString *strCell = @"emptyCell";
    UITableViewCell *cell = [tTableView dequeueReusableCellWithIdentifier:strCell];
    if (nil == cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
    }
    
    return cell ;
}



- (BOOL)checkIsExistPropertyWithInstance:(id)instance verifyPropertyName:(NSString *)verifyPropertyName
{
    if (0 == WQXK_Str_Protect(verifyPropertyName).length) {
        return NO ;
    }
    unsigned int outCount, i;
    
    /// 获取对象里的属性列表
    objc_property_t * properties = class_copyPropertyList([instance
                                                           class], &outCount);
    
    for (i = 0; i < outCount; i++) {
        objc_property_t property =properties[i];
        //  属性名转成字符串
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        // 判断该属性是否存在
        if ([propertyName isEqualToString:verifyPropertyName]) {
            free(properties);
            return YES;
        }
    }
    free(properties);
    
    /// 再遍历父类中的属性
    Class superClass = class_getSuperclass([instance class]);
    
    ///通过下面的方法获取属性列表
    unsigned int outCount2;
    objc_property_t *properties2 = class_copyPropertyList(superClass, &outCount2);
    
    for (int i = 0 ; i < outCount2; i++) {
        objc_property_t property2 = properties2[i];
        ///  属性名转成字符串
        NSString *propertyName2 = [[NSString alloc] initWithCString:property_getName(property2) encoding:NSUTF8StringEncoding];
        /// 判断该属性是否存在
        if ([propertyName2 isEqualToString:verifyPropertyName]) {
            free(properties2);
            return YES;
        }
    }
    free(properties2); //释放数组
    
    return NO;
}

+ (void)clickBtn2
{
    JBLayoutCell *cell = [[JBLayoutCell alloc]init];

    if (cell.blockClickBtnAtCell) {
        cell.blockClickBtnAtCell(1, cell.dicCellData);
    }
}

+ (void)clickBtn3
{
    JBLayoutCell *cell = [[JBLayoutCell alloc]init];

    if (cell.blockClickBtnAtCell) {
        cell.blockClickBtnAtCell(2, cell.dicCellData);
    }
}

@end

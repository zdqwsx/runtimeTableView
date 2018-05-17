//
//  Header.h
//  runtimeTableView
//
//  Created by 君未央 on 2018/5/17.
//  Copyright © 2018年 君未央. All rights reserved.
//

#ifndef Header_h
#define Header_h


#endif /* Header_h */

#define WQXK_Str_Protect(str) ((str) && (![str isKindOfClass:[NSNull class]]) ? (str) : (@""))

#define WQXK_Object_Is_Class(obj,className) [obj isKindOfClass:[className class]]
#define WQXK_Ary_Class(ary) WQXK_Object_Is_Class(ary, NSArray)
#define WQXK_Ary_Is_Valid(ary) ((ary) && (WQXK_Ary_Class(ary)) && ([ary count] > 0))
#define WQXK_Ary_Not_Valid(ary) ((!ary) || (!WQXK_Ary_Class(ary)) || ([ary count] <= 0))



/// 通过RGBA设置颜色，使用0x格式，如：RGBAAllColor(0xAABBCC, 0.5);
#define RGBAAllColor(rgb, a) [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0  \
green:((float)((rgb & 0xFF00) >> 8))/255.0     \
blue:((float)(rgb & 0xFF))/255.0              \
alpha:(a)/1.0]

/// 通过RGB设置颜色，使用0x格式，如：RGBAAllColor(0xAABBCC);
#define RGBAllColor(rgb) RGBAAllColor(rgb, 1.0)


#define JBCOLOR_BACKGROUND_VC RGBAllColor(0xf5f5f5)

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

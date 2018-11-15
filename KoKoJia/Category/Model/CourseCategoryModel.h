//
//  CourseCategoryModel.h
//  KoKoJia
//
//  Created by 陈双林 on 16/12/19.
//  Copyright © 2016年 CSL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CourseCategoryModel : NSObject
/**
 课程总数
 */
@property (copy, nonatomic) NSString * course_total;
/**
 课程id
 */
@property (copy, nonatomic) NSString * course_type_id;
/**
 课程分类名称
 */
@property (copy, nonatomic) NSString * course_type_name;
/**
 分类图标字体
 */
@property (copy, nonatomic) NSString * icon_font;
/**
 分类图标背景颜色
 */
@property (copy, nonatomic) NSString * icon_color;
/**
 子分类数组
 */
@property (strong, nonatomic) NSArray * type_two;

@end

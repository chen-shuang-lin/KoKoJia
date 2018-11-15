//
//  MainJpModel.h
//  KoKoJia
//
//  Created by 陈双林 on 16/12/16.
//  Copyright © 2016年 CSL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainJpHotModel : NSObject
/**
 课程id
 */
@property (copy, nonatomic) NSString * Id;
/**
 课程标题
 */
@property (copy, nonatomic) NSString * title;
/**
 课程图片
 */
@property (copy, nonatomic) NSString * image_url;
/**
 课程节数
 */
@property (copy, nonatomic) NSString * class_num;
/**
 课程学习人数
 */
@property (copy, nonatomic) NSString * trial_num;
/**
 课程类型
 */
@property (copy, nonatomic) NSString * course_type;
/**
 课程图片
 */
@property (copy, nonatomic) NSString * img;

@end

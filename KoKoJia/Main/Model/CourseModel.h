//
//  CourseModel.h
//  KoKoJia
//
//  Created by 陈双林 on 16/12/16.
//  Copyright © 2016年 CSL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CourseModel : NSObject
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
 课程活动
 */
@property (copy, nonatomic) NSString * activity;
/**
 课程折扣
 */
@property (copy, nonatomic) NSString * activity_rate;
/**
 是否支付
 */
@property (copy, nonatomic) NSString * is_paid;
/**
 课程价格
 */
@property (copy, nonatomic) NSString * price;
/**
 课程折扣价
 */
@property (copy, nonatomic) NSString * discount_price;
/**
 课程活动时间
 */
@property (copy, nonatomic) NSString * countdown;

@end

//
//  MainAdModel.h
//  KoKoJia
//
//  Created by 陈双林 on 16/12/16.
//  Copyright © 2016年 CSL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainAdModel : NSObject

/**
 主页广告类型
 */
@property (copy, nonatomic) NSString * type;
/**
 主页广告课程id
 */
@property (copy, nonatomic) NSString * course_id;
/**
 主页广告图片
 */
@property (copy, nonatomic) NSString * img;
@end

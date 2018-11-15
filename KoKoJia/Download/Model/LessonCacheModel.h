//
//  LessonCacheModel.h
//  KoKoJia
//
//  Created by 陈双林 on 16/12/28.
//  Copyright © 2016年 CSL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LessonCacheModel : NSObject

@property (copy,nonatomic) NSString * Id;
@property (copy,nonatomic) NSString * title;
@property (copy,nonatomic) NSString * course_id;
@property (copy,nonatomic) NSString * level;
@property (copy,nonatomic) NSString * chapter_position;
@property (copy,nonatomic) NSString * position;
@property (copy,nonatomic) NSString * trial;
@property (copy,nonatomic) NSString * player_status;
@property (assign, nonatomic) BOOL isExist;

@end

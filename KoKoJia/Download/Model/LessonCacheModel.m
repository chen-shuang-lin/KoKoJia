//
//  LessonCacheModel.m
//  KoKoJia
//
//  Created by 陈双林 on 16/12/28.
//  Copyright © 2016年 CSL. All rights reserved.
//

#import "LessonCacheModel.h"

@implementation LessonCacheModel

- (void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"Id"];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end

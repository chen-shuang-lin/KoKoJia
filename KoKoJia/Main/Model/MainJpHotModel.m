//
//  MainJpModel.m
//  KoKoJia
//
//  Created by 陈双林 on 16/12/16.
//  Copyright © 2016年 CSL. All rights reserved.
//

#import "MainJpHotModel.h"

@implementation MainJpHotModel

- (void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"Id"];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end

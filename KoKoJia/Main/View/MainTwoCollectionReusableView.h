//
//  MainCollectionReusableView.h
//  KoKoJia
//
//  Created by 陈双林 on 16/12/14.
//  Copyright © 2016年 CSL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    NormalColor,
    RedColor,
} ColorStyle;

@interface MainTwoCollectionReusableView : UICollectionReusableView
@property (strong, nonatomic) NSString * sectionText;
@property (assign, nonatomic) ColorStyle colorStyle;
@end

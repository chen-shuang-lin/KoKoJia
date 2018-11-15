//
//  MainOneCollectionReusableView.h
//  KoKoJia
//
//  Created by 陈双林 on 16/12/14.
//  Copyright © 2016年 CSL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SDCycleScrollView;

@interface MainOneCollectionReusableView : UICollectionReusableView
@property (strong, nonatomic) SDCycleScrollView * sycleScrollView;
/*
 *设置滚动视图的图片数组以及点击回调事件
 */
- (void)setImageUrlList:(NSArray *)list clickedItemOpreationBlock:(void(^)(NSInteger index))opreationBlock;

@end

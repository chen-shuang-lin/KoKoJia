//
//  MainOneCollectionReusableView.m
//  KoKoJia
//
//  Created by 陈双林 on 16/12/14.
//  Copyright © 2016年 CSL. All rights reserved.
//

#import "MainOneCollectionReusableView.h"
#import "SDCycleScrollView.h"


@implementation MainOneCollectionReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.sycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:self.bounds delegate:nil placeholderImage:nil];
        self.sycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        self.sycleScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
        [self addSubview:self.sycleScrollView];
    }
    return self;
}

- (void)setImageUrlList:(NSArray *)list clickedItemOpreationBlock:(void (^)(NSInteger))opreationBlock{
    self.sycleScrollView.imageURLStringsGroup = list;
    self.sycleScrollView.clickItemOperationBlock = ^(NSInteger index){
        if (opreationBlock) {
            opreationBlock(index);
        }
    };
}
                                
@end

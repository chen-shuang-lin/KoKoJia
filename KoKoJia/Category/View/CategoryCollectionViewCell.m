//
//  CategoryCollectionViewCell.m
//  KoKoJia
//
//  Created by 陈双林 on 16/12/19.
//  Copyright © 2016年 CSL. All rights reserved.
//

#import "CategoryCollectionViewCell.h"

@implementation CategoryCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    self.iconLabel.layer.cornerRadius = self.iconLabel.bounds.size.width/2;
    self.iconLabel.layer.masksToBounds = YES;
}

@end

//
//  MainThreeCollectionViewCell.h
//  KoKoJia
//
//  Created by 陈双林 on 16/12/14.
//  Copyright © 2016年 CSL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainThreeCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *courseImageView;
@property (weak, nonatomic) IBOutlet UILabel *courseNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *iconClassNum;
@property (weak, nonatomic) IBOutlet UILabel *classNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *iconTrial;
@property (weak, nonatomic) IBOutlet UILabel *trialNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *specialFlagLabel;

@end

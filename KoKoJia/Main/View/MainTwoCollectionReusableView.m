//
//  MainCollectionReusableView.m
//  KoKoJia
//
//  Created by 陈双林 on 16/12/14.
//  Copyright © 2016年 CSL. All rights reserved.
//

#import "MainTwoCollectionReusableView.h"

@implementation MainTwoCollectionReusableView{
    UILabel * _iconLabel;
    UILabel * _textLabel;
    UIView * _line;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIView * bgColorView = [[UIView alloc] initWithFrame:self.bounds];
        bgColorView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
        [self addSubview:bgColorView];
        
        UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 8, self.bounds.size.width, self.bounds.size.height-8)];
        bgView.backgroundColor = [UIColor whiteColor];
        [bgColorView addSubview:bgView];
        
        _iconLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, 20, CGRectGetHeight(bgView.bounds))];
        _iconLabel.font = [UIFont fontWithName:@"fontawesome" size:15];
        _iconLabel.text = @"\U0000f01d";
        _iconLabel.textColor = [UIColor lightGrayColor];
        [bgView addSubview:_iconLabel];
        
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_iconLabel.frame), 0, frame.size.width-8-CGRectGetMaxX(_iconLabel.frame), CGRectGetHeight(bgView.bounds))];
        _textLabel.font = [UIFont systemFontOfSize:15];
        _textLabel.textColor = [UIColor lightGrayColor];
        [bgView addSubview:_textLabel];
        
        _line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(bgColorView.bounds)-1, self.bounds.size.width, 1)];
        _line.backgroundColor = [UIColor lightGrayColor];
        [bgColorView addSubview:_line];
    }
    return self;
}

- (void)setSectionText:(NSString *)sectionText{
    _textLabel.text = [NSString stringWithFormat:@"%@",sectionText];
}

- (void)setColorStyle:(ColorStyle)colorStyle{
    switch (colorStyle) {
        case NormalColor:
        {
            _iconLabel.textColor = [UIColor lightGrayColor];
            _textLabel.textColor = [UIColor lightGrayColor];
            _line.backgroundColor = [UIColor lightGrayColor];
        }
            break;
        case RedColor:
        {
            _iconLabel.textColor = [UIColor redColor];
            _textLabel.textColor = [UIColor redColor];
            _line.backgroundColor = [UIColor redColor];
        }
            break;
        default:
        {
            _iconLabel.textColor = [UIColor lightGrayColor];
            _textLabel.textColor = [UIColor lightGrayColor];
            _line.backgroundColor = [UIColor lightGrayColor];
        }
            break;
    }
}

@end

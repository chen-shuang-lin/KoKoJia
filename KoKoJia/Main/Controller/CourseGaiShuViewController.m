//
//  CourseGaiShuViewController.m
//  KoKoJia
//
//  Created by 陈双林 on 16/12/22.
//  Copyright © 2016年 CSL. All rights reserved.
//

#import "CourseGaiShuViewController.h"
#import <UIImageView+WebCache.h>

@interface CourseGaiShuViewController ()

@property (weak, nonatomic) IBOutlet UITableView *gaishuTableView;

@property (strong, nonatomic) UILabel * titleLabel;  //课程名
@property (strong, nonatomic) UILabel * priceLabel;  //课程价格

@property (strong, nonatomic) NSMutableArray * gaishuArr;


@end

@implementation CourseGaiShuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //创建表头，即课程名和课程价格
    UIView * head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(8, CGRectGetMaxY(head.frame)-1, SCREEN_WIDTH-16, 1)];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [head addSubview:line];
    
    [head addSubview:self.titleLabel];
    [head addSubview:self.priceLabel];
    
    
    self.gaishuTableView.tableHeaderView = head;
    [self.gaishuTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
}


- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 10, SCREEN_WIDTH-16, 20)];
        _titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titleLabel;
}

- (UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, CGRectGetMaxY(self.titleLabel.frame), SCREEN_WIDTH-16, 50)];
        _priceLabel.font = [UIFont systemFontOfSize:25];
        _priceLabel.textColor = [UIColor redColor];
    }
    return _priceLabel;
}

- (void)setResponseDic:(NSDictionary *)responseDic{
    _responseDic = responseDic;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray * tempArr = [NSMutableArray new];
        [tempArr addObject:[NSString stringWithFormat:@"学院：%@",self.responseDic[@"course"][@"school_name"]]];
        [tempArr addObject:[NSString stringWithFormat:@"课时：%@",self.responseDic[@"course"][@"class_num"]]];
        [tempArr addObject:[NSString stringWithFormat:@"有效性：%@",self.responseDic[@"course"][@"endtime"]]];
        if (![self.responseDic[@"course"][@"target"] isEqualToString:@""]) {
            [tempArr addObject:[NSString stringWithFormat:@"课程目标：%@",self.responseDic[@"course"][@"target"]]];
        }
        [tempArr addObject:[NSString stringWithFormat:@"适合人群：%@",self.responseDic[@"course"][@"crowd"]]];
        [tempArr addObject:self.responseDic[@"course"][@"content"]];
        self.gaishuArr = [tempArr copy];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.gaishuTableView reloadData];
        });
    });
    
    self.titleLabel.text = [NSString stringWithFormat:@"%@",self.responseDic[@"course"][@"title"]];
    self.priceLabel.text = [NSString stringWithFormat:@"%@",self.responseDic[@"course"][@"price"]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.gaishuArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.gaishuArr.count-1) {
        CGFloat maxY = 10;
        if ([self.gaishuArr.lastObject count]>0) {
            for (int i = 0; i<[self.gaishuArr.lastObject count]; i++) {
                NSDictionary * dic = self.gaishuArr.lastObject[i];
                if ([dic[@"type"] integerValue] == 0) {
                    NSString * desc = dic[@"desc"];
                    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading;
                    CGRect rect = [desc boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-30, 10000) options:options attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
                    maxY += rect.size.height;
                }else if ([dic[@"type"] integerValue] == 1) {
                    CGFloat height = [dic[@"height"] floatValue];
                    CGFloat width = [dic[@"width"] floatValue];
                    CGFloat vh = height*(SCREEN_WIDTH-30)/width;
                    maxY += vh;
                }else{
                }
            }
        }
        return maxY;
    }else{
        return 30;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * identity = [NSString stringWithFormat:@"%ld",indexPath.row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
        if (indexPath.row == self.gaishuArr.count-1) {
            if ([self.gaishuArr.lastObject count]>0) {
                CGFloat maxY = 10;
                for (int i = 0; i<[self.gaishuArr.lastObject count]; i++) {
                    NSDictionary * dic = self.gaishuArr.lastObject[i];
                    if ([dic[@"type"] integerValue] == 0) {
                        NSString * desc = dic[@"desc"];
                        NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading;
                        CGRect rect = [desc boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-30, 10000) options:options attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
                        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(15, maxY, SCREEN_WIDTH-30, rect.size.height)];
                        label.text = desc;
                        label.font = [UIFont systemFontOfSize:12];
                        label.numberOfLines = 0;
                        [cell.contentView addSubview:label];
                        maxY += rect.size.height;
                    }else if ([dic[@"type"] integerValue] == 1) {
                        CGFloat height = [dic[@"height"] floatValue];
                        CGFloat width = [dic[@"width"] floatValue];
                        CGFloat vh = height*(SCREEN_WIDTH-30)/width;
                        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, maxY, SCREEN_WIDTH-30, vh)];
                        [cell.contentView addSubview:imageView];
                        [imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"desc"]]];
                        maxY += vh;
                    }else{
                        NSLog(@"课程介绍类型不匹配");
                    }
                }
            }
            cell.textLabel.text = @"";
        }else{
            cell.textLabel.text = [NSString stringWithFormat:@"%@",self.gaishuArr[indexPath.row]];
        }
        cell.textLabel.font = [UIFont systemFontOfSize:12];
    }
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  CourseDetailViewController.m
//  KoKoJia
//
//  Created by 陈双林 on 16/12/21.
//  Copyright © 2016年 CSL. All rights reserved.
//

#import "CourseDetailViewController.h"
#import "SGTopTitleView.h"
#import "CourseGaiShuViewController.h"
#import <UIImageView+WebCache.h>

@interface CourseDetailViewController ()<SGTopTitleViewDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *courseImageView;
@property (weak, nonatomic) IBOutlet UILabel *courseInfoLabel;
@property (strong, nonatomic) SGTopTitleView *topTitleView;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) NSArray *titles;

@property (strong, nonatomic) CourseGaiShuViewController * oneVC;

@end

@implementation CourseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"课程详情";
    // 1.添加所有子控制器
    [self setupChildViewController];
    
    self.topTitleView = [SGTopTitleView topTitleViewWithFrame:CGRectMake(0, 180, SCREEN_WIDTH, 30)];
    [self.view addSubview:self.topTitleView];
    _topTitleView.delegate_SG = self;
    _titles = @[@"概述",@"目录",@"评价(100)",@"讨论"];
    self.topTitleView.staticTitleArr = _titles;
    
    // 创建底部滚动视图
    self.mainScrollView = [[UIScrollView alloc] init];
    _mainScrollView.frame = CGRectMake(0, 210, self.view.frame.size.width, self.view.frame.size.height-210-40);
    _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width * _titles.count, 0);
    _mainScrollView.backgroundColor = [UIColor clearColor];
    // 开启分页
    _mainScrollView.pagingEnabled = YES;
    // 没有弹簧效果
    _mainScrollView.bounces = NO;
    // 隐藏水平滚动条
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    // 设置代理
    _mainScrollView.delegate = self;
    [self.view addSubview:_mainScrollView];
    
    _oneVC = [[CourseGaiShuViewController alloc] init];
    _oneVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(_mainScrollView.bounds));
    [self.mainScrollView addSubview:_oneVC.view];
    
    [self.view insertSubview:_mainScrollView belowSubview:_topTitleView];
    
    [self request];
    
}

- (void)request{
    [[HttpRequest sharedInstance] getWithURLString:@"http://www.kokojia.com/" parameters:@{@"m":@"App",@"a":@"courseDetail",@"id":@"2337",@"uid":@"0"} success:^(id responseObject) {
        NSDictionary * responseDic = responseObject;
        _oneVC.responseDic = responseDic;
        [self.courseImageView sd_setImageWithURL:[NSURL URLWithString:responseDic[@"course"][@"image_url"]]];
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark - - - SGTopScrollMenu代理方法
- (void)SGTopTitleView:(SGTopTitleView *)topTitleView didSelectTitleAtIndex:(NSInteger)index {
    
    // 1 计算滚动的位置
    CGFloat offsetX = index * self.view.frame.size.width;
    self.mainScrollView.contentOffset = CGPointMake(offsetX, 0);
    
    // 2.给对应位置添加对应子控制器
    [self showVc:index];
}

// 添加所有子控制器
- (void)setupChildViewController {
    // 精选
    CourseGaiShuViewController *oneVC = [[CourseGaiShuViewController alloc] init];
    [self addChildViewController:oneVC];
    
    // 电视剧
    CourseGaiShuViewController *twoVC = [[CourseGaiShuViewController alloc] init];
    [self addChildViewController:twoVC];
    
    // 电影
    CourseGaiShuViewController *threeVC = [[CourseGaiShuViewController alloc] init];
    [self addChildViewController:threeVC];
    
    // 综艺
    CourseGaiShuViewController *fourVC = [[CourseGaiShuViewController alloc] init];
    [self addChildViewController:fourVC];
    
}

// 显示控制器的view
- (void)showVc:(NSInteger)index {
    
    CGFloat offsetX = index * self.view.frame.size.width;
    
    UIViewController *vc = self.childViewControllers[index];
    
    // 判断控制器的view有没有加载过,如果已经加载过,就不需要加载
    if (vc.isViewLoaded) return;
    
    [self.mainScrollView addSubview:vc.view];
    vc.view.frame = CGRectMake(offsetX, 0, self.view.frame.size.width, self.view.frame.size.height);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    // 计算滚动到哪一页
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    // 1.添加子控制器view
    [self showVc:index];
    
    // 2.把对应的标题选中
    UILabel *selLabel = self.topTitleView.allTitleLabel[index];
    
    
    [self.topTitleView scrollTitleLabelSelecteded:selLabel];
    // 3.让选中的标题居中
    [self.topTitleView scrollTitleLabelSelectededCenter:selLabel];
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

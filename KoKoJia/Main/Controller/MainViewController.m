//
//  MainViewController.m
//  KoKoJia
//
//  Created by 陈双林 on 16/12/12.
//  Copyright © 2016年 CSL. All rights reserved.
//

#import "MainViewController.h"
#import "MainOneCollectionViewCell.h"
#import "MainTwoCollectionViewCell.h"
#import "MainThreeCollectionViewCell.h"
#import "MainFourCollectionViewCell.h"
#import "MainOneCollectionReusableView.h"
#import "MainTwoCollectionReusableView.h"
#import "SDCycleScrollView.h"
#import "MainAdModel.h"
#import "MainJpHotModel.h"
#import "CourseModel.h"
#import <UIImageView+WebCache.h>
#import <MBProgressHUD.h>
#import "CourseDetailViewController.h"

#define UIColorFromHex(s) [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:1.0]

@interface MainViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UICollectionView * mainCollectionView;

@property (strong, nonatomic) NSArray * iconNameArr;
@property (strong, nonatomic) NSArray * iconColorArr;
@property (strong, nonatomic) NSArray * typeNameArr;

@property (strong, nonatomic) NSMutableArray * adArr;
@property (strong, nonatomic) NSMutableArray * jpArr;
@property (strong, nonatomic) NSMutableArray * hotArr;
@property (strong, nonatomic) NSMutableArray * listArr;

@end

@implementation MainViewController

#pragma mark ----懒加载方法----

- (NSArray *)iconNameArr{
    if (!_iconNameArr) {
        _iconNameArr = @[@"\U0000f12e",@"\U0000f121",@"\U0000f1fc",@"\U0000f26c",@"\U0000f11b",@"\U0000f10a",@"\U0000f201",@"\U0000f009"];
    }
    return _iconNameArr;
}

- (NSArray *)iconColorArr{
    if (!_iconColorArr) {
        _iconColorArr = @[@"f98181",@"ffb74d",@"58dd8d",@"6fa9f9",@"ffb74d",@"58dd8d",@"4db6ac",@"58dd8d"];
    }
    return _iconColorArr;
}

- (NSArray *)typeNameArr{
    if (!_typeNameArr) {
        _typeNameArr = @[@"考试认证",@"编程语言",@"设计",@"Web开发",@"游戏开发",@"移动开发",@"Office",@"更多"];
    }
    return _typeNameArr;
}

- (NSMutableArray *)adArr{
    if (!_adArr) {
        _adArr = [NSMutableArray new];
    }
    return _adArr;
}

- (NSMutableArray *)jpArr{
    if (!_jpArr) {
        _jpArr = [NSMutableArray new];
    }
    return _jpArr;
}

- (NSMutableArray *)hotArr{
    if (!_hotArr) {
        _hotArr = [NSMutableArray new];
    }
    return _hotArr;
}

- (NSMutableArray *)listArr{
    if (!_listArr) {
        _listArr = [NSMutableArray new];
    }
    return _listArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"精选";
    
    [self setupMainCollectionView];
    [self requestMainPageData];
    
}

- (void)setupMainCollectionView{
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStylePlain target:self action:@selector(search)];
    self.navigationItem.rightBarButtonItem = item;
    
    //布局
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.mainCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    //添加上去
    [self.view addSubview:self.mainCollectionView];
    self.mainCollectionView.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
    self.mainCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 113, 0);
    //设置代理
    self.mainCollectionView.delegate = self;
    self.mainCollectionView.dataSource = self;
    //注册cell
    [self.mainCollectionView registerNib:[UINib nibWithNibName:@"MainOneCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MainOne"];
    [self.mainCollectionView registerNib:[UINib nibWithNibName:@"MainTwoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MainTwo"];
    [self.mainCollectionView registerNib:[UINib nibWithNibName:@"MainThreeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MainThree"];
    [self.mainCollectionView registerNib:[UINib nibWithNibName:@"MainFourCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MainFour"];
    //注册组头
    [self.mainCollectionView registerClass:[MainOneCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MainOneHeader"];
    [self.mainCollectionView registerClass:[MainTwoCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MainTwoHeader"];
    
}

- (void)requestMainPageData{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary * parameters = @{@"m":@"App",@"a":@"getIndex",@"page":@"1"};
    [[HttpRequest sharedInstance] getWithURLString:BaseUrl parameters:parameters success:^(id responseObject) {
        for (NSDictionary * dic in responseObject[@"index_ad"]) {
            MainAdModel * adModel = [MainAdModel new];
            [adModel setValuesForKeysWithDictionary:dic];
            [self.adArr addObject:adModel];
        }
        for (NSDictionary * dic in responseObject[@"course_jp"]) {
            MainJpHotModel * jpModel = [MainJpHotModel new];
            [jpModel setValuesForKeysWithDictionary:dic];
            [self.jpArr addObject:jpModel];
        }
        for (NSDictionary * dic in responseObject[@"course_hot"]) {
            MainJpHotModel * hotModel = [MainJpHotModel new];
            [hotModel setValuesForKeysWithDictionary:dic];
            [self.hotArr addObject:hotModel];
        }
        for (NSDictionary * dic in responseObject[@"course_list"]) {
            CourseModel * courseModel = [CourseModel new];
            [courseModel setValuesForKeysWithDictionary:dic];
            [self.listArr addObject:courseModel];
        }
        [self.mainCollectionView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 8;
            break;
        case 1:
            return self.jpArr.count;
            break;
        case 2:
            return self.hotArr.count;
            break;
        case 3:
            return self.listArr.count;
            break;
        default:
            break;
    }
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            MainOneCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"MainOne" forIndexPath:indexPath];
            unsigned long color = strtoul([self.iconColorArr[indexPath.row] UTF8String], 0, 16);
            cell.iconLabel.backgroundColor = UIColorFromHex(color);
            cell.iconLabel.font = [UIFont fontWithName:@"fontawesome" size:25];
            cell.iconLabel.text = self.iconNameArr[indexPath.row];
            cell.categoryNameLabel.text = self.typeNameArr[indexPath.row];
            
            return cell;
        }
            break;
        case 1:
        {
            MainJpHotModel * jpModel = self.jpArr[indexPath.row];
            MainThreeCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"MainThree" forIndexPath:indexPath];
            [cell.courseImageView sd_setImageWithURL:[NSURL URLWithString:jpModel.img] placeholderImage:nil];
            cell.courseNameLabel.text = jpModel.title;
            cell.iconClassNum.font = [UIFont fontWithName:@"fontawesome" size:10];
            cell.iconClassNum.text = @"\U0000f017";
            cell.classNumLabel.text = [NSString stringWithFormat:@"共%@课时",jpModel.class_num];
            cell.iconTrial.font = [UIFont fontWithName:@"fontawesome" size:10];
            cell.iconTrial.text = @"\U0000f007";
            cell.trialNumLabel.text = [NSString stringWithFormat:@"%@人在学",jpModel.trial_num];
            switch ([jpModel.course_type integerValue]) {
                case 1:{
                    cell.specialFlagLabel.text = @"推荐";
                    cell.specialFlagLabel.hidden = NO;
                }
                    break;
                case 2:{
                    cell.specialFlagLabel.text = @"独家";
                    cell.specialFlagLabel.hidden = NO;
                }
                    break;
                case 3:{
                    cell.specialFlagLabel.text = @"首发";
                    cell.specialFlagLabel.hidden = NO;
                }
                    break;
                default:{
                    cell.specialFlagLabel.text = @"";
                    cell.specialFlagLabel.hidden = YES;
                }
                    break;
            }
            return cell;
        }
            break;
        case 2:
        {
            MainJpHotModel * hotModel = self.hotArr[indexPath.row];
            MainThreeCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"MainThree" forIndexPath:indexPath];
            [cell.courseImageView sd_setImageWithURL:[NSURL URLWithString:hotModel.img] placeholderImage:nil];
            cell.courseNameLabel.text = hotModel.title;
            cell.iconClassNum.font = [UIFont fontWithName:@"fontawesome" size:10];
            cell.iconClassNum.text = @"\U0000f017";
            cell.classNumLabel.text = [NSString stringWithFormat:@"共%@课时",hotModel.class_num];
            cell.iconTrial.font = [UIFont fontWithName:@"fontawesome" size:10];
            cell.iconTrial.text = @"\U0000f007";
            cell.trialNumLabel.text = [NSString stringWithFormat:@"%@人在学",hotModel.trial_num];
            switch ([hotModel.course_type integerValue]) {
                case 1:{
                    cell.specialFlagLabel.text = @"推荐";
                    cell.specialFlagLabel.hidden = NO;
                }
                    break;
                case 2:{
                    cell.specialFlagLabel.text = @"独家";
                    cell.specialFlagLabel.hidden = NO;
                }
                    break;
                case 3:{
                    cell.specialFlagLabel.text = @"首发";
                    cell.specialFlagLabel.hidden = NO;
                }
                    break;
                default:{
                    cell.specialFlagLabel.text = @"";
                    cell.specialFlagLabel.hidden = YES;
                }
                    break;
            }
            return cell;
        }
            break;
        case 3:
        {
            CourseModel * courseModel = self.listArr[indexPath.row];
            MainFourCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"MainFour" forIndexPath:indexPath];
            [cell.courseImageView sd_setImageWithURL:[NSURL URLWithString:courseModel.image_url] placeholderImage:nil];
            cell.courseNameLabel.text = courseModel.title;
            NSMutableAttributedString * priceStr = [[NSMutableAttributedString alloc] initWithString:courseModel.price];
            if (courseModel.discount_price&&![courseModel.discount_price isEqual:[NSNull null]]) {
                priceStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@  %@  %@",courseModel.discount_price,courseModel.price,courseModel.countdown]];
                [priceStr addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid) range:NSMakeRange(courseModel.discount_price.length+2, courseModel.price.length)];
                [priceStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(courseModel.discount_price.length+2, courseModel.price.length)];
                [priceStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(priceStr.length-courseModel.countdown.length, courseModel.countdown.length)];
            }
            cell.priceLabel.attributedText = priceStr;
            cell.iconClassNum.font = [UIFont fontWithName:@"fontawesome" size:10];
            cell.iconClassNum.text = @"\U0000f017";
            cell.classNumLabel.text = [NSString stringWithFormat:@"共%@课时",courseModel.class_num];
            cell.iconTrial.font = [UIFont fontWithName:@"fontawesome" size:10];
            cell.iconTrial.text = @"\U0000f007";
            cell.trialNumLabel.text = [NSString stringWithFormat:@"%@人在学",courseModel.trial_num];
            return cell;
        }
            break;
        default:
            break;
    }
    return nil;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) {
            MainOneCollectionReusableView * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MainOneHeader" forIndexPath:indexPath];
            NSMutableArray * arr = [NSMutableArray new];
            for (MainAdModel * adModel in self.adArr) {
                [arr addObject:adModel.img];
            }
            [header setImageUrlList:arr clickedItemOpreationBlock:^(NSInteger index) {
                NSLog(@"---%ld",index);
            }];
            return header;
        }else{
            MainTwoCollectionReusableView * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MainTwoHeader" forIndexPath:indexPath];
            if (indexPath.section == 1) {
                header.sectionText = @"视频精选 畅品天天选购";
                header.colorStyle = RedColor;
            }else if (indexPath.section == 2) {
                header.sectionText = @"热门视频教程";
                header.colorStyle = RedColor;
            }else if (indexPath.section == 3) {
                header.sectionText = @"更多视频教程";
                header.colorStyle = NormalColor;
            }else{
                
            }
            return header;
        }
        
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(SCREEN_WIDTH, 180);
    }else{
        return CGSizeMake(SCREEN_WIDTH, 50);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake(SCREEN_WIDTH/4, 80);
    }else if (indexPath.section == 1) {
        return CGSizeMake(SCREEN_WIDTH/2, 155);
    }else if (indexPath.section == 2) {
        return CGSizeMake(SCREEN_WIDTH/2, 155);
    }
    return CGSizeMake(SCREEN_WIDTH, 86);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",indexPath);
    
    switch (indexPath.section) {
        case 0:{
            switch (indexPath.row) {
                case 7:{
                    self.tabBarController.selectedIndex = 1;
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 1:
            [self pushToCourseDetailViewControllerWithCourseId:nil];
            break;
        case 2:
            [self pushToCourseDetailViewControllerWithCourseId:nil];
            break;
        case 3:
            [self pushToCourseDetailViewControllerWithCourseId:nil];
            break;
        default:
            break;
    }
    
}

- (void)pushToCourseDetailViewControllerWithCourseId:(NSString *)courseId{
    CourseDetailViewController * detailVC = [CourseDetailViewController new];
    
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)search{
    
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

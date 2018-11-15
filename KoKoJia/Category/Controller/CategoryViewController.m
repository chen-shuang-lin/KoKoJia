//
//  CategoryViewController.m
//  KoKoJia
//
//  Created by 陈双林 on 16/12/12.
//  Copyright © 2016年 CSL. All rights reserved.
//

#import "CategoryViewController.h"
#import "CategoryCollectionViewCell.h"
#import "CourseCategoryModel.h"
#import <AFNetworking.h>
#import "CacheListViewController.h"

#define UIColorFromHex(s) [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:1.0]

@interface CategoryViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    // 下载句柄
    NSURLSessionDownloadTask *_downloadTask;
}
@property (strong, nonatomic) UICollectionView * categoryCollectionView;

@property (strong, nonatomic) NSMutableArray * allCaregoryArr;
@end

@implementation CategoryViewController

- (NSMutableArray *)allCaregoryArr{
    if (!_allCaregoryArr) {
        _allCaregoryArr = [NSMutableArray new];
    }
    return _allCaregoryArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"分类";
    [self setupCategoryCollectionView];
    [self requestAllCategoryData];
}

- (void)setupCategoryCollectionView{
    //布局
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.categoryCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.categoryCollectionView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    //设置代理
    self.categoryCollectionView.delegate = self;
    self.categoryCollectionView.dataSource = self;
    //注册cell
    [self.categoryCollectionView registerNib:[UINib nibWithNibName:@"CategoryCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CategoryCell"];
    //注册组头
//    [self.mainCollectionView registerClass:[MainOneCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MainOneHeader"];
//    [self.mainCollectionView registerNib:[UINib nibWithNibName:@"MainTwoCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MainTwoHeader"];
    //添加上去
    [self.view addSubview:self.categoryCollectionView];
    
}

- (void)requestAllCategoryData{
    NSDictionary * parameters = @{@"m":@"App",@"a":@"courseType",@"tid":@"2"};
    [[HttpRequest sharedInstance] getWithURLString:BaseUrl parameters:parameters success:^(id responseObject) {
        NSMutableArray * courseTypeArr = [NSMutableArray arrayWithArray:responseObject[@"course_type"]];
        courseTypeArr.count>0?[courseTypeArr removeObjectAtIndex:0]:nil;
        for (NSDictionary * typeDic in courseTypeArr) {
            CourseCategoryModel * categoryModel = [CourseCategoryModel new];
            [categoryModel setValuesForKeysWithDictionary:typeDic];
            [self.allCaregoryArr addObject:categoryModel];
        }
        [self.categoryCollectionView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.allCaregoryArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CategoryCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"CategoryCell" forIndexPath:indexPath];
    CourseCategoryModel * categoryModel = self.allCaregoryArr[indexPath.row];
    unsigned long color = strtoul([categoryModel.icon_color UTF8String], 0, 16);
    cell.iconLabel.backgroundColor = UIColorFromHex(color);
    cell.iconLabel.font = [UIFont fontWithName:@"fontawesome" size:25];
    
    unichar icon = strtoul([categoryModel.icon_font UTF8String],0, 16);
    cell.iconLabel.text = [NSString stringWithCharacters:&icon length:1];
    
    cell.categoryNameLabel.text = categoryModel.course_type_name;
    
    return cell;
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    if (kind == UICollectionElementKindSectionHeader) {
//        if (indexPath.section == 0) {
//            MainOneCollectionReusableView * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MainOneHeader" forIndexPath:indexPath];
//            NSMutableArray * arr = [NSMutableArray new];
//            for (MainAdModel * adModel in self.adArr) {
//                [arr addObject:adModel.img];
//            }
//            [header setImageUrlList:arr clickedItemOpreationBlock:^(NSInteger index) {
//                NSLog(@"---%ld",index);
//            }];
//            return header;
//        }else{
//            MainTwoCollectionReusableView * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MainTwoHeader" forIndexPath:indexPath];
//            return header;
//        }
//        
//    }
//    return nil;
//}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    if (section == 0) {
//        return CGSizeMake(SCREEN_WIDTH, 160);
//    }else{
//        return CGSizeMake(SCREEN_WIDTH, 50);
//    }
//}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((SCREEN_WIDTH-3)/4, (SCREEN_WIDTH-3)/4);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",indexPath);
    CacheListViewController * cacheVC = [CacheListViewController new];
    [self.navigationController pushViewController:cacheVC animated:YES];
//    [self downFileFromServer];
}


- (void)downFileFromServer{
    
    //远程地址
    NSURL *URL = [NSURL URLWithString:@"http://v1.mukewang.com/a45016f4-08d6-4277-abe6-bcfd5244c201/L.mp4"];
    //默认配置
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //AFN3.0+基于封住URLSession的句柄
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    //请求
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    //下载Task操作
    _downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        // @property int64_t totalUnitCount;     需要下载文件的总大小
        // @property int64_t completedUnitCount; 当前已经下载的大小
        
        // 给Progress添加监听 KVO
        NSLog(@"%f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        // 回到主队列刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            // 设置进度条的百分比
            CGFloat progress = 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
            NSLog(@"---------------progress:  %f  -------",progress);
//            self.progressView.progress = 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
        });
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        //- block的返回值, 要求返回一个URL, 返回的这个URL就是文件的位置的路径
        
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString * fullPath = [NSString stringWithFormat:@"%@/DownLoadVedios",cachesPath];
        NSString *path = [fullPath stringByAppendingPathComponent:response.suggestedFilename];
        NSLog(@"-----------path%@",path);
        
        return [NSURL fileURLWithPath:path];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        //设置下载完成操作
        // filePath就是你下载文件的位置，你可以解压，也可以直接拿来使用
        
//        NSString *imgFilePath = [filePath path];// 将NSURL转成NSString
//        UIImage *img = [UIImage imageWithContentsOfFile:imgFilePath];
//        self.imageView.image = img;
        
    }];
    
    [_downloadTask resume];
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

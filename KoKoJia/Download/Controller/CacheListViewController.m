//
//  CacheListViewController.m
//  KoKoJia
//
//  Created by 陈双林 on 16/12/28.
//  Copyright © 2016年 CSL. All rights reserved.
//

#import "CacheListViewController.h"
#import "CacheListNoCell.h"
#import "CacheListYesCell.h"
#import "LessonCacheModel.h"
#import <AFNetworking.h>

@interface CacheListViewController ()<UITableViewDelegate,UITableViewDataSource>{
    // 下载句柄
    NSURLSessionDownloadTask *_downloadTask;
}
@property (weak, nonatomic) IBOutlet UITableView *cacheListTableView;
@property (strong, nonatomic) NSMutableArray * cacheListArr;
@end

@implementation CacheListViewController

- (NSArray *)cacheListArr{
    if (!_cacheListArr) {
        _cacheListArr = [NSMutableArray new];
    }
    return _cacheListArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"缓存列表";
    
    [self.cacheListTableView registerNib:[UINib nibWithNibName:@"CacheListNoCell" bundle:nil] forCellReuseIdentifier:@"NoCell"];
    [self.cacheListTableView registerNib:[UINib nibWithNibName:@"CacheListYesCell" bundle:nil] forCellReuseIdentifier:@"YesCell"];
    
    [self requestCacheList];
    
}

- (void)requestCacheList{
    NSDictionary * parameters = @{@"uid":@"10065801",@"id":@"4031"};
    NSString * url = [NSString stringWithFormat:@"%@?m=App&a=courseLessonDownload",BaseUrl];
    [[HttpRequest sharedInstance] postWithURLString:url parameters:parameters success:^(id responseObject) {
        NSDictionary * responseDic = responseObject;
        NSArray * lessonArr = responseDic[@"lesson"];
        for (NSDictionary * lessonDic in lessonArr) {
            LessonCacheModel * lessonModel = [LessonCacheModel new];
            [lessonModel setValuesForKeysWithDictionary:lessonDic];
            [self.cacheListArr addObject:lessonModel];
        }
        [self.cacheListTableView reloadData];
    } failure:^(NSError *error) {
        
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cacheListArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LessonCacheModel * lessonModel = self.cacheListArr[indexPath.row];
    if (!lessonModel.isExist) {
        CacheListNoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NoCell"];
        cell.textLabel.text = lessonModel.title;
        return cell;
    }else{
        CacheListYesCell * cell = [tableView dequeueReusableCellWithIdentifier:@"YesCell"];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LessonCacheModel * lessonModel = self.cacheListArr[indexPath.row];
    [self requestVideoDownLoadInfoWithLid:lessonModel.Id];
}

- (void)requestVideoDownLoadInfoWithLid:(NSString *)lid{
    NSDictionary * parameters = @{@"uid":@"10065801",@"id":@"4031",@"lid":lid};
    NSString * url = [NSString stringWithFormat:@"%@?m=App&a=courseVideoDownload",BaseUrl];
    [[HttpRequest sharedInstance] postWithURLString:url parameters:parameters success:^(id responseObject) {
        NSDictionary * responseDic = responseObject;
        [self downLoadVideoWithUrl:responseDic[@"video_file"]];
    } failure:^(NSError *error) {
        
    }];
}

- (void)downLoadVideoWithUrl:(NSString *)url{
    //远程地址
    NSURL *URL = [NSURL URLWithString:url];
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
        NSString * fullPath = [NSString stringWithFormat:@"%@",cachesPath];
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

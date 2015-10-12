//
//  ViewController.m
//  GCDa
//
//  Created by apple on 15/10/5.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "InfoNSOperation.h"
#import "SecondNSOperation.h"
#import "DownloadOPr.h"
@interface ViewController ()<ImageDownloaderDelegate>
{
    NSMutableArray<UIImageView *> *_imageViewsArray;
    NSMutableArray *_imageUrlsArray;
}

@property (weak,nonatomic) IBOutlet UIImageView *imageView;
@property (weak,nonatomic) IBOutlet UIImageView *imagView2;


@end

@implementation ViewController

- (void)imageDownloaderDidFinished:(DownloadOPr *)downlader
{
    NSInteger index = [_imageUrlsArray indexOfObject:downlader.Url.absoluteString];
    UIImageView *imageview = _imageViewsArray[index];
    NSLog(@"%lu",index);
    imageview.image = downlader.image;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _imageUrlsArray = [NSMutableArray arrayWithArray:@[@"http://yn.xinhuanet.com/ent/2015-08/25/134553023_14404735455561n.jpg",@"http://tse1.mm.bing.net/th?&id=OIP.M1f3742993139f6fcb52453357a2af60bo0&w=300&h=300&c=0&pid=1.9&rs=0&p=0"
                                                       ]];
    _imageViewsArray = [NSMutableArray array];
    
    
    [super viewDidLoad];
    CGRect rect = CGRectMake(30, 40, 100, 40);
    UIButton *l = [[UIButton alloc] initWithFrame:rect];
    [l setTitle:@"开始下载" forState:UIControlStateNormal];
    [l addTarget:self action:@selector(downloadURL:) forControlEvents:UIControlEventTouchUpInside];
    l.backgroundColor = [UIColor cyanColor];
    
    [self.view addSubview:l];
    
}

- (void)downloadURL:(id)sender
{
    //  get queue
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 3;
    for (int i = 0; i < 2; i++) {
        UIImageView *imageview3 = [[UIImageView alloc] initWithFrame:CGRectMake(100, i *(80 +50), 200, 200)];
        [_imageViewsArray addObject:imageview3];
        [self.view addSubview:imageview3];
        NSURL *url = [NSURL URLWithString:_imageUrlsArray[i]];
        DownloadOPr *downloader = [[DownloadOPr alloc] initWithUrl:url delegate:self];
        [queue addOperation:downloader];
}


    
#if 0
- (void)downloadURL:(id)sender
{
    dispatch_queue_t
    //   后台执行
    queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //  把任务加载到异步队列中执行
    dispatch_async(queue, ^{
#if 0
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manager GET:@"http://blog.csdn.net/hufengvip/article/details/8538047" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            NSString *responseString = [[NSString  alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSLog(@"responseString:%@", responseString);
        } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
            NSLog(@"error:%@",error);
        }];
#else
        NSString *responseString = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://blog.csdn.net/hufengvip/article/details/8538047"] encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"responstString:%@", responseString);
#endif
    });
   //       延迟3s执行(主线程执行)
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        NSLog(@"3秒钟后在主线程执行");
    });
    
    //  让后台两个程序并行执行再汇总结果
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"这是并行执行的第一个程序");
         //        return the main queue and show the image
        [self.imageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
        
        
    });
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"这是并行执行的第二个程序");
        //      return the main queue and show the image
        [self.imagView2 performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
    });
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"这是两个进程汇总的结果");
    });
    
    
}

////*********************** NSOPeration***********************************//////////////
#else
#if 0
- (void)downloadURL:(id)sender
{
    //  get queue
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    for (int i = 0; i < 5; i++) {
        UIImageView *imageview3 = [[UIImageView alloc] initWithFrame:CGRectMake(20, i *(50 +10), 100, 100)];
        [_imageViewsArray addObject:imageview3];
        [self.view addSubview:imageview3];
        NSURL *url = [NSURL URLWithString:_imageUrlsArray[i]];
        ImageDownlader *downloader = [[ImageDownlader alloc] initWithUrl:url delegate:self];
        [queue addOperation:downloader];
    }
    


    //  set the max task one time.
    queue.maxConcurrentOperationCount = 2;
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"Task 1");
            NSURL *urlstr = [NSURL URLWithString:@"http://yn.xinhuanet.com/ent/2015-08/25/134553023_14404735455561n.jpg"];
            NSData *data = [NSData dataWithContentsOfURL:urlstr];
            UIImage *image = [UIImage imageWithData:data];
            NSLog(@"图片下载完毕");
            //     return the main queue and show the image
            [self.imageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
        }
    }];
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"Task 2");
            NSURL *urlstr = [NSURL URLWithString:@"http://tse1.mm.bing.net/th?&id=OIP.M1f3742993139f6fcb52453357a2af60bo0&w=300&h=300&c=0&pid=1.9&rs=0&p=0"];
            NSData *data = [NSData dataWithContentsOfURL:urlstr];
            UIImage *image = [UIImage imageWithData:data];
            NSLog(@"图片下载完毕");
            //   return the main queue and show the image
            [self.imagView2 performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
        }
    }];
    
    //  在主队列执行时有等待就是同步（就可能发生死锁）
    [queue waitUntilAllOperationsAreFinished];
    NSLog(@"after add two operation");
#if 0
#pragma mark// 在其子类（NSBlockOperation）自定义
    NSBlockOperation *blkop1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"Task 3");
        
    }];
    //    同一个操作可以封装多个任务，并且也是并发执行。
    [blkop1 addExecutionBlock:^{
        NSLog(@"Task 4");
    }];
    
    [queue addOperation:blkop1];
    NSBlockOperation *blkop2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"Task 5");
    }];

    
    //  添加依赖关系，blkop1必须等blkop2执行完（不要通过优先级设置执行顺序，应该用依赖）
     [blkop1 addDependency:blkop2];
     NSArray *array = @[blkop1,blkop2];
     [queue addOperations:array waitUntilFinished:YES];
     [queue addOperation:blkop2];
}
#endif
    
    
#endif
    

   


#endif

}
- (void)didReceiveMemoryWarning {
    
    
    
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

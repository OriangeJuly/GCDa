//
//  DownloadOPr.h
//  GCDa
//
//  Created by apple on 15/10/6.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ImageDownloaderDelegate ;

@interface DownloadOPr : NSOperation
@property (nonatomic,strong) NSURL *Url;
@property (nonatomic,readonly,strong) UIImage *image;
@property (nonatomic,weak) id<ImageDownloaderDelegate>delegate;

- (instancetype) initWithUrl:(NSURL *)ImageUrl delegate:
(id<ImageDownloaderDelegate>)delegate;
@end




@protocol ImageDownloaderDelegate <NSObject>

- (void)imageDownloaderDidFinished:(DownloadOPr *)downlader;

@end





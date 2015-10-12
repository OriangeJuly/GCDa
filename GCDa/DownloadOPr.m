//
//  DownloadOPr.m
//  GCDa
//
//  Created by apple on 15/10/6.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "DownloadOPr.h"

@implementation DownloadOPr
- (instancetype) initWithUrl:(NSURL *)ImageUrl delegate:
  (id<ImageDownloaderDelegate>)delegate
{
    if (self = [super init]) {
        _Url = [ImageUrl copy];
        _delegate = delegate;
    }
    return  self;
}

- (void) main
{
    if (_Url == nil || _delegate == nil) {
        return;
    }
    NSData *data = [NSData dataWithContentsOfURL:_Url];
    if (data){
    _image = [UIImage imageWithData:data];
    }
    if (_delegate != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_delegate imageDownloaderDidFinished:self ];
        });
    }
}

@end

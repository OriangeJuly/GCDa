//
//  InfoNSOperation.h
//  GCDa
//
//  Created by apple on 15/10/6.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InfoNSOperation : NSOperation

@property (nonatomic,strong) NSArray *_blockarray;
- (void)addBlock:(void (^)(void))block;

@end

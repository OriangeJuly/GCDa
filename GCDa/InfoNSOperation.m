//
//  InfoNSOperation.m
//  GCDa
//
//  Created by apple on 15/10/6.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "InfoNSOperation.h"

@implementation InfoNSOperation
- (instancetype)init
{
    if (self = [super init]) {
        __blockarray = [NSMutableArray array];
    }
    return self;
}


- (void)main
{
    NSLog(@"First NSOperation");
    for (id block in __blockarray) {
        ((void(^)(void))block)();
    }
}


- (void)addBlock:(void (^)(void))block
{
    [(NSMutableArray *)__blockarray addObject:block];
}

@end

//
//  LSTimer.h
//  GCD-timer
//
//  Created by 中创 on 2019/11/28.
//  Copyright © 2019 中创慧谷. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSTimer : NSObject


/// 创建定时器
/// @param interval 定时器的时间间隔
/// @param waitTime 定时器持续时间  当小于等于0时定时器会一直持续下去
/// @param handler 每隔一段时间回调的方法
- (instancetype)initWithTimeInterval:(float)interval andWaitTime:(float)waitTime eventHandler:(void(^)(void))handler;
/// 为了好看的一个开始方法
- (void)start;
@end

NS_ASSUME_NONNULL_END

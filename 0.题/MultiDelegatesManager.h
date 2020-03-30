//
//  MultiDelegatesManager.h
//  0.题
//
//  Created by 中创 on 2020/3/30.
//  Copyright © 2020 LS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 协议
@protocol mutilDelegatesDelegate <NSObject>

- (void)doSomethings;

@end


@interface MultiDelegatesManager : NSObject

+ (instancetype)shareHelper;

@property (nonatomic, readonly, strong) NSPointerArray *delegates;
- (void)addDelegate:(id<mutilDelegatesDelegate>)delegate;
- (void)removeDelegate:(id<mutilDelegatesDelegate>)delegate;
- (void)sendMessage;

@end

NS_ASSUME_NONNULL_END

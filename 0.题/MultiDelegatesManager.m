//
//  MultiDelegatesManager.m
//  0.题
//
//  Created by 中创 on 2020/3/30.
//  Copyright © 2020 LS. All rights reserved.
//

#import "MultiDelegatesManager.h"

@interface MultiDelegatesManager ()<mutilDelegatesDelegate>

@end

@implementation MultiDelegatesManager

+ (instancetype)shareHelper{
    static MultiDelegatesManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MultiDelegatesManager alloc] init];
    });
    return manager;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        _delegates = [NSPointerArray weakObjectsPointerArray];
    }
    return self;
}

- (void)sendMessage{
    [self doSomethings];
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (signature) {
        return signature;
    }
    [_delegates compact]; // 遍历之前记得清除野指针
    for (id delegate in _delegates) {
        if (!delegate) {
            continue;
        }
        
        signature = [delegate methodSignatureForSelector:aSelector];
        if (signature) {
            break;
        }
    }
    return signature;
}
- (void)forwardInvocation:(NSInvocation *)anInvocation{
    SEL sel = [anInvocation selector];
    BOOL isRespond = NO;
    [_delegates compact];
    //遍历存储给个对象的代理，发送给每个要实现代理方法的对象
    for (id delegate in _delegates) {
        if (delegate && [delegate respondsToSelector:sel]) {
            [anInvocation invokeWithTarget:delegate]; // 发送方法
            isRespond = YES;
        }else{
            NSLog(@"%@没有响应代理方法...", delegate);
        }
    }
    if (!isRespond) {
        [self doesNotRecognizeSelector:sel]; // 未识别的方法抛异常，避免闪退
    }
}

- (void)addDelegate:(id<mutilDelegatesDelegate>)delegate{
    if (delegate && ![_delegates.allObjects containsObject:delegate]) {
        [_delegates addPointer:(__bridge void*)delegate];
    }
}
- (void)removeDelegate:(id<mutilDelegatesDelegate>)delegate{
    NSUInteger index = [self getIndexFormDelegates:delegate]; // 获取要删除代理的下标
    if (index == NSNotFound) {
        return;
    }
    [_delegates removePointerAtIndex:index];
    [_delegates compact]; // 移除数组的NULL指针
}
- (NSUInteger)getIndexFormDelegates:(id)delegate {
    
    for (NSUInteger i = 0; i < _delegates.count; i++) {
        id tempDelegate = [_delegates pointerAtIndex:i];
        if (tempDelegate == delegate) {
            return i;
        }
    }
    return NSNotFound;
}


@end

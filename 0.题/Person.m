//
//  Person.m
//  0.题
//
//  Created by 中创 on 2020/3/13.
//  Copyright © 2020 LS. All rights reserved.
//

#import "Person.h"

#import "ViewController.h"
#import "Animal.h"

@implementation Person

- (id)initWithAge:(NSString *)age{
    self = [super init];
    if (self) {
        self.age = age;
    }
    return self;
}
+ (id)perWithAge:(NSString *)age{
    Animal * a = [Animal new];
    return a;
}
+ (instancetype)person{
//    Person * p = [[self alloc] init];
//    return p;
    Animal * a = [Animal new];
    return a;
}

- (void)eat{
    NSLog(@"人吃...");
    if (self.block) {
        self.block();
    }
}
- (void)run1{
    for (NSInteger i = 0; i < 1000; i ++) {
        NSLog(@"%lu", i);
    }
}
- (void)run2{
    for (NSInteger i = 0; i < 1000; i ++) {
        NSLog(@"%lu", i);
    }
}

- (NSMutableArray *)mutableArray{
    if (_mutableArray == nil) {
        _mutableArray = [NSMutableArray array];
    }
    return _mutableArray;
}

- (void)dealloc{
    NSLog(@"人死了...");
}



/************************消息转发******************************/
// 快速消息转发
//- (id)forwardingTargetForSelector:(SEL)aSelector{
//    if (aSelector == @selector(sleep)) {
//        return [ViewController new];
//    }
//    return [super forwardingTargetForSelector:aSelector];
//}
// 完整消息转发
//- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
//    if (aSelector == @selector(sleep)) {
//        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
//    }
//    return [super methodSignatureForSelector:aSelector];
//}
//- (void)forwardInvocation:(NSInvocation *)anInvocation{
//    SEL sel = [anInvocation selector];
//    ViewController * vc = [ViewController new];
//    if ([vc respondsToSelector:sel]) {
//         [anInvocation invokeWithTarget:vc];
//    }
//    Animal * animal = [Animal new];
//    if ([animal respondsToSelector:sel]) {
//        [anInvocation invokeWithTarget:animal];
//    }
//    else{
//        [super forwardInvocation:anInvocation];
//    }
//
//}
// 抛出异常
//- (void)doesNotRecognizeSelector:(SEL)aSelector{
//    NSLog(@"%@不存在", NSStringFromSelector(aSelector));
//}


@end

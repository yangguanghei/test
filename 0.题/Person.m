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

- (void)eat{
    NSLog(@"人吃...");
    if (self.block) {
        self.block();
    }
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

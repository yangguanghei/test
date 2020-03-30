//
//  NSObject+AFCrashExtension.m
//  SolveCrashSDK
//
//  Created by sky on 2017/5/25.
//  Copyright © 2017年 Appfactory. All rights reserved.
//

#import "NSObject+AFCrashExtension.h"
#import <objc/runtime.h>
#import "SolveCrashHelp.h"
#import "SC_CrashMethodProxy.h"
#import <UIKit/UIKit.h>


@implementation NSObject (AFCrashExtension)

+ (void)becomeActive{
    //交换方法签名，用于解决doesNotRecognizeSelector的崩溃
    [SolveCrashHelp exchangeInstanceMethod:[self class] originMethodSel:@selector(methodSignatureForSelector:) replaceMethodSel:@selector(avoidCrashMethodSignatureForSelector:)];
    [SolveCrashHelp exchangeInstanceMethod:[self class] originMethodSel:@selector(forwardInvocation:) replaceMethodSel:@selector(avoidCrashforwardInvocation:)];
}

//找不到方法的崩溃
static char * haveSuperNSMethodSignature = "lc_haveSuperNSMethodSignature";

// methodSignatureForSelector
- (NSMethodSignature *)avoidCrashMethodSignatureForSelector:(SEL)aSelector{

    NSMethodSignature * supermethodSignature = [self avoidCrashMethodSignatureForSelector:aSelector];
    if (supermethodSignature) { // 有这个方法签名
        objc_setAssociatedObject(self, haveSuperNSMethodSignature, [NSNumber numberWithBool:YES], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return supermethodSignature;
    }else{  // 没有这个方法签名
        NSMethodSignature *methodSignature = [SC_CrashMethodProxy instanceMethodSignatureForSelector:@selector(proxyMethod)];
        objc_setAssociatedObject(self, haveSuperNSMethodSignature, [NSNumber numberWithBool:NO], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        if (methodSignature) {
            return methodSignature;
        }else{
            return nil;
        }
    }
}

// forwardInvocation
- (void)avoidCrashforwardInvocation:(NSInvocation *)anInvocation {
    
    NSNumber * flag = (NSNumber *)objc_getAssociatedObject(self, haveSuperNSMethodSignature);
    if (flag.boolValue) {
        [self avoidCrashforwardInvocation:anInvocation];
    }else{
        
#ifdef DEBUG
        NSString * str = NSStringFromSelector(anInvocation.selector);
        NSLog(@"😈😈😈😈😈😈😈😈%@方法不存在...", str);
#else
#endif
        
    }
}

@end

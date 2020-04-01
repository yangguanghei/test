//
//  Person.h
//  0.题
//
//  Created by 中创 on 2020/3/13.
//  Copyright © 2020 LS. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Animal;

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

//@property (nonatomic, assign) NSInteger age;
@property (nonatomic, copy) NSString * age;
@property (nonatomic, assign) Animal * animal;
@property (nonatomic, copy) void(^block)  (void);

- (void)eat;
- (void)run1;
- (void)run2;

@end

NS_ASSUME_NONNULL_END

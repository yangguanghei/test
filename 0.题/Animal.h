//
//  Animal.h
//  0.题
//
//  Created by 中创 on 2020/3/16.
//  Copyright © 2020 LS. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Animal : NSObject

@property (nonatomic, copy) NSString *  name;
@property (nonatomic, strong) Person *  p;

- (void)eat;

@end

NS_ASSUME_NONNULL_END

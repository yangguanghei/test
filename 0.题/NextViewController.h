//
//  NextViewController.h
//  0.题
//
//  Created by 梁森 on 2020/4/1.
//  Copyright © 2020 LS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NextViewController : UIViewController

@property (nonatomic, copy) void(^backBlock)  (NSString * str);

@end

NS_ASSUME_NONNULL_END

//
//  NextViewController.m
//  0.题
//
//  Created by 梁森 on 2020/4/1.
//  Copyright © 2020 LS. All rights reserved.
//

#import "NextViewController.h"

#import "Person.h"

@interface NextViewController ()

@property (nonatomic, strong) void(^block)  (void);
@property (nonatomic, strong) Person *  p;;
@property (nonatomic, strong) NSThread * thread;

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor yellowColor];
    

    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
    __weak typeof(self) weakSelf = self;
    self.block = ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"%@", [NSThread currentThread]);
            NSLog(@"%@", weakSelf);
        });

    };
    self.block();
}

- (void)dealloc{
    NSLog(@"NextViewController释放了...");
}


@end

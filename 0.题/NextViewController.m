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


@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor yellowColor];
    
//    __weak typeof(self) weakSelf = self;
//    self.block =^{
//        NSLog(@"%@", weakSelf);
//        sleep(10);
//        NSLog(@"%@", weakSelf);
//
//    };
    
//    self.p = [Person new];
//    self.p.block = ^{
//        NSLog(@"%@", self.p);
//    };
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self testWidePointer];
}
/// 测试野指针
- (void)testWidePointer{
  
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.backBlock) {
            self.backBlock(@"111");
        }
    });
}

- (void)testWeakStrong{
     Person * p = [Person new];
        __weak typeof(p) weakP = p;
        p.block = ^{
            NSLog(@"开始执行block...");
            sleep(5);
    //        __strong typeof(weakP) strongP = weakP;
    //        NSLog(@"%@", strongP);
            NSLog(@"block中的p:%@", weakP);
            [weakP run1];
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                [weakP run2];
            });
            NSLog(@"block中的p:%@", weakP);
        };
            
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            p.block();
        });
        sleep(3);
        NSLog(@"1---------------%@", p);
        p = nil;
        NSLog(@"2---------------%@", p);
}

- (void)dealloc{
    NSLog(@"%s", __func__);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  ViewController.m
//  0.题
//
//  Created by 中创 on 2020/3/13.
//  Copyright © 2020 LS. All rights reserved.
//

#import "ViewController.h"

#import "Person.h"
#import "Animal.h"
#import "Model.h"

#import "CustomView.h"

#import "MJExtension.h"
#import "MultiDelegatesManager.h"

#import "NextViewController.h"
#import "LSTimer.h"

int globalNum = 10;

@interface ViewController ()<mutilDelegatesDelegate>

@property (nonatomic, strong) Person * p;
@property (nonatomic, strong) Animal * animal;
@property (nonatomic, strong) NSArray * array;
@property (nonatomic, strong) NSMutableArray *  mutableArray;
@property (nonatomic, strong) NSTimer *  timer;;
@property (nonatomic, strong) LSTimer * gcdTimer;

@property (nonatomic, strong) NSObject *   name;
@property (nonatomic, strong) NSArray * testBlockArray;
@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"shouye ";
    
    self.view.backgroundColor = [UIColor greenColor];
    Animal * animal = [[Animal alloc] init];
    self.p.animal = animal;
    
    self.animal = [Animal new];
    self.animal.name = @"name1";
    [self testBlock];
    
    CustomView * yellowView = [[CustomView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:yellowView];
    yellowView.backgroundColor = [UIColor yellowColor];
    
    NSLog(@"self.view:%@", self.view);
}



- (void)sleep{
    NSLog(@"睡觉...");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    self.view = nil;
    
//    [self testWildPointer];
    
//    [self testForward];
    
//    [self testAssign];
    
//    [self testEventResponseChain];
    
//    [self testNavCDress];
    
//    block();
    
//    [self testStrong];
    
//    [self testDictToModel];
    
//    [self testArrayMethods];
    
//    [self testMultiDelegates];
    
    [self testNotification];
    
//    [self testInstancetypeAndid];
    
//    [self testTimer];
//    [self testAtomic];
    
}
// 测试atomic
- (void)testAtomic{
    for (NSInteger i = 0; i < 10000; i ++) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            self.animal = [Animal new];
        });
    }
}
/// 测试NSTimer
- (void)testTimer{

//    [[self gcdTimer] start];
    
    
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    
    
//    NSThread * thread = [[NSThread alloc] initWithTarget:self selector:@selector(startTimer) object:nil];
//    [thread start];
}
- (void)startTimer{
    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    [[NSRunLoop currentRunLoop] run];
}
- (void)updateTimer{
    NSLog(@"timer test");
    static NSInteger time = 0;
    time ++;
    if (time > 100) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    int count = 0;
    for (int i = 0; i < 1000000000; i++) {
    count += i;
    }
    
}

// 测试instancetype和id
- (void)testInstancetypeAndid{
    Person * p = [[Person alloc] initWithAge:@"11"];
    NSLog(@"年龄：%@", p.age);
    [[Person perWithAge:@"2"] run1];
    [[Person person] run1];
    
}

// 测试通知同步
- (void)testNotification{
    // 发送通知的线程和响应通知的线程是同一个线程
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"发送通知时的当前线程：%@", [NSThread currentThread]);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"testNotification" object:nil userInfo:nil];
    });
    NSLog(@"2222");
}

// 测试多代理
- (void)testMultiDelegates{
    
    Person * p = [Person new];
    __weak Person * weakP = p;
//    NSLog(@"weakP:%p", weakP);
//    NSLog(@"p:%p", p);
    [self.mutableArray addObject:weakP];
    
    p.block = ^{
        NSLog(@"%@", weakP.age);
    };
    [p eat];
    
    NextViewController * nextVC = [NextViewController new];
    [self presentViewController:nextVC animated:YES completion:nil];
    
    [[MultiDelegatesManager shareHelper] addDelegate:self];
    [[MultiDelegatesManager shareHelper] sendMessage];
}
// 代理方法
- (void)doSomethings{
    NSLog(@"多代理模式下通过消息转发实现代理方法。。。");
}

// 测试数组方法
- (void)testArrayMethods{
    NSArray * pers = @[[Person new], [Person new], [Person new]];
    [pers makeObjectsPerformSelector:@selector(eat)];
}

// 测试字典转模型的nsinteger类型
- (void)testDictToModel{
    NSMutableDictionary * mutableDict = [NSMutableDictionary dictionary];
    mutableDict[@"age"] = [NSNull new];
    NSLog(@"mutableDict:%@", mutableDict[@"age"]);
    Model * m = [Model mj_objectWithKeyValues:mutableDict];
    NSLog(@"age:%lu", m.age);
}

// 测试strong修饰不可变对象
- (void)testStrong{
    NSMutableArray * mutableArray = [NSMutableArray arrayWithArray:@[@"1", @"2"]];
    self.array = mutableArray;
    [mutableArray addObject:@"3"];
    NSLog(@"array:%@", self.array);
    NSLog(@"array:       %p", self.array);
    NSLog(@"mutableArray:%p", mutableArray);
}
// 测试block
- (void)testBlock{
    [self test];
    
    // 带有参数以及返回值的block
    int(^block)(int, int) = ^(int a, int b){
        if (a > b) {
            return a;
        }else {
            return  b;
        }
    };
    
    int num = block(1, 2);
    NSLog(@"num:%d", num);
    
    Animal * a = [Animal new];
    void(^testblock)(void) = ^{
        NSLog(@"a:%@", a);
    };
    [self func:testblock];
    
    [self func:^{
        NSLog(@"a:%@", a);
    }];
}
- (void)func:(void(^)(void))complete{
    NSLog(@"complete:%@", [complete class]);
}

void(^block)(void);
- (void)test{
    int age = 10;
     Person * p = [Person new];
    p.age = @"1";
    
    
    __block NSMutableArray * testArray = [NSMutableArray array];
    [testArray addObject:@"1"];
    
    p.dataSource = testArray;
    
    block = ^{  // 栈block
        p.age = @"3";   // 可以修改一个对象的成员变量
        NSArray * array = @[@"1", @"2"];
        self.testBlockArray = [NSArray arrayWithArray:array];
//        testArray = [NSMutableArray arrayWithArray:array];

        testArray = [NSMutableArray arrayWithArray:array];
        NSLog(@"%@", testArray);
        globalNum = 4;
    };
    
    p.age = @"2";
    self.animal.name = @"改变了..";
    block();
    
    [testArray addObject:@"3"];
    NSLog(@"%@", testArray);
    
    NSLog(@"p.age:%@", p.age);
//    block = [^{ // 堆block
//        NSLog(@"age:%d", age);
//    } copy];
    NSLog(@"block类型：%@", [block class]);
}

// 测试navigationController地址
- (void)testNavCDress{
    NSLog(@"%s:nav:%p",__func__, self.navigationController);
}
// 事件响应链
- (void)testEventResponseChain{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(100, 100, 100, 100);
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [btn addSubview:imageView];
    imageView.backgroundColor = [UIColor yellowColor];
    
}
- (void)clickBtn{
    NSLog(@"点击按钮按.....");
}

// 测试assign修饰对象
- (void)testAssign{
    [self.p.animal eat];
}

// 测试消息转发
- (void)testForward{
    [self.p performSelector:@selector(sleep)];
}
// 测试野指针
- (void)testWildPointer{
    
    NextViewController * nextVC = [NextViewController new];
    [self presentViewController:nextVC animated:YES completion:nil];
    nextVC.backBlock = ^(NSString * _Nonnull str) {
        NSLog(@"str:%@", str);
    };
    
}
- (void)click{
    NSLog(@"%s", __func__);
}
#pragma mark --- 懒加载
- (LSTimer *)gcdTimer{
    if (_gcdTimer == nil) {
        _gcdTimer = [[LSTimer alloc] initWithTimeInterval:1.0 andWaitTime:0 eventHandler:^{
            [self updateTimer];
        }];
    }
    return _gcdTimer;
}
- (NSMutableArray *)mutableArray{
    if (_mutableArray == nil) {
        _mutableArray = [NSMutableArray array];
    }
    return _mutableArray;
}
- (Person *)p{
    if (_p == nil) {
        _p = [Person new];
    }
    return _p;
}
- (Animal *)animal{
    if (_animal == nil) {
        _animal = [Animal new];
    }
    return _animal;
}

- (void)dealloc{
    NSLog(@"%s", __func__);
}

@end

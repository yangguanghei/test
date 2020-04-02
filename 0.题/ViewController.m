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

@interface ViewController ()<mutilDelegatesDelegate>

@property (nonatomic, strong) Person * p;
@property (nonatomic, strong) Animal * animal;
@property (nonatomic, strong) NSArray * array;
@property (nonatomic, strong) NSMutableArray * mutableArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"shouye ";
    
    self.view.backgroundColor = [UIColor greenColor];
    Animal * animal = [[Animal alloc] init];
    self.p.animal = animal;
    
    [self testBlock];
    
    CustomView * yellowView = [[CustomView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:yellowView];
    yellowView.backgroundColor = [UIColor yellowColor];
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
    
    [self testMultiDelegates];
    
//    [self testNotification];
    
}

// 测试通知同步
- (void)testNotification{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"当前线程：%@", [NSThread currentThread]);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"testNotification" object:nil userInfo:nil];
    });
    NSLog(@"2222");
}

// 测试多代理
- (void)testMultiDelegates{
    
    Person * p = [Person new];
     __weak typeof(p)weakPerson = p;
    
//    [self.mutableArray addObject:weakPerson];
    
    p.block = ^{
        __strong typeof(weakPerson) strongP = weakPerson;
//        NSLog(@"age:%@", p.age);
        NSLog(@"age:%@", strongP.age);
//        NSLog(@"age:%@", weakPerson.age);
        sleep(3);
        NSLog(@"睡眠结束");
    };
    [weakPerson eat];
    
    NSLog(@"1p:%@", p);
    self.array = [NSArray arrayWithObjects:p, nil];
    for (Person * p in self.array) {
        NSLog(@"2p:%@", p);
    }
    
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
}

void(^block)(void);
- (void)test{
    int age = 10;
     Person * p = [Person new];
    p.age = @"1";
    block = ^{  // 栈block
        NSLog(@"age:%d", age);
        p.age = @"2";
//        p = [Person new];
        NSLog(@"%@", p.age);
    };
    block();
    NSLog(@"%@", p.age);
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
//    NSLog(@"%s", __func__);
//    [self.p eat];
    
    UIButton * view1 = [UIButton new];
    [self.view addSubview:view1];
//    [view1 release];
//    view1 = nil;
    
    UIView * view2 = [UIView new];
    [view1 addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];;
    [self.view addSubview:view2];
}
- (void)click{
    NSLog(@"%s", __func__);
}
#pragma mark --- 懒加载
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

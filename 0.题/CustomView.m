//
//  CustomView.m
//  0.题
//
//  Created by 中创 on 2020/3/26.
//  Copyright © 2020 LS. All rights reserved.
//

#import "CustomView.h"

#import "CustomButton.h"

static CustomView * cv;

@interface CustomView ()

@property (nonatomic, strong) CustomButton * btn;

@end

@implementation CustomView


+ (instancetype)shareCustomView{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cv = [[CustomView alloc] init];
    });
    return cv;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setSubViews];
    }
    return self;
}
- (void)setSubViews{
    
//    UIView * blackview = [[UIView alloc] initWithFrame:self.bounds];
//    blackview.backgroundColor = [UIColor blackColor];
//    [self addSubview:blackview];
    
    CustomButton * btn = [[CustomButton alloc] initWithFrame:CGRectMake(50, 0, 100, 100)];
    [self addSubview:btn];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
    self.btn = btn;
}

- (void)clickBtn{
    NSLog(@"点击按钮...");
}


//为什么会调用两次?


// 响应事件的视图
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    CGPoint newPoint = [self convertPoint:point toView:self.btn];
    if ([self.btn pointInside:newPoint withEvent:event]) {  // 点击点在按钮上
        return self.btn;
    }else{
        return [super hitTest:point withEvent:event];
    }
    
//    UIView * view = [super hitTest:point withEvent:event];
//    NSLog(@"%@", view);
//    return view;
}

// 点击点是否在响应视图上
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    BOOL boo = [super pointInside:point withEvent:event];
    NSLog(@"%d", boo);
    return boo;
}
@end

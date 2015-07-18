//
//  HitTestView.m
//  gcd_test
//
//  Created by 赵远 on 15/7/12.
//  Copyright (c) 2015年 赵远. All rights reserved.
//

#import "HitTestView.h"
#import <objc/runtime.h>

@implementation HitTestView

@dynamic testString;

void sayHello(id self, SEL _cmd)
{ NSLog(@"Hello"); }

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame) / 2);
        button.tag = 10001;
        button.backgroundColor = [UIColor grayColor];
        [button setTitle:@"Button1" forState:UIControlStateNormal];
        [self addSubview:button];
        [button addTarget:self action:@selector(_buttonActionFired:) forControlEvents:UIControlEventTouchDown];
        
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];
        [self addSubview:lable];
        
        UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        button2.frame = CGRectMake(0, CGRectGetHeight(frame) / 2, CGRectGetWidth(frame), CGRectGetHeight(frame) / 2);
        button2.tag = 10002;
        button2.backgroundColor = [UIColor darkGrayColor];
        [button2 setTitle:@"Button2" forState:UIControlStateNormal];
        [self addSubview:button2];
        [button2 addTarget:self action:@selector(sayHello) forControlEvents:UIControlEventTouchDown];
        
        Class cls = [self class];
        SEL selector = NSSelectorFromString(@"sayHello");

        class_addMethod(cls, selector, (IMP)sayHello, "v@:");
    }
    return self;
}

- (void)_buttonActionFired:(UIButton *)button {
    NSLog(@"=====Button Titled %@ ActionFired", [button titleForState:UIControlStateNormal]);
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitView = [super hitTest:point withEvent:event];
    NSLog(@"%@",[NSNumber valueWithCGPoint:point]);
    if (hitView == [self viewWithTag:10001] && point.y > 60) {
        return [self viewWithTag:10002];
    }
    return hitView;
}



+(BOOL)resolveInstanceMethod:(SEL)sel{
    if (sel == @selector(setTestString:) ) {
         class_addMethod([self class], sel, (IMP)sayHello, "v@:");
        return YES;
    }

    return [super resolveInstanceMethod:sel];
}
@end

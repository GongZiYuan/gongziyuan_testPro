//
//  MycontentScrollView.m
//  gongziyuan_test
//
//  Created by 赵远 on 15/4/10.
//  Copyright (c) 2015年 赵远. All rights reserved.
//

#import "MycontentScrollView.h"

@implementation MycontentScrollView

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
//    if (self.contentOffset.y >= self.contentSize.height - self.frame.size.height) {
//        return _currentView;
//    }else{
//        return self;
//    }
    
    UIView *result = [super hitTest:point withEvent:event];
//    if (result == self) {
        if (self.contentOffset.y >= 200) {
            return _currentView;
        }else if (((UIScrollView*)_currentView).contentOffset.y <= 0){
            return  self;
        }
    return  self;
//    }
//    CGPoint buttonPoint = [_currentView convertPoint:point fromView:self];
//    if ([_currentView pointInside:buttonPoint withEvent:event]) {
//        return _currentView;
//    }
    return result;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  MainViewController.m
//  gongziyuan_test
//
//  Created by 赵远 on 15/4/2.
//  Copyright (c) 2015年 赵远. All rights reserved.
//

#import "MainViewController.h"
#import "MycontentScrollView.h"
#import <QuartzCore/QuartzCore.h>
#import "MyView.h"

#define degreesToRadians(x) (M_PI*(x)/180.0) //把角度转换成PI的方式
#define  PROGREESS_WIDTH 80 //圆直径
#define PROGRESS_LINE_WIDTH 4 //弧线的宽度

@interface MainViewController (){
   IBOutlet UIScrollView *_contentScrollView;
   IBOutlet UITextField *_textField;
   MycontentScrollView *_contentScroll;
    UIButton *_clickBtn;
    
    CAShapeLayer *_trackLayer, *_progressLayer;
}
@property (nonatomic, strong)  UIView *layerView;
@property (nonatomic, strong)  CALayer *colorLayer;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MyView *myView = [[MyView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:myView];
    //    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(150, 150, 80, 80)];
//    imageView.image = [UIImage imageNamed:@"upgrade_waiting"];
//    [self.view addSubview:imageView];
//    
//    self.colorLayer = [CALayer layer];
//    self.colorLayer.contents = (__bridge id)[UIImage imageNamed:@"upgrade_arrow"].CGImage;
//    self.colorLayer.frame = CGRectMake(0, 80, 80.0f, 80.0f);
//    [imageView.layer addSublayer:self.colorLayer];
//    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
//    self.colorLayer.position = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2);
//    
//    CATransition *transition = [CATransition animation];
//    transition.type = kCATransitionPush;
//    transition.subtype = kCATransitionFromLeft;
//    self.colorLayer.actions = @{@"backgroundColor": transition};
//    //add it to our view
//    
//    //add it to our view
//    _layerView = [[UIView alloc] initWithFrame:self.view.bounds];
//    [self.layerView.layer addSublayer:self.colorLayer];
    
    _clickBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [_clickBtn setTitle:@"changeColor" forState:UIControlStateNormal];
    [_clickBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_clickBtn addTarget:self action:@selector(changeColor) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_clickBtn];
//    [self.view addSubview:self.layerView];
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}


-(void)setPercent:(NSInteger)percent animated:(BOOL)animated
{
    [CATransaction begin];
    [CATransaction setDisableActions:!animated];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [CATransaction setAnimationDuration:0.25];
    _progressLayer.strokeEnd = percent/100.0;
    [CATransaction commit];
    
}

- (IBAction)changeColor
{
    //randomize the layer background color
    //begin a new transaction
//    [CATransaction begin];
//    //set the animation duration to 1 second
//    [CATransaction setAnimationDuration:1.0];
//    //add the spin animation on completion
//    [CATransaction setCompletionBlock:^{
//        //rotate the layer 90 degrees
//        CGAffineTransform transform = self.colorLayer.affineTransform;
//        transform = CGAffineTransformRotate(transform, M_PI_2/2);
//        self.colorLayer.affineTransform = transform;
//    }];
//    self.colorLayer.backgroundColor = [UIColor redColor].CGColor;
//     [CATransaction commit];
    
//    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
//    animation.keyPath = @"position";
//    animation.duration = 1;
//    animation.values = @[
//                         [NSValue valueWithCGPoint:CGPointMake(40, 80)],
//                         [NSValue valueWithCGPoint:CGPointMake(40, 30)],
//                         [NSValue valueWithCGPoint:CGPointMake(40, -80)]];
//    animation.repeatCount = MAXFLOAT;
//    animation.keyTimes = @[
//                           @(0.0),
//                           @(0.5),
//                           @(0.9),
//                           @(1.0)];
//    //apply animation to layer
//    
//    [self.colorLayer addAnimation:animation forKey:nil];
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //get the touch point
    CGPoint point = [[touches anyObject] locationInView:self.view];
    //check if we've tapped the moving layer
    if ([self.colorLayer.presentationLayer hitTest:point]) {
        //randomize the layer background color
        CGFloat red = arc4random() / (CGFloat)INT_MAX;
        CGFloat green = arc4random() / (CGFloat)INT_MAX;
        CGFloat blue = arc4random() / (CGFloat)INT_MAX;
        self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    } else {
        //otherwise (slowly) move the layer to new position
        [CATransaction begin];
        [CATransaction setAnimationDuration:4.0];
        self.colorLayer.position = point;
        [CATransaction commit];
    }
}

#pragma mark -- 键盘隐藏，显示
- (void)keyboardWillShow:(NSNotification *)aNotification{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo]; //userinfo
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
  
    _contentScrollView.contentInset = UIEdgeInsetsMake(0, 0, keyboardRect.size.height, 0);
    
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification{
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    _contentScrollView.contentInset = UIEdgeInsetsMake(0, 0, keyboardRect.size.height, 0);
  
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

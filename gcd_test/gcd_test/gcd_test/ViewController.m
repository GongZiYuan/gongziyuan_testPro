//
//  ViewController.m
//  gcd_test
//
//  Created by 赵远 on 15/6/15.
//  Copyright (c) 2015年 赵远. All rights reserved.
//

#import "ViewController.h"
#import "HashTable.h"
#import <AdSupport/ASIdentifierManager.h>
#import "HitTestView.h"

@interface ViewController (){
    UILabel *testLab1;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(200, 40, 40, 40)];
    btn.backgroundColor = [UIColor blueColor];
    [btn addTarget:self action:@selector(hashTest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    testLab1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 100, 30)];
    testLab1.text = @"change_no";
    [self.view addSubview:testLab1];
    
    HitTestView *hitView = [[HitTestView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    [self.view addSubview:hitView];
    hitView.testString = @"test";
//    [self test1];
}

- (NSString *)adIdfaSupport{
    NSString *idfaString = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    return idfaString;
}

-(void)hashTest{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"idfa是：" message:[self adIdfaSupport] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    
    [alert show];
    
//    HashTable *hashTable = [[HashTable alloc] init];
//    NSArray *dataArray = @[@"12",@"67",@"56",@"16",@"25",@"37",@"22",@"29",@"15",@"47",@"48",@"34"];
//    hashTable.count = dataArray.count;
//    for (NSString *s in dataArray) {
//        [hashTable insertHashTable:s];
//    }
//    
//    [hashTable searchHashTable:@"39"];
//    
//    for (NSString *s in dataArray) {
//        [hashTable searchHashTable:s];
//    }
    
}
-(void)test1{
    testLab1.text = @"change_no";
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //
        int j = 0;
    
        
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSLog(@"我执行了！");
        });
        
        
        for (int i = 0; i < 10; i ++) {
            j = i;
            NSLog(@"%i",j);
        }
        
        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            //
//            testLab1.text = @"had_change";
//        });
    });
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        //
//        testLab1.text = @"had_change";
//    });
    NSLog(@"我执行了le！");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

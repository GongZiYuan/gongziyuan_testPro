//
//  HashTable.h
//  gcd_test
//
//  Created by 赵远 on 15/7/6.
//  Copyright (c) 2015年 赵远. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HashTable : NSObject

@property (nonatomic, assign) int count;
@property (nonatomic, strong) NSMutableArray *countArray;


-(void)insertHashTable:(NSString*)value;
-(void)searchHashTable:(NSString*)value;
@end

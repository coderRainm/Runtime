//
//  Person.h
//  04_Ivar&Method
//
//  Created by CXY on 16/8/11.
//  Copyright © 2016年 aicai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger age;

- (void)eat;
- (void)sleep;
@end

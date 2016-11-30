//
//  Person.m
//  04_Ivar&Method
//
//  Created by CXY on 16/8/11.
//  Copyright © 2016年 aicai. All rights reserved.
//

#import "Person.h"

@implementation Person
- (NSString *)description {
    return self.name;
}

- (void)eat {
    NSLog(@"%@ are eating!", self);
}

- (void)sleep {
    NSLog(@"%@ are sleeping!", self);
}
@end

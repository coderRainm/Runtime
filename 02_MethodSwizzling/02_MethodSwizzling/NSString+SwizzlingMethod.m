//
//  NSString+SwizzlingMethod.m
//  02_MethodSwizzling
//
//  Created by CXY on 16/4/22.
//  Copyright © 2016年 aicai. All rights reserved.
//

#import "NSString+SwizzlingMethod.h"

@implementation NSString (SwizzlingMethod)
- (NSString *)swizzlingMethod
{
    NSString *lowercase = [self swizzlingMethod];
    NSLog(@"%@ => %@", self, lowercase);
    return lowercase;
}
@end

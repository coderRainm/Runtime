//
//  main.m
//  02_MethodSwizzling
//
//  Created by CXY on 16/4/22.
//  Copyright © 2016年 aicai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "NSString+SwizzlingMethod.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //test1
        /*{
            Method originalMethod = class_getInstanceMethod([NSString class], @selector(lowercaseString));
            Method swappedMethod = class_getInstanceMethod([NSString class], @selector(uppercaseString));
            method_exchangeImplementations(originalMethod, swappedMethod);
            NSString *string = @"ThIs iS tHe StRiNg";
            NSString *lowercaseString = [string lowercaseString];
            NSLog(@"lowercaseString = %@", lowercaseString);
        }*/
        //test2
        {
            Method originalMethod = class_getInstanceMethod([NSString class], @selector(lowercaseString));
            Method swappedMethod = class_getInstanceMethod([NSString class], @selector(swizzlingMethod));
            method_exchangeImplementations(originalMethod, swappedMethod);
        }
    }
    return 0;
}

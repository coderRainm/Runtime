//
//  main.m
//  03_Dynamic_Method_Resolution&Message_Forwarding
//
//  Created by CXY on 16/7/12.
//  Copyright © 2016年 aicai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Person * p = [Person new];
        [p eat];
        [p say:@"hello world"];
    }
    return 0;
}

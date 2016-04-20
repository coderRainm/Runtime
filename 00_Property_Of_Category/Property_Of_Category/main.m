//
//  main.m
//  Property_Of_Category
//
//  Created by CXY on 16/4/13.
//  Copyright © 2016年 aicai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person+MoreProperty.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Person *person = [Person new];
        person.name = @"ellon";
        person.address = @"shen zhen, China";//分类直接添加方法编译通过，运行时报错-[Person setAddress:]: unrecognized selector sent to instance，那么问题来了，如何为分类添加实例变量（分类中可以添加属性，但不可以合成相应的实例变量）？？？利用Associated Objects可以轻松办到。
    }
    return 0;
}

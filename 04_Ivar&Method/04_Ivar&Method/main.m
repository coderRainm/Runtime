//
//  main.m
//  04_Ivar&Method
//
//  Created by CXY on 16/8/11.
//  Copyright © 2016年 aicai. All rights reserved.
//

#include <stdio.h>
#import "Person.h"
#import <objc/runtime.h>
#import <Foundation/Foundation.h>

//1.修改实例变量值
void changeInstanceVariableValue() {
    Person *person = [Person new];
    person.name = @"Tom";
    NSLog(@"name==%@", person.name);
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([person class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *varName = ivar_getName(ivar);
        NSString *name = [NSString stringWithUTF8String:varName];
        if ([name isEqualToString:@"_name"]) {
            object_setIvar(person, ivar, @"Jerry");
            break;
        }
    }
    NSLog(@"修改后 name==%@", person.name);
}

//c形式的函数，必须有两个指定参数(id self,SEL _cmd)，参考oc runtime 消息（message）
void run(id self, SEL _cmd) {
    NSLog(@"%@ is running!", self);
}

//2.添加方法
//"v@:" 表示函数类型，v代表无返回值void，如果是i则代表int；@代表 id sel; : 代表 SEL _cmd;
void addMethod() {
    class_addMethod([Person class], @selector(run), (IMP)run, "v@:");
    Person *person = [Person new];
    person.name = @"Tom";
    //    [p run];
    [person performSelector:@selector(run)];
}

//3.交换方法实现
void exchangeMethodImplementation() {
    Method eatMethod = class_getInstanceMethod([Person class], @selector(eat));
    Method sleepMethod = class_getInstanceMethod([Person class], @selector(sleep));
    method_exchangeImplementations(eatMethod, sleepMethod);
    Person *person = [Person new];
    person.name = @"Tom";
    [person eat];
    [person sleep];
}

int main(int argc, const char * argv[]) {

//    changeInstanceVariableValue();
//    addMethod();
    exchangeMethodImplementation();
    return 0;
}



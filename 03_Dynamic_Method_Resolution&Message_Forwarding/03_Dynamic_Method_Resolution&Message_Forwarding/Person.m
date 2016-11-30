//
//  Person.m
//  03_Dynamic_Method_Resolution&Message_Forwarding
//
//  Created by CXY on 16/7/12.
//  Copyright © 2016年 aicai. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>
#import "Mobile.h"

@implementation Person
- (void)eat {
    NSLog(@"eat");
}

//1.resolveInstanceMethod:
/* c形式
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(say:)) {
        class_addMethod([self class], sel, (IMP)say, "v@:*");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

void say(id self, SEL _cmd, NSString *str) {
    NSLog(@"Person say:%@", str);
}

//OC形式
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(say:)) {
        class_addMethod([self class], sel, class_getMethodImplementation([self class], @selector(sayMethodIMP:)), "v@:*");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

- (void)sayMethodIMP:(NSString *)str {
    NSLog(@"Person say:%@", str);
}*/

//2.forwardingTargetForSelector
/*
- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (aSelector == @selector(say:)) {
        return [Mobile new];
    }
    return [super forwardingTargetForSelector:aSelector];
}*/

//3.forwardInvocation
//methodSignatureForSelector用来生成方法签名，这个签名就是给forwardInvocation中的参数NSInvocation调用的。
//
//开头我们要找的错误unrecognized selector sent to instance原因，原来就是因为methodSignatureForSelector这个方法中，由于没有找到say:对应的实现方法，所以返回了一个空的方法签名，最终导致程序报错崩溃。
//
//所以我们需要做的是自己新建方法签名，再在forwardInvocation中用你要转发的那个对象调用这个对应的签名，这样也实现了消息转发。

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if (aSelector == @selector(say:)) {
        return [NSMethodSignature signatureWithObjCTypes:"V@:*"];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL selector = [anInvocation selector];
    Mobile *mobile = [Mobile new];
    if ([mobile respondsToSelector:selector]) {
        [anInvocation invokeWithTarget:mobile];
    }
}

@end

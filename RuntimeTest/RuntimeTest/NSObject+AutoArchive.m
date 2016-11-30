//
//  NSObject+AutoArchive.m
//  RuntimeTest
//
//  Created by CXY on 16/6/29.
//  Copyright © 2016年 AiCai. All rights reserved.
//

#import "NSObject+AutoArchive.h"
#import <objc/runtime.h>

@implementation NSObject (AutoArchive)

- (NSArray *)ignoredPropertyNames {
    return nil;
}

- (void)encode:(NSCoder *)aCoder {
    // 一层层父类往上查找，对父类的属性执行归解档方法
    Class c = self.class;
    while (c &&c != [NSObject class]) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; ++i) {
            Ivar ivar = ivars[i];
            NSString *ivarName = [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
            if ([self respondsToSelector:@selector(ignoredPropertyNames)]) {
                if ([[self ignoredPropertyNames] containsObject:ivarName]) {
                    continue;
                }
            }
            //        ivarName = [ivarName substringFromIndex:1];
            id value = [self valueForKey:ivarName];
            [aCoder encodeObject:value forKey:ivarName];
        }
        free(ivars);
        c = [c superclass];
    }
}

- (void)decode:(NSCoder *)aDecoder {
    // 一层层父类往上查找，对父类的属性执行归解档方法
    Class c = self.class;
    while (c &&c != [NSObject class]) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; ++i) {
            Ivar ivar = ivars[i];
            NSString *ivarName = [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
            if ([self respondsToSelector:@selector(ignoredPropertyNames)]) {
                if ([[self ignoredPropertyNames] containsObject:ivarName]) {
                    continue;
                }
            }
            //        ivarName = [ivarName substringFromIndex:1];
            id value = [aDecoder decodeObjectForKey:ivarName];
            [self setValue:value forKey:ivarName];
        }

        free(ivars);
        c = [c superclass];
    }
}
@end

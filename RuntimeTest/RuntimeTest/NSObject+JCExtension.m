//
//  NSObject+JCExtension.m
//  RuntimeTest
//
//  Created by CXY on 16/6/29.
//  Copyright © 2016年 aicai. All rights reserved.
//

#import "NSObject+JCExtension.h"
#import <objc/runtime.h>

@implementation NSObject (JCExtension)

/*//第一种情况
- (void)setDict:(NSDictionary *)dict {
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; ++i) {
        Ivar ivar = ivars[i];
        NSString *ivarName = [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
        // 成员变量名转为属性名（去掉下划线 _ ）
        ivarName = [ivarName substringFromIndex:1];
        // 取出字典的值
        id value = [dict objectForKey:ivarName];
        if (!value) {//取值为nil时，直接跳过
            continue;
        }//kvc赋值
        [self setValue:value forKey:ivarName];
    }
    free(ivars);
}*/

/*//第二种情况
- (void)setDict:(NSDictionary *)dict {
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; ++i) {
        Ivar ivar = ivars[i];
        NSString *ivarName = [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
        // 成员变量名转为属性名（去掉下划线 _ ）
        ivarName = [ivarName substringFromIndex:1];
        // 取出字典的值
        id value = [dict objectForKey:ivarName];
        if (!value) {//取值为nil时，直接跳过
            continue;
        }
        // 获得成员变量的类型
        NSString *ivarType = [NSString stringWithCString:ivar_getTypeEncoding(ivar) encoding:NSUTF8StringEncoding];
        if ([ivarType hasPrefix:@"@"]) { //是对象
            ivarType = [ivarType substringWithRange:NSMakeRange(2, ivarType.length-3)]; //@"Person"----->Person
            if (![ivarType hasPrefix:@"NS"]) {//去除NS类
                Class class = NSClassFromString(ivarType);
                value =  [class objectWithDict:value];
            }
        }
        //kvc赋值
        [self setValue:value forKey:ivarName];
    }
    free(ivars);
}*/

- (NSString *)objectClassName {
    return nil;
}

//第三种情况是模型的属性是一个数组，数组中是一个个模型对象,对象类型未知，调用objectClassName方法获取对象类型，然后递归创建对象类型，加入数组中，最后赋值给外层模型的数组属性
- (void)setDict:(NSDictionary *)dict {
    if (!dict) return;
    Class c = self.class;
    while (c &&c != [NSObject class]) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList(c, &count);
        for (int i = 0; i < count; ++i) {
            Ivar ivar = ivars[i];
            NSString *ivarName = [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
            // 成员变量名转为属性名（去掉下划线 _ ）
            ivarName = [ivarName substringFromIndex:1];
            // 取出字典的值
            id value = [dict objectForKey:ivarName];
            if (!value) {//取值为nil时，直接跳过
                continue;
            }
            // 获得成员变量的类型
            NSString *ivarType = [NSString stringWithCString:ivar_getTypeEncoding(ivar) encoding:NSUTF8StringEncoding];
            if ([ivarType hasPrefix:@"@"]) { //是对象
                ivarType = [ivarType substringWithRange:NSMakeRange(2, ivarType.length-3)]; //@"Person"----->Person
                if (![ivarType hasPrefix:@"NS"]) {//去除NS类
                    Class class = NSClassFromString(ivarType);
                    value =  [class objectWithDict:value];
                } else if ([ivarType isEqualToString:@"NSArray"]) {//数组
                    if ([self respondsToSelector:@selector(objectClassName)]) {
                        NSString *objectClassName = [self objectClassName];
                        if (objectClassName) {
                            Class class = NSClassFromString(objectClassName);
                            NSMutableArray *arr = [NSMutableArray array];
                            for (id item in value) {
                                [arr addObject:[class objectWithDict:item]];
                            }
                            value = arr;
                        }
                    }
                } else if ([ivarType isEqualToString:@"NSString"]) {
                    if ([value isKindOfClass:[NSNumber class]]) {
                        value = [NSString stringWithFormat:@"%@", value];
                    }
                }
            }
            //kvc赋值
            [self setValue:value forKey:ivarName];
        }
        free(ivars);

        c = [c superclass];
    }
}


+ (instancetype )objectWithDict:(NSDictionary *)dict {
    NSObject *obj = [[self alloc]init];
    [obj setDict:dict];
    return obj;
}
@end

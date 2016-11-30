//
//  NSObject+AutoArchive.h
//  RuntimeTest
//
//  Created by CXY on 16/6/29.
//  Copyright © 2016年 AiCai. All rights reserved.
//

#import <Foundation/Foundation.h>

// 在系统方法内来调用我们的方法，将归解档两个方法封装为宏
#define  NSOBJECT_AUTOARCHIVE_METHOD(cls)\
@interface cls ()<NSCoding>\
@end\
@implementation cls\
- (instancetype)initWithCoder:(NSCoder *)aDecoder {\
    if (self = [super init]) {\
        [self decode:aDecoder];\
    }\
    return self;\
}\
- (void)encodeWithCoder:(NSCoder *)aCoder {\
    [self encode:aCoder];\
}\
@end\

@interface NSObject (AutoArchive)
//不需要归解档的属性数组
- (NSArray *)ignoredPropertyNames;
//Archiver
- (void)encode:(NSCoder *)aCoder;
//Unarchiver
- (void)decode:(NSCoder *)aDecoder;


@end

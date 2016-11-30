//
//  Person.m
//  RuntimeTest
//
//  Created by CXY on 16/6/30.
//  Copyright © 2016年 AiCai. All rights reserved.
//

#import "Person.h"
#import "NSObject+AutoArchive.h"


NSOBJECT_AUTOARCHIVE_METHOD(Person)
/*
 一般的写法,实现<NSCoding>协议方法
 - (instancetype)initWithCoder:(NSCoder *)aDecoder {
     if (self = [super init]) {
         _name = [aDecoder decodeObjectForKey:@"name"];
         _age = [aDecoder decodeIntegerForKey:@"age"];
         _height = [aDecoder decodeFloatForKey:@"height"];
         _width = [aDecoder decodeFloatForKey:@"width"];
     }
     return self;
 }
 
 - (void)encodeWithCoder:(NSCoder *)aCoder {
     [aCoder encodeObject:_name forKey:@"name"];
     [aCoder encodeInteger:_age forKey:@"age"];
     [aCoder encodeFloat:_height forKey:@"height"];
     [aCoder encodeFloat:_width forKey:@"width"];
 }
 */

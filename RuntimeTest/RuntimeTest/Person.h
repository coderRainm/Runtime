//
//  Person.h
//  RuntimeTest
//
//  Created by CXY on 16/6/30.
//  Copyright © 2016年 AiCai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property (copy, nonatomic) NSString *name;  ///< 名字
@property (assign, nonatomic) NSInteger age;  ///< 年龄
@property (assign, nonatomic) float height;  ///< 身高
@property (assign, nonatomic) float width;  ///< 体重
@end

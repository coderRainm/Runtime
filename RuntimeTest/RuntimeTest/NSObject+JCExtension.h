//
//  NSObject+JCExtension.h
//  RuntimeTest
//
//  Created by CXY on 16/6/29.
//  Copyright © 2016年 aicai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JCExtension)

- (void)setDict:(NSDictionary *)dict;

+ (instancetype )objectWithDict:(NSDictionary *)dict;

// 返回数组中都是什么类型的模型对象
- (NSString *)objectClassName;
@end

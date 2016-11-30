//
//  main.m
//  RuntimeTest
//
//  Created by CXY on 16/6/29.
//  Copyright © 2016年 aicai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"


void archive();
void unarchive();

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        archive();
        unarchive();
        
    }
    return 0;
}


void archive() {
    // 1.新建模型对象
    Person *p = [[Person alloc] init];
    p.name = @"Mike";
    p.age = 20;
    p.height = 1.65;
    p.width = 60;
    
    // 2.归档模型对象
    // 2.1.获得Documents的全路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    // 2.2.获得文件的全路径
    NSString *path = [doc stringByAppendingPathComponent:@"person.data"];
    // 2.3.将对象归档
    [NSKeyedArchiver archiveRootObject:p toFile:path];
}

void unarchive() {
    // 1.获得Documents的全路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    // 2.获得文件的全路径
    NSString *path = [doc stringByAppendingPathComponent:@"person.data"];
    // 3.从文件中读取MJStudent对象
    Person *p = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"%@ %li %f %f", p.name, p.age, p.height, p.width);
}

void testYESNO() {
    BOOL t;  t =4;
    
    if (t == YES) {
        
        NSLog(@"YES");
        
    }else{
        NSLog(@"%d", YES);
        NSLog(@"%d", NO);
        NSLog(@"NO");
        
    }
}
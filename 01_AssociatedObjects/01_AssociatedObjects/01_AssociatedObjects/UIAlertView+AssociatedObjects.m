//
//  UIAlertView+AssociatedObjects.m
//  01_AssociatedObjects
//
//  Created by CXY on 16/4/19.
//  Copyright © 2016年 aicai. All rights reserved.
//

#import "UIAlertView+AssociatedObjects.h"
#import <objc/runtime.h>

@implementation UIAlertView (AssociatedObjects)

- (void)setAssociatedObject:(id)associatedObject {
    objc_setAssociatedObject(self, @selector(associatedObject), associatedObject, OBJC_ASSOCIATION_RETAIN);
}

- (id)associatedObject {
    return objc_getAssociatedObject(self, _cmd);
}
@end

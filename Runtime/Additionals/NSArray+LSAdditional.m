//
//  NSArray+LSAdditional.m
//  Runtime
//
//  Created by jinzhong xu on 2017/7/4.
//  Copyright © 2017年 jinzhong xu. All rights reserved.
//

#import "NSArray+LSAdditional.h"

@implementation NSArray (LSAdditional)

+(void)load
{
    //NSArray
    Method objectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
    Method objectWithIndex = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectWithIndex:));
    method_exchangeImplementations(objectAtIndex, objectWithIndex);
    
//    //NSMutableArray
//    Method objectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(objectAtIndex:));
//    Method objectWithIndex = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(objectWithIndex:));
//    method_exchangeImplementations(objectAtIndex, objectWithIndex);
}

-(id)objectWithIndex:(NSUInteger)index
{
    if (index < self.count) {
        return [self objectWithIndex:index];
    }else{
        return nil;
    }
}


@end

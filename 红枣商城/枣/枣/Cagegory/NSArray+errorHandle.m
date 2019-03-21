//
//  NSArray+errorHandle.m
//  枣
//
//  Created by Comker on 2019/3/21.
//  Copyright © 2019 Comker. All rights reserved.
//

#import "NSArray+errorHandle.h"

@implementation NSArray (errorHandle)
/**
 *  防止数组越界
 */
- (id)objectAtIndexVerify:(NSUInteger)index{
    if (index < self.count) {
        return [self objectAtIndex:index];
    }else{
        return nil;
    }
}
/**
 *  防止数组越界
 */
- (id)objectAtIndexedSubscriptVerify:(NSUInteger)idx{
    if (idx < self.count) {
        return [self objectAtIndexedSubscript:idx];
    }else{
        return nil;
    }
}
@end

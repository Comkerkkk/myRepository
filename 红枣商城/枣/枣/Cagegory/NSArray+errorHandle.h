//
//  NSArray+errorHandle.h
//  枣
//
//  Created by Comker on 2019/3/21.
//  Copyright © 2019 Comker. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (errorHandle)
- (id)objectAtIndexVerify:(NSUInteger)index;
- (id)objectAtIndexedSubscriptVerify:(NSUInteger)idx;
@end

NS_ASSUME_NONNULL_END

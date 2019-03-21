//
//  TextHeightTool.h
//  枣
//
//  Created by Comker on 2019/3/21.
//  Copyright © 2019 Comker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface TextHeightTool : NSObject
+(CGFloat)contentHeightWithText:(NSString*)text textWidth:(CGFloat)width stringSize:(CGFloat)size;
@end

NS_ASSUME_NONNULL_END

//
//  TextHeightTool.m
//  枣
//
//  Created by Comker on 2019/3/21.
//  Copyright © 2019 Comker. All rights reserved.
//

#import "TextHeightTool.h"

@implementation TextHeightTool
+(CGFloat)contentHeightWithText:(NSString*)text textWidth:(CGFloat)width stringSize:(CGFloat)size{
    NSDictionary*textAttr=@{NSFontAttributeName:[UIFont systemFontOfSize:size]};
    CGSize maxSize=CGSizeMake(width, MAXFLOAT);
    CGFloat textH=[text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:textAttr context:nil].size.height;
    return  textH;
}
@end

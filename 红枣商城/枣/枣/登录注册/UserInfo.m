//
//  UserInfo.m
//  枣
//
//  Created by Comker on 2019/2/3.
//  Copyright © 2019 Comker. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo
+(instancetype)shareUserInfo{
    static UserInfo*_userInfo;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _userInfo=[self new];
    });
    return _userInfo;
}
@end

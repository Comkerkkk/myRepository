//
//  UserInfo.h
//  枣
//
//  Created by Comker on 2019/2/3.
//  Copyright © 2019 Comker. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfo : NSObject
@property (assign, nonatomic)int userID;
@property(nonatomic,strong)NSString*userName;
@property(nonatomic,assign)int credit;
@property(assign,nonatomic)float money;
+(instancetype)shareUserInfo;

@end

NS_ASSUME_NONNULL_END

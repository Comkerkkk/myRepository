//
//  TouchModel.h
//  枣
//
//  Created by Comker on 2019/2/11.
//  Copyright © 2019 Comker. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TouchModel : NSObject
@property(nonatomic,assign)int id;
@property(nonatomic,assign)int user_id;
@property(nonatomic,strong)NSString* addr;
@property(nonatomic,strong)NSString*name;
@property(nonatomic,strong)NSString*tel;
@end

NS_ASSUME_NONNULL_END

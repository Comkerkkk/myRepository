//
//  GiftModel.h
//  枣
//
//  Created by Comker on 2019/2/25.
//  Copyright © 2019 Comker. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GiftModel : NSObject
@property(nonatomic,assign)int id;
@property(nonatomic,strong)NSString*giftName;
@property(nonatomic,assign)int credit;
@property(nonatomic,strong)NSString*image;
@property(nonatomic,assign)int st;
@end

NS_ASSUME_NONNULL_END

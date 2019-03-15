//
//  OrderModel.h
//  枣
//
//  Created by Comker on 2019/2/21.
//  Copyright © 2019 Comker. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderModel : NSObject
@property(nonatomic,assign)int id;
@property(nonatomic,strong)NSString*shopName;
@property(nonatomic,strong)NSString*image;
@property(nonatomic,strong)NSString*num;
@property(nonatomic,strong)NSString*price;
@property(nonatomic,strong)NSString*addr;
@property(nonatomic,strong)NSString*name;
@property(nonatomic,strong)NSString*tel;
@end

NS_ASSUME_NONNULL_END

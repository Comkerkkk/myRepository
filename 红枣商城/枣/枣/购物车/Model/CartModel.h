//
//  CartModel.h
//  枣
//
//  Created by Comker on 2019/2/17.
//  Copyright © 2019 Comker. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CartModel : NSObject
@property(nonatomic,assign)int id;
@property(nonatomic,strong)NSString*shopName;
@property(nonatomic,assign)float price;
@property(nonatomic,strong)NSString*image;
@property(nonatomic,assign)NSInteger stock;
@property(nonatomic,assign)int user_id;
@property(nonatomic,assign)int shop_id;
@end

NS_ASSUME_NONNULL_END

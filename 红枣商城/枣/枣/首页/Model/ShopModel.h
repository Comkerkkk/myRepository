//
//  ShopModel.h
//  枣茬儿
//
//  Created by Comker on 2019/1/14.
//  Copyright © 2019 Comker. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShopModel : NSObject
@property(nonatomic,assign)int id;
@property(nonatomic,strong)NSString*shopName;
@property(nonatomic,assign)float price;
@property(nonatomic,assign)int stock;
@property(nonatomic,strong)NSString*image;
@property(nonatomic,strong)NSString*origin;
@property(nonatomic,assign)int grade;
@property(nonatomic,strong)NSString*des;

@end

NS_ASSUME_NONNULL_END

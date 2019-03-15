//
//  RecordModel.h
//  枣
//
//  Created by Comker on 2019/2/25.
//  Copyright © 2019 Comker. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RecordModel : NSObject
@property(nonatomic,assign)int id;
@property(nonatomic,strong)NSString*giftName;
@property(nonatomic,strong)NSString*image;
@property(nonatomic,strong)NSString*credit;
@property(nonatomic,strong)NSString*addr;
@property(nonatomic,strong)NSString*name;
@property(nonatomic,strong)NSString*tel;
@end

NS_ASSUME_NONNULL_END

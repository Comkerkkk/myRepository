//
//  NewsModel.h
//  枣
//
//  Created by Comker on 2019/2/23.
//  Copyright © 2019 Comker. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewsModel : NSObject
@property(nonatomic,assign)int id;
@property(nonatomic,strong)NSString* title;
@property(nonatomic,strong)NSString* content;
@property(nonatomic,strong)NSString* time;
@end

NS_ASSUME_NONNULL_END

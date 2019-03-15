//
//  NewsViewController.h
//  枣
//
//  Created by Comker on 2019/2/23.
//  Copyright © 2019 Comker. All rights reserved.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewsViewController : ViewController
@property(assign,nonatomic)int newsID;
@property(strong,nonatomic)NSString*t;
@property(strong,nonatomic)NSString*content;
@property(strong,nonatomic)NSString*time;
@property(nonatomic,assign)CGFloat titleHeight;
@property(nonatomic,assign)CGFloat timeHeight;
@property(nonatomic,assign)CGFloat contentHeight;
@end

NS_ASSUME_NONNULL_END

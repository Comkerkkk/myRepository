//
//  RegisterViewController.h
//  枣
//
//  Created by Comker on 2019/1/17.
//  Copyright © 2019 Comker. All rights reserved.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RegisterViewController : ViewController
@property(nonatomic,strong)void(^nameBlock)(NSString*name);
@end

NS_ASSUME_NONNULL_END

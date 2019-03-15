//
//  AddressViewController.h
//  枣
//
//  Created by Comker on 2019/2/19.
//  Copyright © 2019 Comker. All rights reserved.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddressViewController : ViewController
    @property (weak, nonatomic) IBOutlet UILabel *promptLabel;
    @property(nonatomic,strong)void (^sendBlock)(NSString* name,NSString* tel,NSString* address,NSString* touch_id);
@end

NS_ASSUME_NONNULL_END

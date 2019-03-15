//
//  ProductDetailHeader.h
//  ChinaJujubeNet
//
//  Created by apple on 2018/12/25.
//  Copyright © 2018 Stanshen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductDetailHeader : UIView

@property (weak, nonatomic) IBOutlet UIImageView *shopImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *stockLabel;
@end

NS_ASSUME_NONNULL_END

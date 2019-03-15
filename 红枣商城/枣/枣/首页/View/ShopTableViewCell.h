//
//  ShopTableViewCell.h
//  枣茬儿
//
//  Created by Comker on 2019/1/14.
//  Copyright © 2019 Comker. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShopTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *stockLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

NS_ASSUME_NONNULL_END

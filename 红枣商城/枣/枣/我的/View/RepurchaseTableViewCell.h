//
//  RepurchaseTableViewCell.h
//  枣
//
//  Created by Comker on 2019/2/25.
//  Copyright © 2019 Comker. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RepurchaseTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *creditLabel;
@property (weak, nonatomic) IBOutlet UIButton *exchangeBtn;
@property (weak, nonatomic) IBOutlet UILabel *stockLabel;

@end

NS_ASSUME_NONNULL_END

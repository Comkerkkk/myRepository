//
//  AddressViewCell.h
//  ChinaJujubeNet
//
//  Created by apple on 2018/12/25.
//  Copyright © 2018 Stanshen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddressViewCell : UITableViewCell

//收货人名字
@property (strong, nonatomic) IBOutlet UILabel *consigneeNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *consigneePhoneNUmberLabel;
@property (strong, nonatomic) IBOutlet UILabel *consigneeAddressLabel;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@end

NS_ASSUME_NONNULL_END

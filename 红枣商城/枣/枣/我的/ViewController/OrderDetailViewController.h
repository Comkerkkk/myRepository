//
//  OrderDetailViewController.h
//  枣
//
//  Created by Comker on 2019/2/22.
//  Copyright © 2019 Comker. All rights reserved.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailViewController : ViewController
@property (weak, nonatomic) IBOutlet UILabel *consigneeLabel;
@property (weak, nonatomic) IBOutlet UILabel *telLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;


@property(strong,nonatomic)NSString*consignee;
@property(strong,nonatomic)NSString*tel;
@property(strong,nonatomic)NSString*addr;
@property(strong,nonatomic)NSString*name;
@property(strong,nonatomic)NSString*icon;
@property(strong,nonatomic)NSString*price;
@property(strong,nonatomic)NSString*total;
@property(strong,nonatomic)NSString*num;
@property(assign,nonatomic)int indent_id;
@end

NS_ASSUME_NONNULL_END

//
//  ExchangeViewController.h
//  枣
//
//  Created by Comker on 2019/2/25.
//  Copyright © 2019 Comker. All rights reserved.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ExchangeViewController : ViewController
@property(nonatomic,strong)NSString*name;
@property(nonatomic,strong)NSString*image;
@property(nonatomic,assign)NSString*credit;
@property(nonatomic,strong)NSString*gift_id;
@property(nonatomic,strong)NSString*touch_id;

@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

@property(nonatomic,strong)NSString*Consignee;
@property(nonatomic,strong)NSString*tel;
@property(nonatomic,strong)NSString*address;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;
@end

NS_ASSUME_NONNULL_END

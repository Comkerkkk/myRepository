//
//  RecordDetailViewController.h
//  枣
//
//  Created by Comker on 2019/2/25.
//  Copyright © 2019 Comker. All rights reserved.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RecordDetailViewController : ViewController
@property(strong,nonatomic)NSString*consignee;
@property(strong,nonatomic)NSString*tel;
@property(strong,nonatomic)NSString*addr;
@property(strong,nonatomic)NSString*name;
@property(strong,nonatomic)NSString*icon;
@property(strong,nonatomic)NSString*credit;
@property(assign,nonatomic)int exchange_id;

@property (weak, nonatomic) IBOutlet UILabel *consigneeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addreLabel;
@property (weak, nonatomic) IBOutlet UILabel *telLabel;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *creditLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@end

NS_ASSUME_NONNULL_END

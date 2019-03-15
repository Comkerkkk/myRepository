//
//  SelectTableViewCell.h
//  枣
//
//  Created by Comker on 2019/2/19.
//  Copyright © 2019 Comker. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SelectTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *telLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@end

NS_ASSUME_NONNULL_END

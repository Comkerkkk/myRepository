//
//  TestTableViewCell.h
//  枣
//
//  Created by Comker on 2019/2/16.
//  Copyright © 2019 Comker. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CartTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *reduceBtn;
@property (weak, nonatomic) IBOutlet UIButton *plusBtn;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;
@property(nonatomic,assign)NSInteger maxNum;
@property(nonatomic,assign)NSInteger number;
@property(nonatomic,strong)void (^sendBlock)(NSString* num);

@end

NS_ASSUME_NONNULL_END

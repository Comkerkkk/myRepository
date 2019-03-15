//
//  ProductSpecCell.h
//  ChinaJujubeNet
//
//  Created by apple on 2018/12/25.
//  Copyright © 2018 Stanshen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductSpecCell : UITableViewCell
@property(nonatomic,assign)NSInteger number;
@property(assign,nonatomic)NSInteger maxNum;
@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;
@property (weak, nonatomic) IBOutlet UILabel *originLabel;
@property (weak, nonatomic) IBOutlet UIButton *reduceBtn;
@property (weak, nonatomic) IBOutlet UIButton *plusBtn;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@end

NS_ASSUME_NONNULL_END

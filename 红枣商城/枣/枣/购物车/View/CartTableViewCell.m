//
//  TestTableViewCell.m
//  枣
//
//  Created by Comker on 2019/2/16.
//  Copyright © 2019 Comker. All rights reserved.
//

#import "CartTableViewCell.h"

@interface CartTableViewCell()

@end
@implementation CartTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.reduceBtn.enabled=NO;
    self.number=1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)reduceAction:(id)sender {
    self.plusBtn.enabled=YES;
    
    self.number--;
   
    self.numLabel.text=[NSString stringWithFormat:@"%ld",self.number];
    
    if(self.numLabel.text.integerValue==1){
        self.reduceBtn.enabled=NO;
    }
    
    
}
- (IBAction)plusAction:(id)sender {
    self.reduceBtn.enabled=YES;
    self.number++;
    self.numLabel.text=[NSString stringWithFormat:@"%ld",self.number];
    
    if(self.numLabel.text.integerValue>=self.maxNum){
        self.plusBtn.enabled=NO;
    }
}
    
@end

//
//  ProductSpecCell.m
//  ChinaJujubeNet
//
//  Created by apple on 2018/12/25.
//  Copyright © 2018 Stanshen. All rights reserved.
//

#import "ProductSpecCell.h"
@interface ProductSpecCell()

@end
@implementation ProductSpecCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.reduceBtn.enabled=NO;
    
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
   
    
        
   
    // Configure the view for the selected state
}
- (IBAction)reduceAction:(id)sender {
    self.plusBtn.enabled=YES;
    self.number--;
    self.numLabel.text=[NSString stringWithFormat:@"%ld",self.number];
    if(self.numLabel.text.integerValue==0){
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

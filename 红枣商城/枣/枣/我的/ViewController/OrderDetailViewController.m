//
//  OrderDetailViewController.m
//  枣
//
//  Created by Comker on 2019/2/22.
//  Copyright © 2019 Comker. All rights reserved.
//

#import "OrderDetailViewController.h"

@interface OrderDetailViewController ()

@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"订单详情";
    self.consigneeLabel.text=self.consignee;
    self.telLabel.text=self.tel;
    self.addressLabel.text=self.addr;
    self.nameLabel.text=self.name;
    self.iconImageView.image=[UIImage imageWithContentsOfFile:self.icon];
    self.priceLabel.text=[NSString stringWithFormat:@"¥%@",self.price];
    self.numLabel.text=[NSString stringWithFormat:@"✖️%@",self.num];
    float total=self.num.intValue*self.price.floatValue;
    self.totalLabel.text=[NSString stringWithFormat:@"¥%.2f",total];
}


- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
    
}
- (IBAction)deleteAction:(id)sender {
    [self deleteOrderRequest];
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)deleteOrderRequest{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost/myshop/delete_order.php?id=%i",self.indent_id]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod = @"GET";
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary*resDict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        NSLog(@"%@",resDict);
        NSLog(@"%@",resDict[@"code"]);
    }];
    
    [task resume];
    
    
}

@end

//
//  RecordDetailViewController.m
//  枣
//
//  Created by Comker on 2019/2/25.
//  Copyright © 2019 Comker. All rights reserved.
//

#import "RecordDetailViewController.h"

@interface RecordDetailViewController ()

@end

@implementation RecordDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"兑换详情";
    self.consigneeLabel.text=self.consignee;
    self.telLabel.text=self.tel;
    self.addreLabel.text=self.addr;
    self.nameLabel.text=self.name;
    self.iconImageView.image=[UIImage imageWithContentsOfFile:self.icon];
    self.creditLabel.text=[NSString stringWithFormat:@"%@积分",self.credit];
    self.numLabel.text=[NSString stringWithFormat:@"✖️ 1"];
}
- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
    
}

- (IBAction)deleteAction:(id)sender {
    [self deleteRecordRequest];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)deleteRecordRequest{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost/myshop/delete_record.php?id=%i",self.exchange_id]];
    
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

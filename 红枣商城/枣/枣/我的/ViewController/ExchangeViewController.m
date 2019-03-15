//
//  ExchangeViewController.m
//  枣
//
//  Created by Comker on 2019/2/25.
//  Copyright © 2019 Comker. All rights reserved.
//

#import "ExchangeViewController.h"
#import "IndentTableViewCell.h"
#import "SelectTableViewCell.h"
#import "AddressViewController.h"
#import "UserInfo.h"
#import <MBProgressHUD.h>
@interface ExchangeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ExchangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.tableView registerNib:[UINib nibWithNibName:@"IndentTableViewCell" bundle:nil] forCellReuseIdentifier:@"IndentTableViewCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SelectTableViewCell" bundle:nil] forCellReuseIdentifier:@"SelectTableViewCell"];
    
    self.totalLabel.text=[NSString stringWithFormat:@"%@积分",self.credit];
    self.title=@"兑换";
}

- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==1){
        return 100;
    }else{
        return 140;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==1){
        IndentTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"IndentTableViewCell"];
        cell.nameLabel.text=self.name;
        cell.iconImageView.image=[UIImage imageWithContentsOfFile:self.image];
        cell.priceLabel.text=[NSString stringWithFormat:@"%@积分",self.credit];
        
        
        cell.numberLabel.text=[NSString stringWithFormat:@"✖️ 1"];
        
        return  cell;
    }else{
        SelectTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"SelectTableViewCell"];
        [cell.selectBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.nameLabel.text=self.Consignee;
        cell.telLabel.text=self.tel;
        cell.addressLabel.text=self.address;
        return cell;
    }
    
}

-(void)selectAction:(id)sender{
    AddressViewController*vc=[AddressViewController new];
    
    vc.sendBlock = ^(NSString * _Nonnull name, NSString * _Nonnull tel, NSString * _Nonnull address, NSString * _Nonnull touch_id) {
        self.Consignee=name;
        self.tel=tel;
        self.address=address;
        self.touch_id=touch_id;
        [self.tableView reloadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)payAction:(id)sender {
    if(self.Consignee==NULL){
        MBProgressHUD*hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode=MBProgressHUDModeText;
        hud.label.text=@"请选择地址";
        [hud hideAnimated:YES afterDelay:2];
    }else{
        [self exchangeRequest];
    }
}

-(void)exchangeRequest{

    
    __block UserInfo *userInfo=[UserInfo shareUserInfo];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost/myshop/exchange.php?user_id=%i&gift_id=%@&touch_id=%@&credit=%@",userInfo.userID,self.gift_id,self.touch_id,self.credit]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod = @"GET";
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    __weak typeof (self) weakSelf=self;
    
    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary*resDict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        NSLog(@"%@",resDict);
        NSLog(@"%@",resDict[@"code"]);
        NSString*code=[NSString stringWithFormat:@"%@",resDict[@"code"]];
        if([code isEqualToString:@"1"]){
            userInfo.credit-=self.credit.intValue;
            
            __strong typeof(weakSelf) strongSelf=weakSelf;
            dispatch_async(dispatch_get_main_queue(), ^{
                MBProgressHUD*hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode=MBProgressHUDModeText;
                hud.label.text=@"兑换成功";
                [hud hideAnimated:YES afterDelay:2.0];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [strongSelf.navigationController popViewControllerAnimated:YES];
                });
                
            });
            
        }
    }];
    
    [task resume];
}


@end

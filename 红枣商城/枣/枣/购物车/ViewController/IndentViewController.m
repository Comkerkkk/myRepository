//
//  IndentViewController.m
//  枣
//
//  Created by Comker on 2019/2/18.
//  Copyright © 2019 Comker. All rights reserved.
//

#import "IndentViewController.h"
#import "IndentTableViewCell.h"
#import "SelectTableViewCell.h"
#import "AddressViewController.h"
#import "UserInfo.h"
#import <MBProgressHUD.h>
@interface IndentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation IndentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"确认订单";
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"IndentTableViewCell" bundle:nil] forCellReuseIdentifier:@"IndentTableViewCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SelectTableViewCell" bundle:nil] forCellReuseIdentifier:@"SelectTableViewCell"];
    
    self.totalLabel.text=[NSString stringWithFormat:@"%.2f",self.num.intValue*self.price.floatValue];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return .1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


//设置cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==1){
        return 100;
    }else{
        return 140;
    }
}

//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==1){
        IndentTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"IndentTableViewCell"];
        cell.nameLabel.text=self.name;
        cell.iconImageView.image=[UIImage imageWithContentsOfFile:self.image];
        cell.priceLabel.text=[NSString stringWithFormat:@"%@/kg",self.price];
        
        
        cell.numberLabel.text=[NSString stringWithFormat:@"✖️%@",self.num];
       
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


//选择地址按钮事件
-(void)selectAction:(id)sender{
    AddressViewController*vc=[AddressViewController new];
    
    //使用block传递数据到vc
    vc.sendBlock = ^(NSString * _Nonnull name, NSString * _Nonnull tel, NSString * _Nonnull address, NSString * _Nonnull touch_id) {
        self.Consignee=name;
        self.tel=tel;
        self.address=address;
        self.touch_id=touch_id;
        [self.tableView reloadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
}


//结算按钮事件
- (IBAction)payAction:(id)sender {
    UserInfo *userInfo=[UserInfo shareUserInfo];
    if(self.Consignee==NULL){
        MBProgressHUD*hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode=MBProgressHUDModeText;
        hud.label.text=@"请选择地址";
        [hud hideAnimated:YES afterDelay:2];
    }else if (userInfo.money<self.num.intValue*self.price.floatValue){
        MBProgressHUD*hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode=MBProgressHUDModeText;
        hud.label.text=@"余额不足";
        [hud hideAnimated:YES afterDelay:2];
    }
    else{
        [self balanceRequest];
    }
}


//结算请求
-(void)balanceRequest{
    __block UserInfo *userInfo=[UserInfo shareUserInfo];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost/myshop/balance.php?user_id=%i&shop_id=%@&touch_id=%@&price=%@&num=%@&cart_id=%@",userInfo.userID,self.shop_id,self.touch_id,self.totalLabel.text,self.num,self.cart_id]];
    
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
            
            
            __strong typeof(weakSelf) strongSelf=weakSelf;
            dispatch_async(dispatch_get_main_queue(), ^{
                userInfo.money-=strongSelf.totalLabel.text.floatValue;
                MBProgressHUD*hud=[MBProgressHUD showHUDAddedTo:strongSelf.view animated:YES];
                hud.mode=MBProgressHUDModeText;
                hud.label.text=@"付款成功";
                [hud hideAnimated:YES afterDelay:2.0];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if(strongSelf.refreshBlock){
                        strongSelf.refreshBlock();
                    }
                    [strongSelf.navigationController popViewControllerAnimated:YES];
                });
                
                
            });
            
        }
    }];
    
    [task resume];
}
@end

//
//  OrderViewController.m
//  枣
//
//  Created by Comker on 2019/2/21.
//  Copyright © 2019 Comker. All rights reserved.
//

#import "OrderViewController.h"
#import "IndentTableViewCell.h"
#import "OrderModel.h"
#import "UserInfo.h"
#import "OrderDetailViewController.h"
#import <MJExtension.h>
@interface OrderViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableArray*indentArray;
@end

@implementation OrderViewController
-(NSMutableArray*)indentArray{
    if(_indentArray==nil){
        _indentArray=[NSMutableArray array];
    }
    return _indentArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"全部订单";
    [self.tableView registerNib:[UINib nibWithNibName:@"IndentTableViewCell" bundle:nil] forCellReuseIdentifier:@"IndentTableViewCell"];
    [self orderRequest];
}

- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
    
}

- (void)viewDidAppear:(BOOL)animated{
    [self orderRequest];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.indentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IndentTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"IndentTableViewCell"];
    OrderModel*model=self.indentArray[indexPath.section];
    cell.nameLabel.text=model.shopName;
    cell.priceLabel.text=[NSString stringWithFormat:@"¥%@",model.price];
    cell.numberLabel.text=[NSString stringWithFormat:@"✖️ %@",model.num];
    cell.iconImageView.image=[UIImage imageWithContentsOfFile:model.image];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderModel*model=self.indentArray[indexPath.section];
    OrderDetailViewController*vc=[OrderDetailViewController new];
    vc.consignee=model.name;
    vc.tel=model.tel;
    vc.addr=model.addr;
    vc.name=model.shopName;
    vc.price=model.price;
    vc.num=model.num;
    vc.icon=model.image;
    vc.indent_id=model.id;
    [self.navigationController pushViewController:vc animated:YES];
    
}

//全部订单请求
-(void)orderRequest{
    UserInfo *userInfo=[UserInfo shareUserInfo];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost/myshop/order.php?user_id=%i",userInfo.userID]];
    
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
            
            weakSelf.indentArray=[OrderModel mj_objectArrayWithKeyValuesArray:resDict[@"list"]];
            __strong typeof(weakSelf) strongSelf=weakSelf;
            dispatch_async(dispatch_get_main_queue(), ^{
                strongSelf.tableView.hidden=NO;
                [strongSelf.tableView reloadData];
            });
            
        }else{
            __strong typeof(weakSelf) strongSelf=weakSelf;
            dispatch_async(dispatch_get_main_queue(), ^{
                strongSelf.tableView.hidden=YES;
            });
        }
    }];
    
    [task resume];
}

@end

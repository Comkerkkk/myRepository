//
//  AddressViewController.m
//  枣
//
//  Created by Comker on 2019/2/19.
//  Copyright © 2019 Comker. All rights reserved.
//

#import "AddressViewController.h"
#import "AddressTableViewCell.h"
#import "UserInfo.h"
#import "TouchModel.h"
#import <MJExtension.h>
@interface AddressViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableArray*addressArray;
@end

@implementation AddressViewController
-(NSMutableArray*)addressArray{
    if(_addressArray==nil){
        _addressArray=[NSMutableArray array];
    }
    return _addressArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.tableView registerNib:[UINib nibWithNibName:@"AddressTableViewCell" bundle:nil] forCellReuseIdentifier:@"AddressTableViewCell"];
    [self touchRequest];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
    
}
    
- (void)viewWillDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.addressArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1;
}


//cell点击跳转回传数据
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TouchModel*model=self.addressArray[indexPath.row];
    NSString*touch_id=[NSString stringWithFormat:@"%i",model.id];
    if(_sendBlock){
        _sendBlock(model.name,model.tel,model.addr,touch_id);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"AddressTableViewCell"];
    
    TouchModel*model=self.addressArray[indexPath.row];
    cell.nameLabel.text=model.name;
    cell.telLabel.text=model.tel;
    cell.addressLabel.text=model.addr;
    return cell;
    
}


//联系方式请求
-(void)touchRequest{
    UserInfo *userInfo=[UserInfo shareUserInfo];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost/myshop/touch.php?user_id=%i",userInfo.userID]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod = @"GET";
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary*resDict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        NSLog(@"%@",resDict);
        NSLog(@"%@",resDict[@"code"]);
        NSString*code=[NSString stringWithFormat:@"%@",resDict[@"code"]];
        if([code isEqualToString:@"1"]){
            
            self.addressArray=[TouchModel mj_objectArrayWithKeyValuesArray:resDict[@"list"]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
            
        }else{
            
            //显示提示label
            dispatch_async(dispatch_get_main_queue(), ^{
                self.promptLabel.hidden=NO;
            });
        }
    }];
    
    [task resume];
    
}
@end

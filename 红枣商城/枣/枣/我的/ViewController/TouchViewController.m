//
//  TouchViewController.m
//  枣
//
//  Created by Comker on 2019/2/11.
//  Copyright © 2019 Comker. All rights reserved.
//

#import "TouchViewController.h"
#import "AddressViewCell.h"
#import "TouchModel.h"
#import <MJExtension.h>
#import "UserInfo.h"
#import "AddTouchViewController.h"
#import "EditTouchViewController.h"
#import <objc/runtime.h>
@interface TouchViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableArray*touchArr;
@end

@implementation TouchViewController
-(NSMutableArray*)touchArr{
    if(_touchArr==nil){
        _touchArr=[NSMutableArray array];
    }
    return _touchArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"地址管理";
    [self.tableView registerNib:[UINib nibWithNibName:@"AddressViewCell" bundle:nil] forCellReuseIdentifier:@"AddressViewCell"];
    
    [self touchRequest];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [self touchRequest];
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.touchArr.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 135;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"AddressViewCell"];
    TouchModel*model=self.touchArr[indexPath.section];
    cell.consigneeNameLabel.text=model.name;
    cell.consigneeAddressLabel.text=model.addr;
    cell.consigneePhoneNUmberLabel.text=model.tel;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    //设置cell中按钮的事件
    [cell.deleteBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.editBtn addTarget:self action:@selector(editAction:)
           forControlEvents:UIControlEventTouchUpInside];
    
    //传递数据
    objc_setAssociatedObject(cell.deleteBtn, @"delete", [NSString stringWithFormat:@"%i",model.id],OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(cell.editBtn, @"edit", [NSString stringWithFormat:@"%i",model.id], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(cell.editBtn, @"name", [NSString stringWithFormat:@"%@",model.name], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(cell.editBtn, @"addr", [NSString stringWithFormat:@"%@",model.addr], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(cell.editBtn, @"tel", [NSString stringWithFormat:@"%@",model.tel], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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
            
            self.touchArr=[TouchModel mj_objectArrayWithKeyValuesArray:resDict[@"list"]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
            
        }
    }];
    
    [task resume];
    
}

//添加联系方式按钮事件
- (IBAction)AddTouchAction:(id)sender {
    
    [self.navigationController pushViewController:[AddTouchViewController new] animated:YES];
}

//删除联系方式事件
-(void)deleteAction:(id) sender{
    NSString*id= objc_getAssociatedObject(sender, @"delete");
    
    [self deleteTouchRequest:(NSString*)id];
    

   
}

//编辑按钮事件
-(void)editAction:(id)sender{
    NSString*id= objc_getAssociatedObject(sender, @"edit");
    NSString*name= objc_getAssociatedObject(sender, @"name");
    NSString*tel= objc_getAssociatedObject(sender, @"tel");
    NSString*addr= objc_getAssociatedObject(sender, @"addr");
    
    EditTouchViewController*vc=[EditTouchViewController new];
    vc.touch_id=id;
    vc.name=name;
    vc.tel=tel;
    vc.addr=addr;
    
    [self.navigationController pushViewController:vc animated:YES];
}

//删除联系方式请求
-(void)deleteTouchRequest:(NSString*) id{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost/myshop/delete_touch.php?id=%@",id]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod = @"GET";
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary*resDict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        NSLog(@"%@",resDict);
        NSLog(@"%@",resDict[@"code"]);
        NSString*code=[NSString stringWithFormat:@"%@",resDict[@"code"]];
        if([code isEqualToString:@"1"]){
            
            self.touchArr=[TouchModel mj_objectArrayWithKeyValuesArray:resDict[@"list"]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                [self touchRequest];
            });
            
        }
    }];
    
    [task resume];
    
    
}

//编辑联系方式请求
-(void)editTouchRequest:(NSString*) id{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost/myshop/update_touch.php?id=%@",id]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod = @"GET";
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary*resDict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        NSLog(@"%@",resDict);
        NSLog(@"%@",resDict[@"code"]);
        NSString*code=[NSString stringWithFormat:@"%@",resDict[@"code"]];
        if([code isEqualToString:@"1"]){
            
            self.touchArr=[TouchModel mj_objectArrayWithKeyValuesArray:resDict[@"list"]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                [self touchRequest];
            });
            
        }
    }];
    
    [task resume];
    
    
}
@end

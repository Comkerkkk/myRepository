//
//  CartViewController.m
//  枣
//
//  Created by Comker on 2019/1/15.
//  Copyright © 2019 Comker. All rights reserved.
//

#import "CartViewController.h"
#import "CartTableViewCell.h"
#import "UserInfo.h"
#import "CartModel.h"
#import "IndentViewController.h"
#import <MJExtension.h>
@interface CartViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableArray*cartArray;
@end

@implementation CartViewController
-(NSMutableArray*)cartArray{
    if(_cartArray==nil){
        _cartArray=[NSMutableArray array];
    }
    return _cartArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"购物车";
    [self.tableView registerNib:[UINib nibWithNibName:@"CartTableViewCell" bundle:nil] forCellReuseIdentifier:@"CartTableViewCell"];
    [self cartRequest];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [self cartRequest];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.cartArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return .1;
}

//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CartModel*model=self.cartArray[indexPath.section];
    
    CartTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"CartTableViewCell"];
    
    cell.iconImageView.image=[UIImage imageWithContentsOfFile:model.image];
    cell.nameLabel.text=model.shopName;
    cell.priceLabel.text=[NSString stringWithFormat:@"%.2f/kg",model.price];
    cell.maxNum=model.stock;
    [cell.deleteBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    objc_setAssociatedObject(cell.deleteBtn, @"delete", [NSString stringWithFormat:@"%i",model.shop_id],OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [cell.payBtn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //使用runtime传递数据
    objc_setAssociatedObject(cell.payBtn, @"image", [NSString stringWithFormat:@"%@",model.image],OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(cell.payBtn, @"name", [NSString stringWithFormat:@"%@",model.shopName],OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(cell.payBtn, @"cart_id", [NSString stringWithFormat:@"%i",model.id],OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(cell.payBtn, @"shop_id", [NSString stringWithFormat:@"%i",model.shop_id],OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(cell.payBtn, @"price", [NSString stringWithFormat:@"%.2f",model.price],OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(cell.payBtn, @"num", [NSString stringWithFormat:@"%@",cell.numLabel.text],OBJC_ASSOCIATION_RETAIN_NONATOMIC);
   
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return  cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 140;
}

//网络请求
-(void)cartRequest{
    UserInfo *userInfo=[UserInfo shareUserInfo];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost/myshop/cart.php?user_id=%i",userInfo.userID]];
    
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
            
            weakSelf.cartArray=[CartModel mj_objectArrayWithKeyValuesArray:resDict[@"list"]];
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

//删除按钮事件
-(void)deleteAction:(id)sender{
    NSString*shop_id= objc_getAssociatedObject(sender, @"delete");
    NSLog(@"%@",shop_id);
    [self deleteCartRequest:shop_id];
}

//编辑按钮事件
-(void)editAction:(id)sender{
    
    [self.tableView reloadData];
    //表格刷新完后在执行后续操作
    [self.tableView layoutIfNeeded];



    NSString*image= objc_getAssociatedObject(sender, @"image");
    NSString*name= objc_getAssociatedObject(sender, @"name");
    NSString*price= objc_getAssociatedObject(sender, @"price");
    NSString*num= objc_getAssociatedObject(sender, @"num");
    NSString*cart_id= objc_getAssociatedObject(sender, @"cart_id");
    NSString*shop_id= objc_getAssociatedObject(sender, @"shop_id");
    
    IndentViewController*vc=[IndentViewController new];
    vc.name=name;
    vc.image=image;
    vc.price=price;
    vc.num=num;
    vc.cart_id=cart_id;
    vc.shop_id=shop_id;
    [self.navigationController pushViewController:vc animated:YES];

   
}

//删除购物车请求
-(void)deleteCartRequest:(NSString*)shop_id{
    UserInfo *userInfo=[UserInfo shareUserInfo];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost/myshop/delete_cart.php?user_id=%i&shop_id=%@",userInfo.userID,shop_id]];
    
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
            
            weakSelf.cartArray=[CartModel mj_objectArrayWithKeyValuesArray:resDict[@"list"]];
            __strong typeof(weakSelf) strongSelf=weakSelf;
            dispatch_async(dispatch_get_main_queue(), ^{
                strongSelf.tableView.hidden=NO;
                [strongSelf.tableView reloadData];
                
                [strongSelf cartRequest];
            });
            
        }else{
            //返回数据为空时显示提示label
            __strong typeof(weakSelf) strongSelf=weakSelf;
            dispatch_async(dispatch_get_main_queue(), ^{
                strongSelf.tableView.hidden=YES;
                
            });
            
        }
    }];
    
    [task resume];
}
@end

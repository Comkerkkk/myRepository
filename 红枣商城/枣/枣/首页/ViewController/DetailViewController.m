//
//  DetailViewController.m
//  枣
//
//  Created by Comker on 2019/1/19.
//  Copyright © 2019 Comker. All rights reserved.
//

#import "DetailViewController.h"
#import "ProductDetailHeader.h"
#import "ProductSpecCell.h"
#import "DescribeTableViewCell.h"
#import "ShopModel.h"
#import "UserInfo.h"
#import "IndentViewController.h"
#import "TextHeightTool.h"
#import "NSArray+errorHandle.h"
#import <MJExtension.h>
#import <MBProgressHUD.h>
@interface DetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mainTable;
@property(nonatomic,strong)NSMutableArray*shopArray;
@property (weak, nonatomic) IBOutlet UIButton *cartBtn;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@property(assign,nonatomic)CGFloat desH;
@end

@implementation DetailViewController
- (NSMutableArray *)shopArray{
    if(!_shopArray){
        _shopArray=[NSMutableArray array];
    }
    return _shopArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title=@"商品详情";
    [_mainTable registerNib:[UINib nibWithNibName:@"ProductSpecCell" bundle:nil] forCellReuseIdentifier:@"ProductSpecCell"];
    
    [_mainTable registerNib:[UINib nibWithNibName:@"DescribeTableViewCell" bundle:nil] forCellReuseIdentifier:@"DescribeTableViewCell"];
    
    [self shopRequest];
}

- (void)viewWillAppear:(BOOL)animated{
 
    
    
    self.tabBarController.tabBar.hidden = YES;
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
    
}


- (void)viewDidAppear:(BOOL)animated{
//    [self shopRequest];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    ShopModel*model=[self.shopArray objectAtIndexVerify:0];
    if(indexPath.section==0){
        ProductSpecCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ProductSpecCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
       
        cell.gradeLabel.text=[NSString stringWithFormat:@"等级：%i",model.grade];
        cell.originLabel.text=[NSString stringWithFormat:@"原产地：%@",model.origin];
        objc_setAssociatedObject(self.buyBtn, @"num", [NSString stringWithFormat:@"%li",cell.number],OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        cell.maxNum=model.stock;
        if(model.stock==0){
            self.buyBtn.enabled=NO;
            self.cartBtn.enabled=NO;
            cell.plusBtn.enabled=NO;
            
        }
        return cell;
    }else{
        DescribeTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"DescribeTableViewCell"];
        cell.text_Label.text=model.des;
        self.desH=[TextHeightTool contentHeightWithText:model.des textWidth:[UIScreen mainScreen].bounds.size.width-16 stringSize:15];
       
        return  cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        return 182;
    }else{
        NSLog(@"%f",self.desH);
        return self.desH+100;
    }
}

-(void)shopRequest{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost/myshop/shop.php?id=%d",self.shopID]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod = @"GET";
    
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    __weak typeof(self) weakSelf=self;
    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@",[NSThread currentThread]);
        NSDictionary*resDict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        NSLog(@"%@",resDict);
        NSLog(@"%@",resDict[@"code"]);
        NSString*code=[NSString stringWithFormat:@"%@",resDict[@"code"]];
        if([code isEqualToString:@"1"]){
            
             weakSelf.shopArray=[ShopModel mj_objectArrayWithKeyValuesArray:resDict[@"list"]];
            __strong typeof(weakSelf) strongSelf=weakSelf;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置tableview头部
                ShopModel*model=strongSelf.shopArray[0];
                ProductDetailHeader*header=[[NSBundle mainBundle]loadNibNamed:@"ProductDetailHeader" owner:nil options:nil][0];
                header.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 400);
                
                
                header.shopImageView.image=[UIImage imageNamed:model.image];
                header.nameLabel.text=model.shopName;
                header.priceLabel.text=[NSString stringWithFormat:@"%.2f/kg",model.price];
                header.stockLabel.text=[NSString stringWithFormat:@"库存：%dkg",model.stock];
                
                strongSelf.mainTable.tableHeaderView=header;
                
                
            });
        
           
        }
    }];
   
    [task resume];
    
    
    
}

//加入购物车按钮事件
- (IBAction)cartAction:(id)sender {
    [self addCartRequest];
}


//加入购物车请求
-(void)addCartRequest{
    UserInfo *userInfo=[UserInfo shareUserInfo];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost/myshop/add_cart.php?shop_id=%d&user_id=%i",self.shopID,userInfo.userID]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod = @"GET";
    
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    __weak typeof(self) weakSelf=self;
    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@",[NSThread currentThread]);
        NSDictionary*resDict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        NSLog(@"%@",resDict);
        NSLog(@"%@",resDict[@"code"]);
        NSString*code=[NSString stringWithFormat:@"%@",resDict[@"code"]];
        //成功加入购物车
        if([code isEqualToString:@"1"]){
            __strong typeof(weakSelf) strongSelf=weakSelf; dispatch_async(dispatch_get_main_queue(), ^{
                MBProgressHUD*hud= [MBProgressHUD showHUDAddedTo:strongSelf.view animated:YES];
                hud.mode=MBProgressHUDModeText;
                hud.label.text=@"已成功加入购物车";
                [hud hideAnimated:YES afterDelay:2];
                
            });
            //判断购物车是否已存在该商品
        }else if ([code isEqualToString:@"0"]){
            __strong typeof(weakSelf) strongSelf=weakSelf; dispatch_async(dispatch_get_main_queue(), ^{
                MBProgressHUD*hud= [MBProgressHUD showHUDAddedTo:strongSelf.view animated:YES];
                hud.mode=MBProgressHUDModeText;
                hud.label.text=@"该商品已在购物车";
                [hud hideAnimated:YES afterDelay:2];
                
            });
        }
    }];
    
    [task resume];
    
    
    
}


//购买按钮事件
- (IBAction)buyAction:(id)sender {
    [self.mainTable reloadData];
    [self.mainTable layoutIfNeeded];
    ShopModel*model=self.shopArray[0];
    IndentViewController*vc=[IndentViewController new];
    NSString*num= objc_getAssociatedObject(sender, @"num");
    vc.image=model.image;
    vc.price=[NSString stringWithFormat:@"%.2f",model.price];
    vc.name=model.shopName;
    vc.cart_id=@"0";
    vc.shop_id=[NSString stringWithFormat:@"%i",model.id];
    vc.num=num;
    if([num isEqualToString:@"0"]){
        MBProgressHUD*hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode=MBProgressHUDModeText;
        hud.label.text=@"请先选择规格";
        [hud hideAnimated:YES afterDelay:2];
    }else{
            vc.refreshBlock = ^{
                [self shopRequest];};

        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}

@end

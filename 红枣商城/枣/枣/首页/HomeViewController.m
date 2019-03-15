//
//  HomeViewController.m
//  枣茬儿
//
//  Created by Comker on 2019/1/14.
//  Copyright © 2019 Comker. All rights reserved.
//

#import "HomeViewController.h"
#import "ShopTableViewCell.h"
#import "ShopModel.h"
#import "DetailViewController.h"
#import <MJExtension.h>
#import "SearchViewController.h"
@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableArray*shopArray;
@end

@implementation HomeViewController
-(NSMutableArray *)shopArray{
    if (_shopArray == nil) {
        _shopArray = [NSMutableArray array];
    }
    return _shopArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.tableView registerNib:[UINib nibWithNibName:@"ShopTableViewCell" bundle:nil] forCellReuseIdentifier:@"ShopCell"];
    
    self.title=@"首页";
    [self shopRequest];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_btn_search"] style:UIBarButtonItemStyleDone target:self action:@selector(search)];
}

- (void)viewWillAppear:(BOOL)animated{
    [self shopRequest];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.shopArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return .1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 87;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ShopCell"];
    ShopModel*model=self.shopArray[indexPath.row];
    cell.nameLabel.text=model.shopName;
    cell.priceLabel.text=[NSString stringWithFormat:@"%.2f/kg",model.price];
    cell.stockLabel.text=[NSString stringWithFormat:@"库存：%ikg",model.stock];
    cell.iconImageView.image=[UIImage imageWithContentsOfFile:model.image];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController*vc=[[DetailViewController alloc]init];
    ShopModel*model=self.shopArray[indexPath.row];
    vc.shopID=model.id;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)shopRequest{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost/myshop/shop.php?id=0"]];
    
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
            
            weakSelf.shopArray=[ShopModel mj_objectArrayWithKeyValuesArray:resDict[@"list"]];
            __strong typeof(weakSelf) strongSelf=weakSelf;
            dispatch_async(dispatch_get_main_queue(), ^{
                [strongSelf.tableView reloadData];
            });
            
        }
    }];
    
    [task resume];
}

-(void)search{
    [self.navigationController pushViewController:[SearchViewController new] animated:YES];
}
@end

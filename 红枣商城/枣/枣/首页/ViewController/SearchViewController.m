//
//  SearchViewController.m
//  枣
//
//  Created by Comker on 2019/3/14.
//  Copyright © 2019 Comker. All rights reserved.
//

#import "SearchViewController.h"
#import "ShopModel.h"
#import "ShopTableViewCell.h"
#import <MJExtension.h>
#import <MBProgressHUD.h>
#import "DetailViewController.h"
@interface SearchViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *searchTF;
@property(strong,nonatomic)NSArray*shopArray;
@property(weak,nonatomic)UITableView*tableView;
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UILabel *promptLabel;

@end

@implementation SearchViewController
-(NSArray*)shopArray{
    if(_shopArray==nil){
        _shopArray=[NSArray array];
    }
    return _shopArray;
}
-(UITableView*)tableView{
    if(_tableView==nil){
        UITableView*tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.searchView.frame), [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-50-65) style:UITableViewStyleGrouped];
        
        
        tableView.dataSource=self;
        tableView.delegate=self;
        [self.view addSubview:tableView];
        [tableView registerNib:[UINib nibWithNibName:@"ShopTableViewCell" bundle:nil] forCellReuseIdentifier:@"ShopCell"];
        
        _tableView=tableView;
    }
    return  _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)viewWillAppear:(BOOL)animated{
    
    
    
    self.tabBarController.tabBar.hidden = YES;
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
    
}

-(void)searchRequest{
    NSString*shopName=[self.searchTF.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost/myshop/search.php?name=%@",shopName]];
    
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
                
                
                [strongSelf.tableView reloadData];
                
                
            });
            
            
        }else{
            __strong typeof(weakSelf) strongSelf=weakSelf;
            dispatch_async(dispatch_get_main_queue(), ^{
                [strongSelf.tableView removeFromSuperview];
                strongSelf.promptLabel.hidden=NO;
                
                
                
            });
        }
    }];
    
    [task resume];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.shopArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ShopCell"];
    ShopModel*model=self.shopArray[indexPath.row];
    cell.nameLabel.text=model.shopName;
    cell.iconImageView.image=[UIImage imageWithContentsOfFile:model.image];
    cell.priceLabel.text=[NSString stringWithFormat:@"%.2f/kg",model.price];
    cell.stockLabel.text=[NSString stringWithFormat:@"库存：%ikg",model.stock];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 87;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return .1;
}

- (IBAction)searchAction:(id)sender {
    if([self.searchTF.text isEqualToString:@""]){
        MBProgressHUD*hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode=MBProgressHUDModeText;
        hud.label.text=@"请先输入商品名称";
        [hud hideAnimated:YES afterDelay:2];
    }else{
        
        [self searchRequest];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController*vc=[[DetailViewController alloc]init];
    ShopModel*model=self.shopArray[indexPath.row];
    vc.shopID=model.id;
    [self.navigationController pushViewController:vc animated:YES];
}

@end

//
//  RecordViewController.m
//  枣
//
//  Created by Comker on 2019/2/25.
//  Copyright © 2019 Comker. All rights reserved.
//

#import "RecordViewController.h"
#import "IndentTableViewCell.h"
#import "RecordDetailViewController.h"
#import "RecordModel.h"
#import "UserInfo.h"
#import <MJExtension.h>

@interface RecordViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableArray*indentArray;
@end

@implementation RecordViewController
-(NSMutableArray*)indentArray{
    if(_indentArray==nil){
        _indentArray=[NSMutableArray array];
    }
    return _indentArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.tableView registerNib:[UINib nibWithNibName:@"IndentTableViewCell" bundle:nil] forCellReuseIdentifier:@"IndentTableViewCell"];
    [self recordRequest];
    self.title=@"兑换记录";
}

- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
    
}

- (void)viewDidAppear:(BOOL)animated{
    [self recordRequest];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.indentArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IndentTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"IndentTableViewCell"];
    RecordModel*model=self.indentArray[indexPath.section];
    cell.nameLabel.text=model.giftName;
    cell.priceLabel.text=[NSString stringWithFormat:@"%@积分",model.credit];
    cell.numberLabel.text=[NSString stringWithFormat:@"✖️ 1"];
    cell.iconImageView.image=[UIImage imageWithContentsOfFile:model.image];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RecordModel*model=self.indentArray[indexPath.section];
    RecordDetailViewController *vc=[RecordDetailViewController new];
    vc.consignee=model.name;
    vc.tel=model.tel;
    vc.addr=model.addr;
    vc.name=model.giftName;
    vc.credit=model.credit;
    vc.icon=model.image;
    vc.exchange_id=model.id;
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)recordRequest{
    UserInfo *userInfo=[UserInfo shareUserInfo];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost/myshop/record.php?user_id=%i",userInfo.userID]];
    
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
            
            weakSelf.indentArray=[RecordModel mj_objectArrayWithKeyValuesArray:resDict[@"list"]];
            __strong typeof(weakSelf) strongSelf=weakSelf;
            dispatch_async(dispatch_get_main_queue(), ^{
                strongSelf.tableView.hidden=NO;
                [strongSelf.tableView reloadData];
            });
            
        }else{
            
                __strong typeof(weakSelf) strongSelf=weakSelf;dispatch_async(dispatch_get_main_queue(), ^{
                    strongSelf.tableView.hidden=YES;
            });
        }
    }];
    
    [task resume];
}

@end

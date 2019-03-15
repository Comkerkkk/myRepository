//
//  FindViewController.m
//  枣
//
//  Created by Comker on 2019/1/15.
//  Copyright © 2019 Comker. All rights reserved.
//

#import "FindViewController.h"
#import "NewsModel.h"
#import "NewSViewController.h"
#import <MJExtension.h>
@interface FindViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong,nonatomic)NSMutableArray*newsArray;
@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"发现";
    
    [self newsRequest];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.newsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1;
}


//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    NewsModel*model=self.newsArray[indexPath.row];
    cell.textLabel.text=model.title;
    cell.detailTextLabel.text=model.time;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

//点击cell执行跳转并传递数据
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsModel*model=self.newsArray[indexPath.row];
    NewsViewController*vc=[NewsViewController new];
    vc.newsID=model.id;
    vc.t=model.title;
    vc.content=model.content;
    vc.time=model.time;
    [self.navigationController pushViewController:vc animated:YES];
}

//网络请求
-(void)newsRequest{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost/myshop/news.php?id=0"]];
    
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
            
            weakSelf.newsArray=[NewsModel mj_objectArrayWithKeyValuesArray:resDict[@"list"]];
            __strong typeof(weakSelf) strongSelf=weakSelf;
            dispatch_async(dispatch_get_main_queue(), ^{
                [strongSelf.tableView reloadData];
            });
            
        }
    }];
    
    [task resume];
}
@end

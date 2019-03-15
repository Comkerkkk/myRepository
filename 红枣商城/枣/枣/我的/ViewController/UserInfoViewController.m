//
//  UserInfoViewController.m
//  枣
//
//  Created by Comker on 2019/3/15.
//  Copyright © 2019 Comker. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserInfo.h"
@interface UserInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong,nonatomic)NSMutableArray*muArr;
@property(strong,nonatomic)NSMutableArray*muimgArr;
@end

@implementation UserInfoViewController
- (NSMutableArray *)muimgArr{
    if (_muimgArr==nil) {
        _muimgArr = [NSMutableArray arrayWithArray:@[@"ic_certification_01",@"ic_certification_17",@"ic_me_01"]];
    }
    return _muimgArr;
}
- (NSMutableArray *)muArr{
    if (_muArr==nil) {
        _muArr = [NSMutableArray arrayWithArray:@[@"用户名",@"积分",@"余额"]];
    }
    return _muArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UserInfo *userInfo=[UserInfo shareUserInfo];
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.imageView.image=[UIImage imageNamed:self.muimgArr[indexPath.row]];
    cell.textLabel.text=self.muArr[indexPath.row];
    if(indexPath.row==0){
        cell.detailTextLabel.text=userInfo.userName;
    }else if(indexPath.row==1){
        cell.detailTextLabel.text=[NSString stringWithFormat:@"%i",userInfo.credit];
    }else{
        cell.detailTextLabel.text=[NSString stringWithFormat:@"%.2f",userInfo.money];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return .1;
}
@end

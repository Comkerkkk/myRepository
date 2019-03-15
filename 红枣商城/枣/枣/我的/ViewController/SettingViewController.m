//
//  SettingViewController.m
//  枣
//
//  Created by Comker on 2019/2/9.
//  Copyright © 2019 Comker. All rights reserved.
//

#import "SettingViewController.h"
#import "ChangePWDViewController.h"
@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"设置";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
   
}
- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
    
}

//设置cell行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

//设置cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"
              ];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    if(indexPath.row==0){
        cell.textLabel.text=@"修改密码";
    }else{
        cell.textLabel.text=@"退出登录";
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1;
}


//设置cell点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        [self.navigationController pushViewController:[ChangePWDViewController new] animated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
@end

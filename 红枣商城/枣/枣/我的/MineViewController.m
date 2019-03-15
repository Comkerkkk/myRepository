//
//  MineViewController.m
//  枣茬儿
//
//  Created by Comker on 2019/1/14.
//  Copyright © 2019 Comker. All rights reserved.
//

#import "MineViewController.h"
#import "UserInfo.h"
#import "SignInModel.h"
#import "SettingViewController.h"
#import "TouchViewController.h"
#import "RepurchaseViewController.h"
#import "OrderViewController.h"
#import "RecordViewController.h"
#import "UserInfoViewController.h"
#import <MJExtension.h>
#import <MBProgressHUD.h>
@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong,nonatomic)UIBarButtonItem*signItem;
@property(nonatomic,strong)NSMutableArray*signInArr;
@property (strong,nonatomic)NSMutableArray *muArr;
@property (strong,nonatomic)NSMutableArray *muimgArr;
@end

@implementation MineViewController
-(NSMutableArray*)signInArr{
    if(_signInArr==nil){
        _signInArr=[NSMutableArray array];
        
    }
    return _signInArr;
}

//存放cell的图标
- (NSMutableArray *)muimgArr{
    if (_muimgArr==nil) {
        _muimgArr = [NSMutableArray arrayWithArray:@[@"ic_me_address",@"ic_me_collect",@"ic_me_set"]];
    }
    return _muimgArr;
}

//存放cell的名称
- (NSMutableArray *)muArr{
    if (_muArr==nil) {
        _muArr = [NSMutableArray arrayWithArray:@[@"地址管理",@"积分换购",@"设置"]];
    }
    return _muArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"我的";
    
    //设置签到按钮
    self.signItem=[[UIBarButtonItem alloc]initWithTitle:@"签到" style:UIBarButtonItemStyleDone target:self action:@selector(signAction)];
    self.navigationItem.rightBarButtonItem=self.signItem;
    
    //用户信息单例
    UserInfo *userInfo=[UserInfo shareUserInfo];
    self.nameLabel.text=userInfo.userName;
    
    NSLog( @"%i",userInfo.userID);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self isSignInRequest];
    
    //定时器：每秒进行判断是否已签到
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(isSignInRequest) userInfo:nil repeats:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"
              ];
    }
    cell.textLabel.text=self.muArr[indexPath.row];
    cell.imageView.image  =[UIImage imageNamed:self.muimgArr[indexPath.row]];
    
    
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSString *muimgStr = self.muArr[indexPath.row];
    if ([ muimgStr isEqualToString:@"积分换购"]) {
       [self.navigationController pushViewController:[RepurchaseViewController new] animated:YES];
        
    }else if ([muimgStr isEqualToString:@"地址管理"]) {
         [self.navigationController pushViewController:[TouchViewController new] animated:YES];
    }else if ([muimgStr isEqualToString:@"设置"]) {
        
        
        [self.navigationController pushViewController:[SettingViewController new] animated:YES];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1;
}


//签到按钮事件
-(void)signAction{
    
    //获取当前时间
    NSDate*date=[NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[date timeIntervalSince1970];
    NSString*timeStr=[NSString stringWithFormat:@"%0.f",a];
    NSLog(@"%@",timeStr);
    
    //签到请求
    [self signInRequest];
    
    //设置签到后按钮状态
    self.signItem.title=@"已签到";
    self.signItem.enabled=NO;
    
    //更新积分的请求
    [self updateCreditRequest];
}

-(void)isSignInRequest{
    
    UserInfo *userInfo=[UserInfo shareUserInfo];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost/myshop/sign_in.php?user_id=%d",userInfo.userID]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod = @"GET";
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary*resDict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
//        NSLog(@"%@",resDict);
//        NSLog(@"%@",resDict[@"code"]);
        NSString*code=[NSString stringWithFormat:@"%@",resDict[@"code"]];
        if([code isEqualToString:@"1"]){
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                self.signInArr=[SignInModel mj_objectArrayWithKeyValuesArray:resDict[@"list"]];
                SignInModel*model=[SignInModel new];
                model=self.signInArr[0];
                NSDate*signIntime=[NSDate dateWithTimeIntervalSince1970:model.time];
                NSDate*nowtime=[NSDate date];
                
                NSDateFormatter*formatter=[[NSDateFormatter alloc]init];
                [formatter setDateFormat:@"yyyyMMdd"];
                
                NSString*signIntimeString=[formatter stringFromDate:signIntime];
                
                NSString*nowtimeString=[formatter stringFromDate:nowtime];
                
                //比较当前时间和服务器返回的时间
                if([signIntimeString isEqualToString:nowtimeString]){
                    self.signItem.title=@"已签到";
                    self.signItem.enabled=NO;
                }else{
                    self.signItem.title=@"签到";
                    self.signItem.enabled=YES;
                }
                
            });
            
        }else if ([code isEqualToString:@"-1"]){
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
            });
        }
    }];
    
    [task resume];
    
}



-(void)updateCreditRequest{
    
    
   __block UserInfo *userInfo=[UserInfo shareUserInfo];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost/myshop/update_credit.php?user_id=%d",userInfo.userID]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod = @"GET";
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary*resDict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        NSLog(@"%@",resDict);
        NSLog(@"%@",resDict[@"code"]);
        NSString*code=[NSString stringWithFormat:@"%@",resDict[@"code"]];
        if([code isEqualToString:@"1"]){
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                userInfo.credit+=1;
                MBProgressHUD*hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode=MBProgressHUDModeText;
                hud.label.text=@"签到成功，积分+1";
                [hud hideAnimated:YES afterDelay:2];
                
            });
            
        }else if ([code isEqualToString:@"-1"]){
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
            });
        }
    }];
    
    [task resume];
    
}

-(void)signInRequest{
    
    UserInfo *userInfo=[UserInfo shareUserInfo];
    
    NSDate*date=[NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[date timeIntervalSince1970];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost/myshop/time.php?user_id=%d&time=%0.f",userInfo.userID,a]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod = @"GET";
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary*resDict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        NSLog(@"%@",resDict);
        NSLog(@"%@",resDict[@"code"]);
        NSString*code=[NSString stringWithFormat:@"%@",resDict[@"code"]];
        if([code isEqualToString:@"1"]){
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                MBProgressHUD*hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode=MBProgressHUDModeText;
                hud.label.text=@"签到成功，积分+1";
                [hud hideAnimated:YES afterDelay:2];
                
            });
            
        }else if ([code isEqualToString:@"-1"]){
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
            });
        }
    }];
    
    [task resume];
    
}


//全部订单按钮事件
- (IBAction)orderAction:(id)sender {
    [self.navigationController pushViewController:[OrderViewController new] animated:YES];
}

//兑换记录按钮事件
- (IBAction)recordAction:(id)sender {
    [self.navigationController pushViewController:[RecordViewController new] animated:YES];
}
- (IBAction)userInfoAction:(id)sender {
    [self.navigationController pushViewController:[UserInfoViewController new] animated:YES];
}

@end

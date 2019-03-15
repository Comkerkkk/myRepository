//
//  LoginViewController.m
//  枣
//
//  Created by Comker on 2019/1/17.
//  Copyright © 2019 Comker. All rights reserved.
//

#import "LoginViewController.h"
#import "MyViewController.h"
#import "RegisterViewController.h"
#import "UserModel.h"
#import "UserInfo.h"
#import <MBProgressHUD.h>
#import <MJExtension.h>
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UIButton *visiableBtn;
@property(nonatomic,strong)NSMutableArray*userInfoArr;
@end

@implementation LoginViewController
-(NSMutableArray*)userInfoArr{
    if(!_userInfoArr){
        _userInfoArr=[NSMutableArray array];
    }
    return _userInfoArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (IBAction)registerAction:(id)sender {
    RegisterViewController*registerVC=[[RegisterViewController alloc]init];
    UINavigationController*registerNav=[[UINavigationController alloc]initWithRootViewController:registerVC];
    registerVC.nameBlock = ^(NSString * _Nonnull name) {
        self.nameTF.text=name;
    };
    [self presentViewController:registerNav animated:YES completion:nil];
    
}


- (IBAction)loginAction:(id)sender {
    if(self.nameTF.text.length==0){
       MBProgressHUD*hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode=MBProgressHUDModeText;
        hud.label.text=@"请输入用户名";
        [hud hideAnimated:YES afterDelay:2];
    }else if (self.pwdTF.text.length==0){
        MBProgressHUD*hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode=MBProgressHUDModeText;
        hud.label.text=@"请输入密码";
        [hud hideAnimated:YES afterDelay:2];
    }else{
        [self loginRequest];
    }
}
- (IBAction)visibleAction:(UIButton*)sender {
    self.visiableBtn.selected=!self.visiableBtn.selected;
    self.pwdTF.secureTextEntry=!self.pwdTF.secureTextEntry;
}

-(void)loginRequest{
    
    NSString* userName= [self.nameTF.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString* pwd= [self.pwdTF.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost/myshop/login.php?username=%@&pwd=%@",userName,pwd]];

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
        __strong typeof(weakSelf) strongSelf=weakSelf;
        dispatch_async(dispatch_get_main_queue(), ^{
            
            MyViewController*vc=[[MyViewController alloc]init];
            [strongSelf presentViewController:vc animated:YES completion:nil];
            
            strongSelf.nameTF.text=@"";
            strongSelf.pwdTF.text=@"";
            strongSelf.pwdTF.secureTextEntry=YES;
            strongSelf.visiableBtn.selected=NO;
            
            strongSelf.userInfoArr=[UserModel mj_objectArrayWithKeyValuesArray:resDict[@"list"]];
            UserModel*model=[UserModel new];
            model=strongSelf.userInfoArr[0];
            
            //使用单例存放用户信息
            UserInfo*userInfo=[UserInfo shareUserInfo];
            userInfo.userID=model.id;
            userInfo.userName=model.userName;
            userInfo.credit=model.credit;
            userInfo.money=model.money;
        });
        
        
        
    }else if ([code isEqualToString:@"-1"]){
        __strong typeof(weakSelf) strongSelf=weakSelf;
        dispatch_async(dispatch_get_main_queue(), ^{
            
            MBProgressHUD*hud= [MBProgressHUD showHUDAddedTo:strongSelf.view animated:YES];
            hud.mode=MBProgressHUDModeText;
            hud.label.text=@"账号或密码错误";
            [hud hideAnimated:YES afterDelay:2];
        });
    }
}];

    [task resume];
    
}
@end

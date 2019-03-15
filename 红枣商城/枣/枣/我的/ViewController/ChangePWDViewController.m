//
//  ChangePWDViewController.m
//  枣
//
//  Created by Comker on 2019/2/10.
//  Copyright © 2019 Comker. All rights reserved.
//

#import "ChangePWDViewController.h"
#import "LoginViewController.h"
#import "UserInfo.h"
#import <MBProgressHUD.h>
@interface ChangePWDViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *oldpwdTF;
@property (weak, nonatomic) IBOutlet UITextField *newpwdTF;

@end

@implementation ChangePWDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"修改密码";
}

- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
    
}

//修改密码请求
-(void)changepwdRequest{
    UserInfo *userInfo=[UserInfo shareUserInfo];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost/myshop/update_pwd.php?user_id=%d&username=%@&oldpwd=%@&newpwd=%@",userInfo.userID,self.nameTF.text,self.oldpwdTF.text,self.newpwdTF.text]];
    
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
                
                [self dismissViewControllerAnimated:YES completion:nil];
            });
            
        }else if ([code isEqualToString:@"-1"]){
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                MBProgressHUD*hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode=MBProgressHUDModeText;
                hud.label.text=@"账号或密码错误";
                [hud hideAnimated:YES afterDelay:2];
            });
        }
    }];
    
    [task resume];
    
}

//修改密码按钮事件
- (IBAction)ChangeAction:(id)sender {
    
    //判断用户名是否为空
    if(self.nameTF.text.length==0){
        MBProgressHUD*hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode=MBProgressHUDModeText;
        hud.label.text=@"请输入用户名";
        [hud hideAnimated:YES afterDelay:2];
        
        //判断旧密码是否为空
    }else if (self.oldpwdTF.text.length==0){
        MBProgressHUD*hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode=MBProgressHUDModeText;
        hud.label.text=@"请输入旧密码";
        [hud hideAnimated:YES afterDelay:2];
        
        //判断新密码是否为空
    }else if(self.newpwdTF.text.length==0){
        MBProgressHUD*hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode=MBProgressHUDModeText;
        hud.label.text=@"请输入新密码";
        [hud hideAnimated:YES afterDelay:2];
    }else{
        [self changepwdRequest];
    }
    
}
@end

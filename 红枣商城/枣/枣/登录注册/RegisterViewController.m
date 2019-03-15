//
//  RegisterViewController.m
//  枣
//
//  Created by Comker on 2019/1/17.
//  Copyright © 2019 Comker. All rights reserved.
//

#import "RegisterViewController.h"
#import <MBProgressHUD.h>
@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UITextField *confirmTF;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"注册";
   
    UIBarButtonItem*backItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"czr_back"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction:)];

    self.navigationItem.leftBarButtonItem=backItem;
    
}
-(void)backAction:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)registerAction:(id)sender {
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
    }else if(self.confirmTF.text.length==0){
        MBProgressHUD*hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode=MBProgressHUDModeText;
        hud.label.text=@"请确认密码";
        [hud hideAnimated:YES afterDelay:2];
    }else if (![self.pwdTF.text isEqualToString:self.confirmTF.text]){
        MBProgressHUD*hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode=MBProgressHUDModeText;
        hud.label.text=@"请确保密码一致";
        [hud hideAnimated:YES afterDelay:2];
    }else{
        [self registerRequest];
    }
}

//注册请求
-(void)registerRequest{
    NSString*userName=[self.nameTF.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString*pwd=[self.pwdTF.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost/myshop/register.php?username=%@&pwd=%@",userName,pwd]];
    
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
                    hud.label.text=@"注册成功";
                    [hud hideAnimated:YES afterDelay:2];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if(self.nameBlock){
                        self.nameBlock(self.nameTF.text);
                    }
                [self dismissViewControllerAnimated:YES completion:nil];
                });
            });
            
            //注册账号已存在
        }else if ([code isEqualToString:@"-2"]){
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                MBProgressHUD*hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode=MBProgressHUDModeText;
                hud.label.text=@"账号已存在";
                [hud hideAnimated:YES afterDelay:2];
            });
        }
    }];
    
    [task resume];
    
}
@end

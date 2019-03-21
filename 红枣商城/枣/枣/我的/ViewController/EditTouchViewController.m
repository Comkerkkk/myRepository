//
//  EditTouchViewController.m
//  枣
//
//  Created by Comker on 2019/2/12.
//  Copyright © 2019 Comker. All rights reserved.
//

#import "EditTouchViewController.h"
#import "TELTool.h"
#import <MBProgressHUD.h>
@interface EditTouchViewController ()
@property (weak, nonatomic) IBOutlet UITextView *addrTextView;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *telTF;

@end

@implementation EditTouchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"修改收货信息";
    self.nameTF.text=self.name;
    self.telTF.text=self.tel;
    self.addrTextView.text=self.addr;
}

- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
    
}

//保存按钮事件
- (IBAction)saveAction:(id)sender {
    if(self.addrTextView.text.length==0){
        MBProgressHUD*hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode=MBProgressHUDModeText;
        hud.label.text=@"请输入收货地址";
        [hud hideAnimated:YES afterDelay:2];
    }
    else if(self.nameTF.text.length==0){
        MBProgressHUD*hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode=MBProgressHUDModeText;
        hud.label.text=@"请输入收货人姓名";
        [hud hideAnimated:YES afterDelay:2];
    }else if (self.telTF.text.length==0){
        MBProgressHUD*hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode=MBProgressHUDModeText;
        hud.label.text=@"请输入收货人电话";
        [hud hideAnimated:YES afterDelay:2];
    }else if (![TELTool isValidPhone:self.telTF.text]){
        MBProgressHUD*hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode=MBProgressHUDModeText;
        hud.label.text=@"请输入一个正确的电话号码";
        [hud hideAnimated:YES afterDelay:2];
    }else{
        [self updateTouchRequest:(NSString*)self.touch_id];
    }
    
}

//修改联系方式请求
-(void)updateTouchRequest:(NSString*)touch_id{
    NSString*name=[self.nameTF.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString*tel=[self.telTF.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString*addr=[self.addrTextView.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost/myshop/update_touch.php?id=%@&name=%@&tel=%@&addr=%@",touch_id,name,tel,addr]];
    
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
                
                [self.navigationController popViewControllerAnimated:YES];
            });
            
            
            
        }
    }];
    
    [task resume];
}


@end

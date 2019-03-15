//
//  AddTouchViewController.m
//  枣
//
//  Created by Comker on 2019/2/11.
//  Copyright © 2019 Comker. All rights reserved.
//

#import "AddTouchViewController.h"

#import "UserInfo.h"
#import <MBProgressHUD.h>
@interface AddTouchViewController ()
@property (weak, nonatomic) IBOutlet UITextView *addrTextView;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *telTF;

@end

@implementation AddTouchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"添加地址";
}

//添加按钮事件
- (IBAction)AddAction:(id)sender {
    
    //判断地址是否为空
    if(self.addrTextView.text.length==0){
        MBProgressHUD*hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode=MBProgressHUDModeText;
        hud.label.text=@"请输入收货地址";
        [hud hideAnimated:YES afterDelay:2];
    }
    //判断收货人是否为空
    else if(self.nameTF.text.length==0){
        MBProgressHUD*hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode=MBProgressHUDModeText;
        hud.label.text=@"请输入收货人姓名";
        [hud hideAnimated:YES afterDelay:2];
        
        //判断电话是否为空
    }else if (self.telTF.text.length==0){
        MBProgressHUD*hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode=MBProgressHUDModeText;
        hud.label.text=@"请输入收货人电话";
        [hud hideAnimated:YES afterDelay:2];
        
    }else if (![self isValidPhone:self.telTF.text]){
        MBProgressHUD*hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode=MBProgressHUDModeText;
        hud.label.text=@"请输入一个正确的电话号码";
        [hud hideAnimated:YES afterDelay:2];
    }
    else{
        [self AddTouchRequest];
    }
    
}

//添加联系方式请求
-(void)AddTouchRequest{
    UserInfo *userInfo=[UserInfo shareUserInfo];
    
    //中文使用utf-8进行网络请求，防止奔溃
    NSString*name=[self.nameTF.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString*tel=[self.telTF.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString*addr=[self.addrTextView.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost/myshop/add_touch.php?user_id=%i&name=%@&tel=%@&addr=%@",userInfo.userID,name,tel,addr]];
    
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
-(BOOL)isValidPhone:(NSString *)phone
{
    if (phone.length != 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:phone];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:phone];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:phone];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}
@end

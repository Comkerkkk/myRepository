//
//  RepurchaseViewController.m
//  枣
//
//  Created by Comker on 2019/2/13.
//  Copyright © 2019 Comker. All rights reserved.
//

#import "RepurchaseViewController.h"
#import "UserInfo.h"
#import "RepurchaseTableViewCell.h"
#import "GiftModel.h"
#import "ExchangeViewController.h"
#import <MJExtension.h>
#import <MBProgressHUD.h>

@interface RepurchaseViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIBarButtonItem*creditItem;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableArray*shopArray;

@end

@implementation RepurchaseViewController
-(NSMutableArray*)shopArray{
    if(_shopArray==nil){
        _shopArray=[NSMutableArray array];
    }
    return _shopArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"积分换购";
    
    [self layoutSubviews];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RepurchaseTableViewCell" bundle:nil] forCellReuseIdentifier:@"RepurchaseTableViewCell"];
    
    [self giftRequest];
}


//子控件布局，用于显示积分
-(void)layoutSubviews{
    UserInfo*userInfo=[UserInfo shareUserInfo];
    self.creditItem=[[UIBarButtonItem alloc]initWithTitle:[NSString stringWithFormat:@"我的积分:%i",userInfo.credit] style:UIBarButtonItemStyleDone target:self action:@selector(creditAction)];
    self.navigationItem.rightBarButtonItem=self.creditItem;
    self.creditItem.enabled=NO;
}

- (void)viewWillAppear:(BOOL)animated{
    [self layoutSubviews];
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
    
}

- (void)viewDidAppear:(BOOL)animated{
    [self giftRequest];
}

-(void)creditAction{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.shopArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 93;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RepurchaseTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"RepurchaseTableViewCell"];
    GiftModel*model=self.shopArray[indexPath.row];
    cell.iconImageView.image=[UIImage imageWithContentsOfFile:model.image];
    cell.nameLabel.text=model.giftName;
    cell.creditLabel.text=[NSString stringWithFormat:@"%i积分",model.credit];
    cell.stockLabel.text=[NSString stringWithFormat:@"还剩%i件",model.st];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    [cell.exchangeBtn addTarget:self action:@selector(exchangeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    objc_setAssociatedObject(cell.exchangeBtn, @"credit", [NSString stringWithFormat:@"%i",model.credit],OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(cell.exchangeBtn, @"image", [NSString stringWithFormat:@"%@",model.image],OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(cell.exchangeBtn, @"name", [NSString stringWithFormat:@"%@",model.giftName],OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(cell.exchangeBtn, @"id", [NSString stringWithFormat:@"%i",model.id],OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return  cell;
}



-(void)giftRequest{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost/myshop/gift.php"]];
    
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
            
            weakSelf.shopArray=[GiftModel mj_objectArrayWithKeyValuesArray:resDict[@"list"]];
            __strong typeof(weakSelf) strongSelf=weakSelf;
            dispatch_async(dispatch_get_main_queue(), ^{
                [strongSelf.tableView reloadData];
            });
            
        }
    }];
    
    [task resume];
}

//兑换按钮事件
-(void)exchangeAction:(id)sender{
    UserInfo*userInfo=[UserInfo shareUserInfo];
    NSString*credit= objc_getAssociatedObject(sender, @"credit");
    NSString*name= objc_getAssociatedObject(sender, @"name");
    NSString*image= objc_getAssociatedObject(sender, @"image");
    NSString*id= objc_getAssociatedObject(sender, @"id");
    if(userInfo.credit<credit.intValue){
        MBProgressHUD*hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode=MBProgressHUDModeText;
        hud.label.text=@"积分不足，无法兑换";
        [hud hideAnimated:YES afterDelay:2];
    }else{
        ExchangeViewController*vc=[ExchangeViewController new];
        vc.credit=credit;
        vc.name=name;
        vc.image=image;
        vc.gift_id=id;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

@end
